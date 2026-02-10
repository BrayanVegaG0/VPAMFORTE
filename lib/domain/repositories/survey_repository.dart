import '../entities/survey.dart';
import '../entities/survey_submission.dart';
import '../entities/survey_history_item.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys();

  Future<void> saveDraft(SurveySubmission draft);
  Future<SurveySubmission?> loadDraft(String surveyId);
  Future<void> clearDraft(String surveyId);

  Future<void> finalizeToPending(SurveySubmission pending);

  Future<List<SurveySubmission>> loadPending(String surveyId);

  Future<void> updatePending(SurveySubmission updated);

  Future<void> sendPendingOneByOne(
    String surveyId, {
    List<String>? selectedCreatedAtIso,
  });

  Future<void> clearPendingAll(String surveyId);

  Future<void> deletePending(SurveySubmission item);

  Future<void> deletePendingById({
    required String surveyId,
    required String createdAtIso,
  });

  Future<void> saveHistoryItem(SurveyHistoryItem item);
  Future<List<SurveyHistoryItem>> getHistory();
}
