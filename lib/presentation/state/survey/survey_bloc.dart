import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/survey_section.dart';
import '../../../domain/entities/survey_submission.dart';
import '../../../domain/usecases/clear_survey_local_usecase.dart';
import '../../../domain/usecases/delete_pending_submission_usecase.dart';
import '../../../domain/usecases/get_surveys_usecase.dart';
import '../../../domain/usecases/save_survey_draft_usecase.dart';
import '../../../domain/usecases/load_survey_draft_usecase.dart';
import '../../../domain/usecases/finalize_to_pending_usecase.dart';
import '../../../domain/usecases/load_pending_submissions_usecase.dart';
import '../../../domain/usecases/send_pending_submissions_usecase.dart';
import '../../../domain/rules/survey_rules_engine.dart';
import '../../../domain/usecases/clear_survey_draft_usecase.dart';
import '../../../domain/usecases/consult_dinardap_usecase.dart';

import '../../widgets/ecuador_location_dropdown.dart';
import '../../utils/survey_section_filter_helper.dart';
import 'survey_event.dart';
import 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final GetSurveysUseCase getSurveysUseCase;
  final SaveSurveyDraftUseCase saveSurveyDraftUseCase;
  final LoadSurveyDraftUseCase loadSurveyDraftUseCase;
  final FinalizeToPendingUseCase finalizeToPendingUseCase;
  final LoadPendingSubmissionsUseCase loadPendingSubmissionsUseCase;
  final SendPendingSubmissionsUseCase sendPendingSubmissionsUseCase;
  final ClearSurveyLocalUseCase clearSurveyLocalUseCase;
  final DeletePendingSubmissionUseCase deletePendingSubmissionUseCase;
  final ClearSurveyDraftUseCase clearSurveyDraftUseCase;
  final ConsultDinardapUseCase consultDinardapUseCase;
  String? _lastDinardapCedula;

  SurveyBloc({
    required this.getSurveysUseCase,
    required this.saveSurveyDraftUseCase,
    required this.loadSurveyDraftUseCase,
    required this.finalizeToPendingUseCase,
    required this.loadPendingSubmissionsUseCase,
    required this.sendPendingSubmissionsUseCase,
    required this.clearSurveyLocalUseCase,
    required this.deletePendingSubmissionUseCase,
    required this.clearSurveyDraftUseCase,
    required this.consultDinardapUseCase,
  }) : super(SurveyState.initial()) {
    on<SurveyLoadRequested>(_onLoad);
    on<SurveyAnswerChanged>(_onAnswerChanged);
    on<SurveyPrevPageRequested>(_onPrevPage);
    on<SurveyNextPageRequested>(_onNextPage);
    on<SurveyJumpToPageRequested>(_onJumpToPage);
    on<SurveyFinalizeRequested>(_onFinalize);
    on<SendPendingSubmissions>(_onSendPending);
    on<SurveyClearLocalRequested>(_onClearLocal);
    on<DeletePendingSubmissionRequested>(_onDeletePending);
    on<SurveyClearDraftRequested>(_onClearDraft);
    on<SurveyCedulaCompleted>(_onCedulaCompleted);
  }

  Future<List<SurveySubmission>> loadRegisteredSubmissions(String surveyId) {
    return loadPendingSubmissionsUseCase(surveyId);
  }

  Future<void> _onLoad(
    SurveyLoadRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(state.copyWith(status: SurveyStatus.loading, message: null));

    try {
      final surveys = await getSurveysUseCase();
      final active = surveys.isNotEmpty ? surveys.first : null;

      if (active == null) {
        emit(
          state.copyWith(
            status: SurveyStatus.failure,
            message: 'No hay encuestas disponibles.',
          ),
        );
        return;
      }

      final draft = await loadSurveyDraftUseCase(active.id);

      emit(
        state.copyWith(
          status: SurveyStatus.ready,
          surveys: surveys,
          activeSurvey: active,
          answers: draft?.answers ?? {},
          pageIndex: 0,
          message: draft != null
              ? 'Borrador cargado desde almacenamiento local.'
              : null,
          showValidationErrors: false,
          invalidQuestionIds: const [],
          firstInvalidQuestionId: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: SurveyStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onAnswerChanged(
    SurveyAnswerChanged event,
    Emitter<SurveyState> emit,
  ) async {
    final survey = state.activeSurvey;
    if (survey == null) return;

    final newAnswers = Map<String, dynamic>.from(state.answers);
    newAnswers[event.questionId] = event.value;

    if (event.questionId == 'nroDocumentoM') {
      final v = _onlyDigits((event.value ?? '').toString());
      if (v.length < 10) {
        _lastDinardapCedula = null;

        // ✅ Limpiar campos poblados por DINARDAP
        final fieldsToRemove = state.dinardapPopulatedFields.toList();
        for (final field in fieldsToRemove) {
          newAnswers.remove(field);
        }

        // ✅ si el user está editando, quita error y apaga loading
        emit(
          state.copyWith(
            isDinardapLoading: false,
            dinardapError: null,
            message: null,
            answers: newAnswers,
            dinardapPopulatedFields: const {}, // Limpiar conjunto
          ),
        );

        return;
      }
    }

    // Limpieza de dependencias (si aplica a tu encuesta)
    if (event.questionId == '1' && event.value != '3') {
      newAnswers.remove('2');
    }

    emit(state.copyWith(answers: newAnswers, message: null));

    // Guardar borrador (offline)
    final now = DateTime.now();
    final draft = SurveySubmission(
      surveyId: survey.id,
      createdAt: now,
      updatedAt: now,
      answers: newAnswers,
      status: SubmissionStatus.draft,
      attempts: 0,
      lastError: null,
    );

    try {
      await saveSurveyDraftUseCase(draft);
      // ✅ Actualizar timestamp de guardado
      emit(state.copyWith(lastSavedAt: DateTime.now()));
    } catch (_) {}
  }

  void _onPrevPage(SurveyPrevPageRequested event, Emitter<SurveyState> emit) {
    if (state.pageIndex <= 0) return;

    final allSections = surveySectionsOrder;
    int prevIndex = state.pageIndex - 1;

    // Retroceder hasta encontrar una sección visible
    while (prevIndex >= 0) {
      final section = allSections[prevIndex];
      if (SurveySectionFilterHelper.shouldShowSection(section, state.answers)) {
        break;
      }
      prevIndex--;
    }

    if (prevIndex < 0) prevIndex = 0;

    emit(
      state.copyWith(
        pageIndex: prevIndex,
        message: null,
        showValidationErrors: false,
        invalidQuestionIds: const [],
        firstInvalidQuestionId: null,
      ),
    );
  }

  void _onJumpToPage(
    SurveyJumpToPageRequested event,
    Emitter<SurveyState> emit,
  ) {
    final targetIndex = event.pageIndex.clamp(
      0,
      surveySectionsOrder.length - 1,
    );
    emit(
      state.copyWith(
        pageIndex: targetIndex,
        message: null,
        showValidationErrors: false,
        invalidQuestionIds: const [],
        firstInvalidQuestionId: null,
      ),
    );
  }

  void _onNextPage(SurveyNextPageRequested event, Emitter<SurveyState> emit) {
    final survey = state.activeSurvey;
    if (survey == null) return;

    final engine = SurveyRulesEngine();
    final currentSection = surveySectionsOrder[state.pageIndex];

    final errors = engine.validateSection(
      survey,
      currentSection,
      state.answers,
    );

    // ⚠️ VALIDACIÓN DESACTIVADA TEMPORALMENTE POR SOLICITUD DEL USUARIO (MODO PRUEBAS)
    // Cuando se quiera reactivar, descomentar el bloque siguiente:
    /*
    if (errors.isNotEmpty) {
      final ids = errors.map((e) => e.questionId).toList();
      final targetId =
          errors.first.questionId; // ✅ SIEMPRE el primero (arriba->abajo)

      emit(
        state.copyWith(
          showValidationErrors: true,
          invalidQuestionIds: ids,
          firstInvalidQuestionId: targetId,
          message: 'Faltan campos obligatorios por completar.',
        ),
      );
      return; // NO avanzar
    }
    */

    // Calcular la siguiente sección visible
    int nextIndex = state.pageIndex + 1;
    final allSections = surveySectionsOrder;

    while (nextIndex < allSections.length) {
      final section = allSections[nextIndex];
      if (SurveySectionFilterHelper.shouldShowSection(section, state.answers)) {
        break;
      }
      nextIndex++;
    }

    // Si nos pasamos, nos quedamos en la última visible (o la actual)
    if (nextIndex >= allSections.length) {
      nextIndex = state.pageIndex;
    }

    emit(
      state.copyWith(
        pageIndex: nextIndex,
        showValidationErrors: false,
        invalidQuestionIds: const [],
        firstInvalidQuestionId: null,
        message: null,
      ),
    );
  }

  Future<void> _onFinalize(
    SurveyFinalizeRequested event,
    Emitter<SurveyState> emit,
  ) async {
    final survey = state.activeSurvey;
    if (survey == null) return;

    // ✅ NO VALIDAR - La validación ya se hizo página por página
    // Solo enviar la encuesta tal como está

    // Limpiar cualquier mensaje de error previo
    emit(
      state.copyWith(
        showValidationErrors: false,
        invalidQuestionIds: const [],
        firstInvalidQuestionId: null,
        message: null,
      ),
    );

    emit(state.copyWith(status: SurveyStatus.submitting, message: null));

    try {
      final now = DateTime.now();
      final pending = SurveySubmission(
        surveyId: survey.id,
        createdAt: now,
        updatedAt: now,
        answers: state.answers,
        status: SubmissionStatus.pending,
        attempts: 0,
        lastError: null,
      );

      await finalizeToPendingUseCase(pending);

      // ✅ LIMPIAR borrador y formulario al finalizar (lo que pediste)
      await clearSurveyDraftUseCase(survey.id);

      emit(
        state.copyWith(
          answers: {}, // limpia formulario
          pageIndex: 0, // vuelve a la primera sección
          showValidationErrors: false,
          invalidQuestionIds: const [],
          firstInvalidQuestionId: null,
          status: SurveyStatus.success,
          message: 'Encuesta guardada y formulario reiniciado.',
        ),
      );

      // deja ready si sigues en la misma pantalla
      emit(state.copyWith(status: SurveyStatus.ready));
    } catch (e) {
      emit(state.copyWith(status: SurveyStatus.failure, message: e.toString()));
      emit(state.copyWith(status: SurveyStatus.ready));
    }
  }

  Future<void> _onSendPending(
    SendPendingSubmissions event,
    Emitter<SurveyState> emit,
  ) async {
    if (event.selectedCreatedAtIso.isEmpty) {
      emit(
        state.copyWith(
          isSending: false,
          message: 'Selecciona al menos una encuesta para sincronizar.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSending: true,
        sendError: null,
        message:
            'Sincronizando ${event.selectedCreatedAtIso.length} encuesta(s)...',
      ),
    );

    try {
      await sendPendingSubmissionsUseCase(
        event.surveyId,
        selectedCreatedAtIso: event.selectedCreatedAtIso,
      );

      emit(
        state.copyWith(
          isSending: false,
          message: 'Sincronización completada ✅',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSending: false,
          sendError: e.toString(),
          message: 'Error al sincronizar: $e',
        ),
      );
    }
  }

  Future<void> _onClearLocal(
    SurveyClearLocalRequested event,
    Emitter<SurveyState> emit,
  ) async {
    final survey = state.activeSurvey;
    if (survey == null) return;

    await clearSurveyLocalUseCase(survey.id);

    emit(
      state.copyWith(
        answers: {},
        pageIndex: 0,
        message: 'Encuesta borrada del almacenamiento local.',
        showValidationErrors: false,
        invalidQuestionIds: const [],
        firstInvalidQuestionId: null,
      ),
    );

    add(const SurveyLoadRequested());
  }

  Future<void> _onDeletePending(
    DeletePendingSubmissionRequested event,
    Emitter<SurveyState> emit,
  ) async {
    try {
      await deletePendingSubmissionUseCase(
        surveyId: event.surveyId,
        createdAtIso: event.createdAtIso,
      );
      emit(state.copyWith(message: 'Encuesta eliminada.'));
    } catch (e) {
      emit(state.copyWith(message: 'No se pudo eliminar: $e'));
    }
  }

  Future<void> _onClearDraft(
    SurveyClearDraftRequested event,
    Emitter<SurveyState> emit,
  ) async {
    final survey = state.activeSurvey;
    if (survey == null) return;

    await clearSurveyDraftUseCase(survey.id);

    emit(
      state.copyWith(
        answers: {},
        pageIndex: 0,
        message: 'Encuesta en proceso reiniciada (borrador eliminado).',
        showValidationErrors: false,
        invalidQuestionIds: const [],
        firstInvalidQuestionId: null,
      ),
    );
  }

  String? _toIsoDateFromDdMmYyyy(String? ddmmyyyy) {
    if (ddmmyyyy == null || ddmmyyyy.trim().isEmpty) return null;
    final parts = ddmmyyyy.split('/');
    if (parts.length != 3) return null;
    final dd = parts[0].padLeft(2, '0');
    final mm = parts[1].padLeft(2, '0');
    final yyyy = parts[2].padLeft(4, '0');
    return '$yyyy-$mm-$dd'; // tu UI usa DateTime.tryParse(ISO)
  }

  void _fillNames(Map<String, dynamic> answers, String full) {
    final s = full.trim();
    if (s.isEmpty) return;

    final parts = s.split(RegExp(r'\s+'));
    if (parts.length >= 4) {
      answers['Apellidos'] = '${parts[0]} ${parts[1]}';
      answers['Nombres'] = parts.sublist(2).join(' ');
    } else if (parts.length == 3) {
      answers['Apellidos'] = parts[0];
      answers['Nombres'] = '${parts[1]} ${parts[2]}';
    } else if (parts.length == 2) {
      answers['Apellidos'] = parts[0];
      answers['Nombres'] = parts[1];
    } else {
      answers['Nombres'] = s;
    }
  }

  Future<void> _onCedulaCompleted(
    SurveyCedulaCompleted event,
    Emitter<SurveyState> emit,
  ) async {
    final cedulaRaw = event.cedula.trim();
    final cedula = _onlyDigits(cedulaRaw);

    if (cedula.length != 10) return;

    // ✅ valida local antes de llamar al WS
    if (!_isValidCedulaEc(cedula)) {
      _lastDinardapCedula = null;
      emit(
        state.copyWith(
          isDinardapLoading: false,
          dinardapError: 'Cédula inválida. Verifica el número.',
          message: null,
        ),
      );
      return;
    }

    // evita consultas repetidas
    if (_lastDinardapCedula == cedula) return;

    emit(
      state.copyWith(
        isDinardapLoading: true,
        dinardapError: null,
        message: null,
      ),
    );

    try {
      final person = await consultDinardapUseCase(cedula: cedula);
      _lastDinardapCedula = cedula;

      // 🔍 DEBUG LOGS
      print('--- DINARDAP DEBUG ---');
      print('Nombres: ${person.nombresCompletos}');
      print('Sexo RAW: ${person.sexo}');
      print('EstadoCivil RAW: ${person.estadoCivil}');
      print('Domicilio RAW: ${person.domicilio}');
      print('Nacionalidad RAW: ${person.nacionalidad}');
      print('FechaNac RAW: ${person.fechaNacimientoDdMmYyyy}');
      print('----------------------');

      final newAnswers = Map<String, dynamic>.from(state.answers);
      final populatedFields = <String>{};

      // Asegurar carga de geo
      await EcuadorGeoStore.I.ensureLoaded();

      final nac = (person.nacionalidad ?? '').toUpperCase().trim();
      if (nac.contains('ECUATOR')) {
        newAnswers['idNacionalidadM'] = '1';
        populatedFields.add('idNacionalidadM');
      } else if (nac.isNotEmpty) {
        newAnswers['idNacionalidadM'] = '2';
        populatedFields.add('idNacionalidadM');
      }

      // Sexo
      final sexoId = _mapDinardapSexo(person.sexo);
      if (sexoId != null) {
        newAnswers['idSexoM'] = sexoId;
        populatedFields.add('idSexoM');
      }

      // Estado Civil
      final civilId = _mapDinardapEstadoCivil(person.estadoCivil);
      if (civilId != null) {
        newAnswers['idEstadoCivilM'] = civilId;
        populatedFields.add('idEstadoCivilM');
      }

      // Fecha Nacimiento
      final iso = _toIsoDateFromDdMmYyyy(person.fechaNacimientoDdMmYyyy);
      if (iso != null) {
        newAnswers['fechaNacimientoM'] = iso;
        populatedFields.add('fechaNacimientoM');
      }

      // Nombres
      final full = (person.nombresCompletos ?? '').trim();
      if (full.isNotEmpty) {
        _fillNames(newAnswers, full);
        populatedFields.add('Nombres');
        populatedFields.add('Apellidos');
      }

      // Ubicación (Domicilio: PROVINCIA/CANTON/PARROQUIA)
      final dom = person.domicilio;
      if (dom != null && dom.isNotEmpty) {
        final parts = dom.split('/');
        if (parts.isNotEmpty) {
          final provName = parts[0];
          final provId = EcuadorGeoStore.I.findProvinceIdByName(provName);

          if (provId != null) {
            newAnswers['idProvinciaM'] = provId;
            populatedFields.add('idProvinciaM');

            if (parts.length > 1) {
              final cantonName = parts[1];
              final cantonId = EcuadorGeoStore.I.findCantonIdByName(
                int.parse(provId),
                cantonName,
              );

              if (cantonId != null) {
                newAnswers['idCantonM'] = cantonId;
                populatedFields.add('idCantonM');

                if (parts.length > 2) {
                  final parishName = parts[2];
                  final parishId = EcuadorGeoStore.I.findParishIdByName(
                    int.parse(provId),
                    int.parse(cantonId),
                    parishName,
                  );

                  // Si encontramos la parroquia, la asignamos y bloqueamos.
                  // Si NO la encontramos (ej. VILLAFLORA), no asignamos nada y queda desbloqueada.
                  if (parishId != null) {
                    newAnswers['idParroquiaM'] = parishId;
                    populatedFields.add('idParroquiaM');
                  }
                }
              }
            }
          }
        }
      }

      emit(
        state.copyWith(
          answers: newAnswers,
          isDinardapLoading: false,
          dinardapError: null,
          message: null,
          dinardapPopulatedFields: populatedFields,
        ),
      );
    } catch (e) {
      // ✅ mensaje amigable
      emit(
        state.copyWith(
          isDinardapLoading: false,
          dinardapError: _friendlyDinardapError(e),
          message: null, // evita snackbar molesta
        ),
      );
    }
  }

  String _onlyDigits(String s) => s.replaceAll(RegExp(r'\D'), '');

  bool _isValidCedulaEc(String input) {
    final ced = _onlyDigits(input);
    if (ced.length != 10) return false;

    final province = int.tryParse(ced.substring(0, 2)) ?? -1;
    if (province < 1 || province > 24) return false;

    final third = int.tryParse(ced.substring(2, 3)) ?? -1;
    if (third < 0 || third > 5) return false;

    final digits = ced.split('').map((e) => int.parse(e)).toList();
    final verifier = digits[9];

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      int v = digits[i];
      if (i % 2 == 0) {
        // posiciones impares (0-based)
        v *= 2;
        if (v > 9) v -= 9;
      }
      sum += v;
    }

    final mod = sum % 10;
    final check = (mod == 0) ? 0 : (10 - mod);
    return check == verifier;
  }

  String _friendlyDinardapError(Object e) {
    final msg = e.toString().toUpperCase();

    if (msg.contains('CEDULA INVALIDA') || msg.contains('CÉDULA INVALIDA')) {
      return 'Cédula inválida (DINARDAP). Verifica el número.';
    }

    // errores comunes de auth / red
    if (msg.contains('NO HAY CREDENCIALES')) {
      return 'No hay credenciales guardadas. Inicia sesión nuevamente.';
    }
    if (msg.contains('SOCKET') ||
        msg.contains('TIMED OUT') ||
        msg.contains('TIMEOUT')) {
      return 'Tiempo de espera agotado consultando DINARDAP. Intenta otra vez.';
    }

    return 'No se pudo consultar DINARDAP. ${e.toString()}';
  }

  String? _mapDinardapSexo(String? sexo) {
    if (sexo == null) return null;
    final s = sexo.toUpperCase().trim();
    if (s == 'HOMBRE') return '2'; // 2 = Masculino
    if (s == 'MUJER') return '1'; // 1 = Femenino
    return null;
  }

  String? _mapDinardapEstadoCivil(String? estado) {
    if (estado == null) return null;
    final s = estado.toUpperCase().trim();
    // 1=Soltero, 2=Casado, 3=Separado, 4=Divorciado, 5=Viudo, 6=Unión Libre
    if (s.contains('SOLTER')) return '1';
    if (s.contains('CASAD')) return '2';
    if (s.contains('SEPARA')) return '3';
    if (s.contains('DIVORC')) return '4';
    if (s.contains('VIUD')) return '5';
    if (s.contains('UNION')) return '6';
    return null;
  }

  Future<SurveySubmission?> loadDraftNow(String surveyId) {
    return loadSurveyDraftUseCase(surveyId);
  }

  Future<List<SurveySubmission>> loadPendingNow(String surveyId) {
    return loadPendingSubmissionsUseCase(surveyId);
  }

  Future<dynamic> consultDinardapNow(String cedula) {
    return consultDinardapUseCase(cedula: cedula);
  }
}
