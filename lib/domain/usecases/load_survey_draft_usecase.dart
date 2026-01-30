import '../entities/survey_submission.dart';
import '../repositories/survey_repository.dart';

class LoadSurveyDraftUseCase {
  final SurveyRepository repository;

  const LoadSurveyDraftUseCase(this.repository);

  Future<SurveySubmission?> call(String surveyId) {
    return repository.loadDraft(surveyId);
  }
}
