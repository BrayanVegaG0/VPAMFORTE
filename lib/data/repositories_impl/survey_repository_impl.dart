import 'package:flutter/foundation.dart';

import '../../domain/entities/survey.dart';
import '../../domain/entities/survey_submission.dart';
import '../../domain/entities/survey_history_item.dart';
import '../../domain/entities/send_result.dart';
import '../../domain/repositories/survey_repository.dart';
import '../datasources/remote/survey_remote_datasource.dart';
import '../datasources/remote/survey_soap_remote_datasource.dart';
import '../datasources/local/survey_local_datasource.dart';
import '../models/survey_submission_model.dart';
import '../models/survey_history_model.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../mappers/survey_answers_to_ficha_db_mapper.dart';
import '../datasources/remote/soap/ficha_soap_serializer.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyRemoteDataSource remote;
  final SurveySoapRemoteDataSource soap;
  final SurveyLocalDataSource local;
  final AuthLocalDataSource authLocal;
  final SurveyAnswersToFichaDbMapper fichaMapper;
  final FichaSoapSerializer soapSerializer;

  const SurveyRepositoryImpl({
    required this.remote,
    required this.soap,
    required this.local,
    required this.authLocal,
    required this.fichaMapper,
    required this.soapSerializer,
  });

  @override
  Future<List<Survey>> getSurveys() => remote.getSurveys();

  SurveySubmissionModel _toModel(SurveySubmission s) => SurveySubmissionModel(
    surveyId: s.surveyId,
    createdAt: s.createdAt,
    updatedAt: s.updatedAt,
    answers: s.answers,
    status: s.status,
    attempts: s.attempts,
    lastError: s.lastError,
  );

  @override
  Future<void> saveDraft(SurveySubmission draft) =>
      local.saveDraft(_toModel(draft));

  @override
  Future<SurveySubmission?> loadDraft(String surveyId) =>
      local.loadDraft(surveyId);

  @override
  Future<void> clearDraft(String surveyId) => local.clearDraft(surveyId);

  @override
  Future<void> finalizeToPending(SurveySubmission pending) async {
    await local.enqueuePending(_toModel(pending));
    await local.clearDraft(pending.surveyId);
  }

  @override
  Future<List<SurveySubmission>> loadPending(String surveyId) async {
    final list = await local.loadPending(surveyId);

    final sentItems = list
        .where((e) => e.status == SubmissionStatus.sent)
        .toList();
    for (final s in sentItems) {
      await local.removePending(_toModel(s));
    }

    return list.where((e) => e.status != SubmissionStatus.sent).toList();
  }

  @override
  Future<void> updatePending(SurveySubmission updated) =>
      local.updatePending(_toModel(updated));

  @override
  Future<SendResult> sendPendingOneByOne(
    String surveyId, {
    List<String>? selectedCreatedAtIso,
  }) async {
    final all = await local.loadPending(surveyId);
    if (all.isEmpty) return SendResult(successCount: 0, failureCount: 0);

    final selected =
        (selectedCreatedAtIso == null || selectedCreatedAtIso.isEmpty)
        ? all
        : all
              .where(
                (x) => selectedCreatedAtIso.contains(
                  x.createdAt.toIso8601String(),
                ),
              )
              .toList();

    void logXml(String xml) {
      if (kReleaseMode) return;
      debugPrint('=== SOAP XML (ENVELOPE) ===');
      debugPrint(xml);
    }

    int successCount = 0;
    int failureCount = 0;

    for (final item in selected) {
      final updatedAttempt = item.copyWith(
        updatedAt: DateTime.now(),
        status: SubmissionStatus.pending,
        attempts: item.attempts + 1,
        lastError: null,
      );

      await local.updatePending(_toModel(updatedAttempt));

      try {
        final creds = await authLocal.getBasicAuthCredentials();
        if (creds == null) {
          throw Exception(
            'No hay credenciales Basic Auth guardadas. Inicia sesión nuevamente.',
          );
        }

        final fichaDb = fichaMapper.map(updatedAttempt.answers);
        final xml = soapSerializer.buildEnvelope(fichaDb);
        logXml(xml);

        final result = await soap.insertFichaAdultoMayorDiscXml(
          credentials: SoapCredentials(
            username: creds.username,
            password: creds.password,
          ),
          envelopeXml: xml,
        );

        if (!result.isOk) {
          throw Exception('SOAP cod=${result.code} msg=${result.message}');
        }

        final sent = updatedAttempt.copyWith(
          updatedAt: DateTime.now(),
          status: SubmissionStatus.sent,
          lastError: null,
        );

        await local.addToSentHistory(
          _toModel(sent),
          remoteCode: result.code,
          remoteMessage: result.message,
        );

        await local.removePending(_toModel(sent));

        successCount++;

        // ✅ Guardar en historial resumido
        // (Esto se hará desde el BLOC usando el UseCase, pero el repositorio debe soportarlo)
        // Por ahora, el repo solo expone los métodos
      } catch (e) {
        final failed = updatedAttempt.copyWith(
          updatedAt: DateTime.now(),
          status: SubmissionStatus.error,
          lastError: e.toString(),
        );

        // ✅ Se queda en local como ERROR para reintento y para mostrarse visible
        await local.updatePending(_toModel(failed));

        failureCount++;

        // ✅ NO hacemos break: seguimos intentando con las demás seleccionadas
      }
    }

    // Si todas fallaron, lanzar excepción
    if (successCount == 0 && failureCount > 0) {
      throw Exception(
        'Todas las encuestas ($failureCount) fallaron al enviarse',
      );
    }

    return SendResult(successCount: successCount, failureCount: failureCount);
  }

  @override
  Future<void> clearPendingAll(String surveyId) =>
      local.clearPendingAll(surveyId);

  @override
  Future<void> deletePending(SurveySubmission item) async {
    await local.removePending(_toModel(item));
  }

  @override
  Future<void> deletePendingById({
    required String surveyId,
    required String createdAtIso,
  }) {
    return local.removePendingById(surveyId, createdAtIso);
  }

  @override
  Future<void> saveHistoryItem(SurveyHistoryItem item) {
    return local.saveHistoryItem(SurveyHistoryModel.fromEntity(item));
  }

  @override
  Future<List<SurveyHistoryItem>> getHistory() {
    return local.getHistory();
  }
}
