import '../entities/survey_submission.dart';
import '../repositories/survey_repository.dart';

class SaveSurveyDraftUseCase {
  final SurveyRepository repository;

  const SaveSurveyDraftUseCase(this.repository);

  Future<void> call(SurveySubmission draft) {
    return repository.saveDraft(draft);
  }
}
