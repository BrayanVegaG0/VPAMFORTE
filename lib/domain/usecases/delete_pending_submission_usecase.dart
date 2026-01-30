import '../repositories/survey_repository.dart';

class DeletePendingSubmissionUseCase {
  final SurveyRepository repo;
  DeletePendingSubmissionUseCase(this.repo);

  Future<void> call({
    required String surveyId,
    required String createdAtIso,
  }) {
    return repo.deletePendingById(surveyId: surveyId, createdAtIso: createdAtIso);
  }
}