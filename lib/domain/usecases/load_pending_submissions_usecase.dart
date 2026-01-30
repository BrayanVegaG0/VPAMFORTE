import '../entities/survey_submission.dart';
import '../repositories/survey_repository.dart';

class LoadPendingSubmissionsUseCase {
  final SurveyRepository repository;

  const LoadPendingSubmissionsUseCase(this.repository);

  Future<List<SurveySubmission>> call(String surveyId) {
    return repository.loadPending(surveyId);
  }
}
