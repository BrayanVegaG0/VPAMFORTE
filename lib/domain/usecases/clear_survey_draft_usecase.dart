import '../repositories/survey_repository.dart';

class ClearSurveyDraftUseCase {
  final SurveyRepository repo;
  ClearSurveyDraftUseCase(this.repo);

  Future<void> call(String surveyId) => repo.clearDraft(surveyId);
}