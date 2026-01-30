import '../repositories/survey_repository.dart';

class ClearSurveyLocalUseCase {
  final SurveyRepository repo;
  ClearSurveyLocalUseCase(this.repo);

  Future<void> call(String surveyId) async {
    await repo.clearDraft(surveyId);
    await repo.clearPendingAll(surveyId);
  }
}