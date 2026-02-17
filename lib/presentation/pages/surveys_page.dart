import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/survey.dart';
import '../../domain/entities/survey_section.dart';
import '../../domain/entities/input_constraints.dart';
import '../../domain/entities/survey_submission.dart';
import '../../domain/rules/survey_rules_engine.dart';

import '../widgets/app_drawer.dart';
import '../state/survey/survey_bloc.dart';
import '../state/survey/survey_event.dart';
import '../state/survey/survey_state.dart';

import '../widgets/ecuador_location_dropdown.dart';
import '../utils/survey_input_styles.dart';
import '../widgets/household_members_question.dart';
import 'survey_submission_summary_page.dart';
import '../utils/survey_section_filter_helper.dart';
import '../utils/question_progress_helper.dart';

class SurveysPage extends StatefulWidget {
  const SurveysPage({super.key});

  @override
  State<SurveysPage> createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> {
  static const _rules = SurveyRulesEngine();

  final ScrollController _scroll = ScrollController();
  final Map<String, GlobalKey> _questionKeys = {};

  int? _lastPageIndex;
  bool _isEditingFromSummary = false; // ✅ Nueva bandera

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  List<Question> _questionsForPage(List<Question> all, int pageIndex) {
    final section = surveySectionsOrder[pageIndex];
    return all.where((q) => q.section == section).toList();
  }

  /// Calcula las secciones visibles según la edad del encuestado
  List<SurveySection> _getVisibleSections(Map<String, dynamic> answers) {
    return SurveySectionFilterHelper.getVisibleSections(
      surveySectionsOrder,
      answers,
    );
  }

  bool _isAnswered(Question q, dynamic answer) {
    switch (q.type) {
      case QuestionType.dropdown:
      case QuestionType.singleChoice:
        return answer != null && answer.toString().trim().isNotEmpty;

      case QuestionType.multiChoice:
        return answer is List && answer.isNotEmpty;

      case QuestionType.textShort:
      case QuestionType.textLong:
        return answer is String && answer.trim().isNotEmpty;

      case QuestionType.date:
        return answer is String && answer.trim().isNotEmpty;

      case QuestionType.yesNo:
        // lo tratamos como singleChoice '1'/'0'
        return answer is String && (answer == '1' || answer == '0');

      case QuestionType.householdMembers:
        if (answer == null) return false;
        if (answer is String) {
          final t = answer.trim();
          if (t.isEmpty) return false;
          try {
            final decoded = jsonDecode(t);
            return decoded is List && decoded.isNotEmpty;
          } catch (_) {
            return false;
          }
        }
        return false;
    }
  }

  Future<void> _scrollToQuestion(String questionId) async {
    final key = _questionKeys[questionId];
    final ctx = key?.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  // ===== DEBUG HELPERS =====

  String _typeLabel(QuestionType t) {
    switch (t) {
      case QuestionType.singleChoice:
        return 'singleChoice';
      case QuestionType.yesNo:
        return 'yesNo';
      case QuestionType.dropdown:
        return 'dropdown';
      case QuestionType.multiChoice:
        return 'multiChoice';
      case QuestionType.textShort:
        return 'textShort';
      case QuestionType.textLong:
        return 'textLong';
      case QuestionType.date:
        return 'date';
      case QuestionType.householdMembers:
        return 'householdMembers';
    }
  }

  String _formatDisplayedAnswer(Question q, dynamic answer) {
    if (answer == null) return '(null)';

    // MultiChoice: lista de ids -> labels
    if (q.type == QuestionType.multiChoice) {
      final ids = (answer is List)
          ? answer.map((e) => e.toString()).toList()
          : answer
                .toString()
                .split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();

      if (ids.isEmpty) return '[]';

      final labels = ids.map((id) {
        final opt = q.options.where((o) => o.id == id).toList();
        return opt.isNotEmpty ? '${id}:${opt.first.label}' : id;
      }).toList();

      return '[${labels.join(', ')}]';
    }

    // Dropdown / SingleChoice / YesNo: id -> label si existe
    if (q.type == QuestionType.dropdown ||
        q.type == QuestionType.singleChoice ||
        q.type == QuestionType.yesNo) {
      final id = answer.toString();
      final opt = q.options.where((o) => o.id == id).toList();
      if (opt.isNotEmpty) return '$id:${opt.first.label}';
      return id;
    }

    // Date / Text
    return answer.toString();
  }

  String _formatRawAnswer(dynamic answer) {
    if (answer == null) return 'null';
    if (answer is List)
      return jsonEncode(answer.map((e) => e.toString()).toList());
    return answer.toString();
  }

  void _openDebugSheet({required Survey survey, required SurveyState state}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final allQuestions = survey.questions;

        // Importante: dar altura para que el Column + Expanded no falle.
        final h = MediaQuery.of(ctx).size.height * 0.90;

        return SizedBox(
          height: h,
          child: _SurveyDebugSheet(
            surveyId: survey.id,
            pageIndex: state.pageIndex,
            section: surveySectionsOrder[state.pageIndex],
            questions: allQuestions,
            answers: state.answers,
            typeLabel: _typeLabel,
            formatDisplayed: _formatDisplayedAnswer,
            formatRaw: _formatRawAnswer,
          ),
        );
      },
    );
  }

  Future<void> _showSummary() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<SurveyBloc>(),
          child: const SurveySubmissionSummaryPage(),
        ),
      ),
    );

    if (result is int && mounted) {
      setState(() {
        _isEditingFromSummary = true;
      });
      context.read<SurveyBloc>().add(
        SurveyJumpToPageRequested(pageIndex: result, validate: true),
      );
    }
  }

  // ===== UI =====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: BlocBuilder<SurveyBloc, SurveyState>(
          buildWhen: (p, c) => p.lastSavedAt != c.lastSavedAt,
          builder: (context, state) {
            if (state.lastSavedAt == null) {
              return const Text('Encuesta');
            }

            final elapsed = DateTime.now().difference(state.lastSavedAt!);
            String timeText;
            if (elapsed.inSeconds < 10) {
              timeText = 'Guardado ahora';
            } else if (elapsed.inMinutes < 1) {
              timeText = 'Guardado hace ${elapsed.inSeconds}s';
            } else if (elapsed.inMinutes < 60) {
              timeText = 'Guardado hace ${elapsed.inMinutes}min';
            } else {
              timeText = 'Guardado hace ${elapsed.inHours}h';
            }

            return Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Encuesta'),
                  const SizedBox(width: 8),
                  Icon(Icons.check_circle, color: Colors.green[300], size: 16),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      timeText,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green[300],
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<SurveyBloc>().add(const SurveyLoadRequested()),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Reiniciar encuesta',
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Reiniciar encuesta'),
                  content: const Text(
                    'Se borrará el borrador (encuesta en proceso) guardado en este dispositivo.\n\n¿Desea continuar?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Sí, borrar'),
                    ),
                  ],
                ),
              );
              if (ok == true) {
                context.read<SurveyBloc>().add(
                  const SurveyClearDraftRequested(),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Debug respuestas',
            onPressed: () {
              final state = context.read<SurveyBloc>().state;
              final survey = state.activeSurvey;
              if (survey == null) return;
              _openDebugSheet(survey: survey, state: state);
            },
          ),
        ],
      ),
      body: BlocConsumer<SurveyBloc, SurveyState>(
        listenWhen: (prev, curr) {
          // Evita que el listener corra por cada tecla.
          if (prev.message != curr.message) return true;
          if (prev.status != curr.status) return true;
          if (prev.pageIndex != curr.pageIndex) return true;
          if (prev.firstInvalidQuestionId != curr.firstInvalidQuestionId)
            return true;
          if (prev.showValidationErrors != curr.showValidationErrors)
            return true;
          return false;
        },
        listener: (context, state) {
          if (state.message != null && state.message!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message!,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: AppColors.primary,
              ),
            );
          }

          if (state.status == SurveyStatus.success) {
            Navigator.pushReplacementNamed(context, '/registered_surveys');
            return;
          }

          // Mostrar error si falla el envío
          if (state.status == SurveyStatus.failure && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error al enviar encuesta: ${state.message}',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          }

          // Si cambió de sección -> ir al inicio
          if (_lastPageIndex != state.pageIndex) {
            _lastPageIndex = state.pageIndex;
            _questionKeys.clear();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scroll.hasClients) _scroll.jumpTo(0);
            });
          }

          // Scroll SOLO cuando el Bloc decide a qué pregunta ir (Siguiente/Finalizar)
          if (state.showValidationErrors &&
              state.firstInvalidQuestionId != null) {
            final target = state.firstInvalidQuestionId!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToQuestion(target);
            });
          }
        },
        builder: (context, state) {
          if (state.status == SurveyStatus.loading ||
              state.status == SurveyStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          final survey = state.activeSurvey;
          if (survey == null) {
            return const Center(child: Text('No hay encuestas disponibles.'));
          }

          final section = surveySectionsOrder[state.pageIndex];

          final pageQuestions = _questionsForPage(
            survey.questions,
            state.pageIndex,
          ).where((q) => _rules.isVisible(q, state.answers)).toList();

          // keys para scroll
          for (final q in pageQuestions) {
            _questionKeys.putIfAbsent(q.id, () => GlobalKey());
          }

          // Marcar errores en tiempo real: recalcular cuáles siguen sin responder
          final missingIds = <String>{};
          if (state.showValidationErrors) {
            // Recalcular desde los IDs originales del Bloc, pero verificar cuáles SIGUEN vacíos
            for (final qId in state.invalidQuestionIds) {
              final question = pageQuestions.cast<Question?>().firstWhere(
                (q) => q?.id == qId,
                orElse: () => null,
              );

              if (question != null) {
                final ans = state.answers[qId];
                final emptyText = ans is String && ans.trim().isEmpty;
                final emptyList = ans is List && ans.isEmpty;

                // Solo agregar si SIGUE sin respuesta
                if (ans == null || emptyText || emptyList) {
                  missingIds.add(qId);
                }
              }
            }
          }

          final bottomSafe = MediaQuery.of(context).viewPadding.bottom;

          // ========================================
          // STACK PARA OVERLAY DE CARGA
          // ========================================
          return Stack(
            children: [
              Column(
                children: [
                  // ========================================
                  // HEADER STICKY (Título + Barra de Progreso)
                  // ========================================
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de la sección
                        Builder(
                          builder: (context) {
                            final visibleSections = _getVisibleSections(
                              state.answers,
                            );
                            final currentIndexInVisible = visibleSections
                                .indexOf(section);
                            final displayIndex = currentIndexInVisible >= 0
                                ? currentIndexInVisible + 1
                                : state.pageIndex + 1;

                            return Text(
                              '${section.title} ($displayIndex de ${visibleSections.length})',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // ========================================
                        // BARRA DE PROGRESO (basada en PREGUNTAS VISIBLES)
                        // ========================================
                        Builder(
                          builder: (context) {
                            final visibleSections = _getVisibleSections(
                              state.answers,
                            );
                            final totalVisible =
                                QuestionProgressHelper.countVisibleQuestions(
                                  survey.questions,
                                  state.answers,
                                  _rules,
                                  visibleSections,
                                );
                            final answeredVisible =
                                QuestionProgressHelper.countAnsweredVisibleQuestions(
                                  survey.questions,
                                  state.answers,
                                  _rules,
                                  visibleSections,
                                );
                            final progress = totalVisible > 0
                                ? answeredVisible / totalVisible
                                : 0.0;
                            final percentage = (progress * 100).round();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Progreso general',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '$answeredVisible / $totalVisible preguntas',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.grey[300],
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          AppColors.primary,
                                        ),
                                    minHeight: 10,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$percentage% completado',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                      ],
                    ),
                  ),

                  // ========================================
                  // CONTENIDO SCROLLABLE (Preguntas)
                  // ========================================
                  Expanded(
                    child: ListView(
                      controller: _scroll,
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomSafe),
                      children: [
                        for (final q in pageQuestions) ...[
                          KeyedSubtree(
                            key: ValueKey('q_${q.id}'),
                            child: _QuestionCard(
                              key: _questionKeys[q.id],
                              question: q,
                              requiredNow: _rules.isRequired(q, state.answers),
                              markError: missingIds.contains(q.id),
                              // Ya no necesitamos spinner inline aquí si usamos overlay,
                              // pero lo mantenemos por si acaso o lo quitamos.
                              // Lo dejaremos false para evitar duplicidad visual si está el overlay.
                              isInlineLoading: false,
                              inlineError: q.id == 'nroDocumentoM'
                                  ? state.dinardapError
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        const SizedBox(height: 8),
                        _WizardButtons(
                          pageIndex: state.pageIndex,
                          answers: state.answers,
                          isEditingFromSummary: _isEditingFromSummary,
                          onReturnToSummary: _showSummary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 🔄 OVERLAY DE CARGA (DINARDAP)
              if (state.isDinardapLoading)
                Container(
                  color: Colors.black45,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text(
                            'Consultando información...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _WizardButtons extends StatelessWidget {
  final int pageIndex;
  final Map<String, dynamic> answers;
  final bool isEditingFromSummary;
  final VoidCallback? onReturnToSummary;

  const _WizardButtons({
    required this.pageIndex,
    required this.answers,
    this.isEditingFromSummary = false,
    this.onReturnToSummary,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurveyBloc>();

    // Si venimos del resumen, el botón "siguiente" se convierte en "Volver al Resumen"
    // o "Guardar y Volver", y debe guardar el progreso antes de volver.
    if (isEditingFromSummary) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onReturnToSummary,
          icon: const Icon(Icons.check),
          label: const Text('Guardar y Volver al Resumen'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[700],
            foregroundColor: Colors.white,
          ),
        ),
      );
    }

    final visibleSections = SurveySectionFilterHelper.getVisibleSections(
      surveySectionsOrder,
      answers,
    );
    final lastVisibleSection = visibleSections.isNotEmpty
        ? visibleSections.last
        : surveySectionsOrder.last;
    final lastPageIndex = surveySectionsOrder.indexOf(lastVisibleSection);

    // Si estamos en la última sección absoluta (PCD), forzar lastPage
    // O si el índice actual supera/iguala al último visible
    final isLastPage =
        (pageIndex >= surveySectionsOrder.length - 1) ||
        (pageIndex >= lastPageIndex);

    if (pageIndex == 0 && !isLastPage) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => bloc.add(const SurveyNextPageRequested()),
          child: const Text('Siguiente'),
        ),
      );
    }

    if (isLastPage) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => bloc.add(const SurveyPrevPageRequested()),
              child: const Text('Atrás'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: onReturnToSummary,
              child: const Text('Ver Resumen'),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => bloc.add(const SurveyPrevPageRequested()),
            child: const Text('Atrás'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => bloc.add(const SurveyNextPageRequested()),
            child: const Text('Siguiente'),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Question question;
  final bool requiredNow;
  final bool markError;

  // ✅ nuevos
  final bool isInlineLoading;
  final String? inlineError;

  const _QuestionCard({
    super.key,
    required this.question,
    required this.requiredNow,
    required this.markError,
    this.isInlineLoading = false,
    this.inlineError,
  });

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: markError ? AppColors.error : Colors.transparent,
      width: 1.5,
    );

    return Card(
      color: AppColors.secondary, // ✅ Fondo beige claro para cards
      shape: RoundedRectangleBorder(
        side: borderSide,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ título + spinner pequeño a la derecha
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    requiredNow ? '${question.title} *' : question.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: markError ? AppColors.error : Colors.black,
                    ),
                  ),
                ),
                if (isInlineLoading) ...[
                  const SizedBox(width: 10),
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),

            _QuestionInput(question: question, markError: markError),

            // ✅ error de DINARDAP solo bajo esta tarjeta
            if (inlineError != null && inlineError!.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                inlineError!,
                style: const TextStyle(color: AppColors.error, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuestionInput extends StatelessWidget {
  final Question question;
  final bool markError;

  const _QuestionInput({required this.question, required this.markError});

  TextInputType _keyboardFor(InputConstraints? c) {
    if (c == null) return TextInputType.text;
    switch (c.mode) {
      case InputMode.integer:
        return TextInputType.number;
      case InputMode.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case InputMode.text:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _formattersFor(InputConstraints? c) {
    if (c == null) return const [];
    final f = <TextInputFormatter>[];

    if (c.mode == InputMode.integer) {
      f.add(FilteringTextInputFormatter.digitsOnly);
    } else if (c.mode == InputMode.decimal) {
      if (c.decimalPlaces != null) {
        final dp = c.decimalPlaces!;
        f.add(
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d{0,' + dp.toString() + r'}$'),
          ),
        );
      } else {
        f.add(FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')));
      }
    }

    if (c.maxLength != null) {
      f.add(LengthLimitingTextInputFormatter(c.maxLength));
    }

    return f;
  }

  String? _asString(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    if (v is bool) return v ? '1' : '0';
    return v.toString();
  }

  String? _asDropdownValue(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    return v.toString();
  }

  InputDecoration _decoration({String? hintText, bool isReadOnly = false}) {
    return SurveyInputStyles.decoration(
      hintText: hintText,
      errorText: markError ? 'Campo obligatorio' : null,
      suffixIcon: isReadOnly
          ? const Icon(Icons.lock, size: 16, color: Colors.blue)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(
      buildWhen: (p, c) =>
          p.answers != c.answers ||
          p.dinardapPopulatedFields != c.dinardapPopulatedFields,
      builder: (context, state) {
        final answer = state.answers[question.id];
        final isReadOnly = state.dinardapPopulatedFields.contains(question.id);

        switch (question.type) {
          case QuestionType.singleChoice:
            return Column(
              children: question.options.map((opt) {
                return RadioListTile<String>(
                  value: opt.id,
                  groupValue: _asDropdownValue(answer),
                  onChanged: isReadOnly
                      ? null
                      : (v) => context.read<SurveyBloc>().add(
                          SurveyAnswerChanged(
                            questionId: question.id,
                            value: v,
                          ),
                        ),
                  title: Text(opt.label),
                );
              }).toList(),
            );

          case QuestionType.yesNo:
            final current = _asDropdownValue(answer);
            return Column(
              children: [
                RadioListTile<String>(
                  value: '1',
                  groupValue: current,
                  onChanged: isReadOnly
                      ? null
                      : (v) => context.read<SurveyBloc>().add(
                          SurveyAnswerChanged(
                            questionId: question.id,
                            value: v,
                          ),
                        ),
                  title: const Text('Sí'),
                ),
                RadioListTile<String>(
                  value: '0',
                  groupValue: current,
                  onChanged: isReadOnly
                      ? null
                      : (v) => context.read<SurveyBloc>().add(
                          SurveyAnswerChanged(
                            questionId: question.id,
                            value: v,
                          ),
                        ),
                  title: const Text('No'),
                ),
              ],
            );

          case QuestionType.dropdown:
            const provinceQid = 'idProvinciaM';
            const cantonQid = 'idCantonM';
            const parishQid = 'idParroquiaM';

            final isGeo =
                question.id == provinceQid ||
                question.id == cantonQid ||
                question.id == parishQid;

            if (isGeo) {
              return EcuadorLocationDropdown(
                questionId: question.id,
                markError: markError,
                answers: state.answers,
                provinceQuestionId: provinceQid,
                cantonQuestionId: cantonQid,
                parishQuestionId: parishQid,
                onAnswerChanged: (qid, value) {
                  context.read<SurveyBloc>().add(
                    SurveyAnswerChanged(questionId: qid, value: value),
                  );
                },
              );
            }

            return DropdownButtonFormField<String>(
              value: _asDropdownValue(answer),
              isExpanded: true,
              items: question.options
                  .map(
                    (opt) => DropdownMenuItem(
                      value: opt.id,
                      child: Text(
                        opt.label,
                        style: const TextStyle(color: Colors.black),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: isReadOnly
                  ? null
                  : (v) {
                      context.read<SurveyBloc>().add(
                        SurveyAnswerChanged(questionId: question.id, value: v),
                      );
                    },
              decoration: _decoration(
                hintText: 'Seleccione una opción',
                isReadOnly: isReadOnly,
              ),
              style: const TextStyle(color: Colors.black), // Texto seleccionado
            );

          case QuestionType.multiChoice:
            final selected = (answer as List?)?.cast<String>() ?? <String>[];
            return Column(
              children: question.options.map((opt) {
                final checked = selected.contains(opt.id);
                return CheckboxListTile(
                  value: checked,
                  onChanged: (v) {
                    final next = List<String>.from(selected);
                    if (v == true) {
                      if (!next.contains(opt.id)) next.add(opt.id);
                    } else {
                      next.remove(opt.id);
                    }
                    context.read<SurveyBloc>().add(
                      SurveyAnswerChanged(questionId: question.id, value: next),
                    );
                  },
                  title: Text(opt.label),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            );

          case QuestionType.textShort:
            return BlocTextField(
              fieldId: question.id,
              initialText: _asString(answer) ?? '',
              constraints: question.constraints,
              markError: markError,
              minLines: 1,
              maxLines: 1,
              isReadOnly: isReadOnly,
            );

          case QuestionType.textLong:
            return BlocTextField(
              fieldId: question.id,
              initialText: _asString(answer) ?? '',
              constraints: question.constraints,
              markError: markError,
              minLines: 3,
              maxLines: 5,
              isReadOnly: isReadOnly,
            );

          case QuestionType.date:
            final value = _asString(answer);
            return InkWell(
              onTap: isReadOnly
                  ? null
                  : () async {
                      final now = DateTime.now();
                      final initialDate = value != null
                          ? DateTime.tryParse(value) ?? DateTime(1980)
                          : DateTime(1980);

                      final picked = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: DateTime(1900),
                        lastDate: now,
                      );

                      if (picked != null) {
                        final formatted =
                            '${picked.year.toString().padLeft(4, '0')}-'
                            '${picked.month.toString().padLeft(2, '0')}-'
                            '${picked.day.toString().padLeft(2, '0')}';

                        context.read<SurveyBloc>().add(
                          SurveyAnswerChanged(
                            questionId: question.id,
                            value: formatted,
                          ),
                        );
                      }
                    },
              child: InputDecorator(
                decoration: SurveyInputStyles.decoration(
                  hintText: 'Seleccione una fecha',
                  errorText: markError ? 'Campo obligatorio' : null,
                  suffixIcon: Icon(
                    isReadOnly ? Icons.lock : Icons.calendar_month,
                    color: isReadOnly ? Colors.blue : null,
                    size: isReadOnly ? 16 : null, // ✅ Tamaño 16 para el candado
                  ),
                ),
                child: Text(
                  value ?? 'Seleccione una fecha',
                  style: TextStyle(
                    color: value == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            );

          case QuestionType.householdMembers:
            return HouseholdMembersQuestion(
              questionId: question.id,
              markError: markError,
            );
        }
      },
    );
  }
}

class BlocTextField extends StatefulWidget {
  final String fieldId;
  final String initialText;
  final InputConstraints? constraints;
  final bool markError;
  final int minLines;
  final int maxLines;
  final bool isReadOnly;

  const BlocTextField({
    super.key,
    required this.fieldId,
    required this.initialText,
    required this.constraints,
    required this.markError,
    required this.minLines,
    required this.maxLines,
    this.isReadOnly = false,
  });

  @override
  State<BlocTextField> createState() => _BlocTextFieldState();
}

class _BlocTextFieldState extends State<BlocTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void didUpdateWidget(covariant BlocTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Solo sincroniza si cambia el texto “externo” (load draft / limpiar borrador)
    if (oldWidget.initialText != widget.initialText &&
        _controller.text != widget.initialText) {
      _controller.text = widget.initialText;
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextInputType _keyboardFor(InputConstraints? c) {
    if (c == null) return TextInputType.text;
    switch (c.mode) {
      case InputMode.integer:
        return TextInputType.number;
      case InputMode.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case InputMode.text:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _formattersFor(InputConstraints? c) {
    if (c == null) return const [];
    final f = <TextInputFormatter>[];

    if (c.mode == InputMode.integer) {
      f.add(FilteringTextInputFormatter.digitsOnly);
    } else if (c.mode == InputMode.decimal) {
      if (c.decimalPlaces != null) {
        final dp = c.decimalPlaces!;
        f.add(
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d{0,' + dp.toString() + r'}$'),
          ),
        );
      } else {
        f.add(FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')));
      }
    }

    if (c.maxLength != null) {
      f.add(LengthLimitingTextInputFormatter(c.maxLength));
    }

    return f;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.constraints;

    return TextFormField(
      controller: _controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      enabled: !widget.isReadOnly,
      style: const TextStyle(color: Colors.black), // Texto negro
      decoration: SurveyInputStyles.decoration(
        hintText: 'Escribe aquí...',
        errorText: widget.markError ? 'Campo obligatorio' : null,
        suffixIcon: widget.isReadOnly && widget.fieldId != 'nroDocumentoM'
            ? const Icon(Icons.lock, size: 16, color: Colors.blue)
            : null,
      ),
      keyboardType: _keyboardFor(c),
      inputFormatters: _formattersFor(c),
      onChanged: (v) {
        context.read<SurveyBloc>().add(
          SurveyAnswerChanged(questionId: widget.fieldId, value: v),
        );

        if (widget.fieldId == 'nroDocumentoM') {
          final ced = v.trim();
          if (ced.length == 10) {
            context.read<SurveyBloc>().add(SurveyCedulaCompleted(ced));
          }
        }
      },
    );
  }
}

class _SurveyDebugSheet extends StatefulWidget {
  final String surveyId;
  final int pageIndex;
  final SurveySection section;
  final List<Question> questions;
  final Map<String, dynamic> answers;

  final String Function(QuestionType) typeLabel;
  final String Function(Question, dynamic) formatDisplayed;
  final String Function(dynamic) formatRaw;

  const _SurveyDebugSheet({
    required this.surveyId,
    required this.pageIndex,
    required this.section,
    required this.questions,
    required this.answers,
    required this.typeLabel,
    required this.formatDisplayed,
    required this.formatRaw,
  });

  @override
  State<_SurveyDebugSheet> createState() => _SurveyDebugSheetState();
}

enum _DebugSource { memory, draft, pending }

class _SurveyDebugSheetState extends State<_SurveyDebugSheet> {
  bool _onlyCurrentSection = true;
  String _query = '';

  _DebugSource _source = _DebugSource.memory;

  SurveySubmission? _draft;
  List<SurveySubmission> _pending = const [];
  int _pendingIndex = 0;

  bool _loadingSource = false;
  String? _sourceError;

  Map<String, dynamic> get _activeAnswers {
    switch (_source) {
      case _DebugSource.memory:
        return widget.answers;
      case _DebugSource.draft:
        return _draft?.answers ?? <String, dynamic>{};
      case _DebugSource.pending:
        if (_pending.isEmpty) return <String, dynamic>{};
        final idx = _pendingIndex.clamp(0, _pending.length - 1);
        return _pending[idx].answers;
    }
  }

  Future<void> _loadDraftAndPending() async {
    setState(() {
      _loadingSource = true;
      _sourceError = null;
    });

    try {
      final bloc = context.read<SurveyBloc>();
      final draft = await bloc.loadDraftNow(widget.surveyId);
      final pending = await bloc.loadPendingNow(widget.surveyId);

      setState(() {
        _draft = draft;
        _pending = pending;
        _pendingIndex = 0;
        _loadingSource = false;
      });
    } catch (e) {
      setState(() {
        _sourceError = e.toString();
        _loadingSource = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDraftAndPending();
  }

  @override
  Widget build(BuildContext context) {
    final base = _onlyCurrentSection
        ? widget.questions.where((q) => q.section == widget.section).toList()
        : widget.questions;

    final q = _query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? base
        : base.where((x) {
            return x.id.toLowerCase().contains(q) ||
                x.title.toLowerCase().contains(q);
          }).toList();

    final report = _buildReport(filtered);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'DEBUG - Respuestas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Copiar reporte',
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: report));
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reporte copiado al portapapeles'),
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
              ),
              IconButton(
                tooltip: 'Cerrar',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'surveyId: ${widget.surveyId} | página: ${widget.pageIndex + 1} | sección: ${widget.section.title}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),

          const SizedBox(height: 10),

          if (_loadingSource) const LinearProgressIndicator(),
          if (_sourceError != null) ...[
            const SizedBox(height: 8),
            Text(
              'Error cargando storage: $_sourceError',
              style: const TextStyle(color: AppColors.error),
            ),
          ],

          const SizedBox(height: 8),

          // Fuente: memoria / draft / pending
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Memoria'),
                selected: _source == _DebugSource.memory,
                onSelected: (_) =>
                    setState(() => _source = _DebugSource.memory),
              ),
              ChoiceChip(
                label: Text(_draft == null ? 'Draft (vacío)' : 'Draft'),
                selected: _source == _DebugSource.draft,
                onSelected: (_) => setState(() => _source = _DebugSource.draft),
              ),
              ChoiceChip(
                label: Text(
                  _pending.isEmpty
                      ? 'Pending (0)'
                      : 'Pending (${_pending.length})',
                ),
                selected: _source == _DebugSource.pending,
                onSelected: (_) =>
                    setState(() => _source = _DebugSource.pending),
              ),
              TextButton.icon(
                onPressed: _loadDraftAndPending,
                icon: const Icon(Icons.refresh),
                label: const Text('Recargar'),
              ),
            ],
          ),

          if (_source == _DebugSource.pending && _pending.isNotEmpty) ...[
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _pendingIndex.clamp(0, _pending.length - 1),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Registro pending (createdAt)',
                isDense: true,
              ),
              items: List.generate(_pending.length, (i) {
                final dt = _pending[i].createdAt.toIso8601String();
                final st = _pending[i].status.name;
                return DropdownMenuItem<int>(
                  value: i,
                  child: Text(
                    '$i | $st | $dt',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
              onChanged: (v) => setState(() => _pendingIndex = v ?? 0),
            ),
          ],

          const SizedBox(height: 10),

          // Controls
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar por id o título...',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Solo sección', style: TextStyle(fontSize: 12)),
                  Switch(
                    value: _onlyCurrentSection,
                    onChanged: (v) => setState(() => _onlyCurrentSection = v),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // List
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 10),
              itemBuilder: (ctx, i) {
                final qu = filtered[i];
                final ans = _activeAnswers[qu.id];

                final raw = widget.formatRaw(ans);
                final pretty = widget.formatDisplayed(qu, ans);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${qu.id}  •  ${widget.typeLabel(qu.type)}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(qu.title, style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 6),
                    Text(
                      'raw: $raw',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'view: $pretty',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _buildReport(List<Question> list) {
    final b = StringBuffer();
    b.writeln('DEBUG - Respuestas');
    b.writeln('surveyId=${widget.surveyId}');
    b.writeln('page=${widget.pageIndex + 1}');
    b.writeln('section=${widget.section.title}');
    b.writeln('onlyCurrentSection=$_onlyCurrentSection');
    b.writeln('query=$_query');
    b.writeln('source=$_source');
    b.writeln('----------------------------------------');

    for (final qu in list) {
      final ans = _activeAnswers[qu.id];
      b.writeln('${qu.id} | ${widget.typeLabel(qu.type)} | ${qu.title}');
      b.writeln('  raw : ${widget.formatRaw(ans)}');
      b.writeln('  view: ${widget.formatDisplayed(qu, ans)}');
    }

    return b.toString();
  }
}
