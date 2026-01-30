import '../repositories/survey_repository.dart';

class SendPendingSubmissionsUseCase {
  final SurveyRepository repo;
  SendPendingSubmissionsUseCase(this.repo);

  Future<void> call(
      String surveyId, {
        List<String>? selectedCreatedAtIso = const [],
      }) {
    return repo.sendPendingOneByOne(
      surveyId,
      selectedCreatedAtIso: selectedCreatedAtIso,
    );
  }
}
