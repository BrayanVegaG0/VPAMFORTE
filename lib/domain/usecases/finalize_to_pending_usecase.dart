import '../entities/survey_submission.dart';
import '../repositories/survey_repository.dart';

class FinalizeToPendingUseCase {
  final SurveyRepository repository;

  const FinalizeToPendingUseCase(this.repository);

  Future<void> call(SurveySubmission pending) {
    return repository.finalizeToPending(pending);
  }
}
