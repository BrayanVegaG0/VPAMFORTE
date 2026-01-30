import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entities/survey.dart';
import '../../domain/entities/survey_submission.dart';
import '../../domain/repositories/survey_repository.dart';
import '../datasources/remote/survey_remote_datasource.dart';
import '../datasources/remote/survey_soap_remote_datasource.dart';
import '../datasources/local/survey_local_datasource.dart';
import '../models/survey_submission_model.dart';
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
  Future<void> saveDraft(SurveySubmission draft) => local.saveDraft(_toModel(draft));

  @override
  Future<SurveySubmission?> loadDraft(String surveyId) => local.loadDraft(surveyId);

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

    final sentItems = list.where((e) => e.status == SubmissionStatus.sent).toList();
    for (final s in sentItems) {
      await local.removePending(_toModel(s));
    }

    return list.where((e) => e.status != SubmissionStatus.sent).toList();
  }

  @override
  Future<void> updatePending(SurveySubmission updated) => local.updatePending(_toModel(updated));

  @override
  Future<void> sendPendingOneByOne(
      String surveyId, {
        List<String>? selectedCreatedAtIso,
      }) async {
    final all = await local.loadPending(surveyId);
    if (all.isEmpty) return;

    final selected = (selectedCreatedAtIso == null || selectedCreatedAtIso.isEmpty)
        ? all
        : all.where((x) => selectedCreatedAtIso.contains(x.createdAt.toIso8601String())).toList();

    void _logXml(String xml) {
      if (kReleaseMode) return;
      debugPrint('=== SOAP XML (ENVELOPE) ===');
      debugPrint(xml);
    }

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
          throw Exception('No hay credenciales Basic Auth guardadas. Inicia sesión nuevamente.');
        }

        final fichaDb = fichaMapper.map(updatedAttempt.answers);
        final xml = soapSerializer.buildEnvelope(fichaDb);
        _logXml(xml);

        final result = await soap.insertFichaAdultoMayorDiscXml(
          credentials: SoapCredentials(username: creds.username, password: creds.password),
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
      } catch (e) {
        final failed = updatedAttempt.copyWith(
          updatedAt: DateTime.now(),
          status: SubmissionStatus.error,
          lastError: e.toString(),
        );

        // ✅ Se queda en local como ERROR para reintento y para mostrarse visible
        await local.updatePending(_toModel(failed));

        // ✅ NO hacemos break: seguimos intentando con las demás seleccionadas
      }
    }
  }


  @override
  Future<void> clearPendingAll(String surveyId) => local.clearPendingAll(surveyId);

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

}
