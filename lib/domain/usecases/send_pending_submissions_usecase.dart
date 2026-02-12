import '../repositories/survey_repository.dart';
import '../entities/send_result.dart';

class SendPendingSubmissionsUseCase {
  final SurveyRepository repo;
  SendPendingSubmissionsUseCase(this.repo);

  Future<SendResult> call(
    String surveyId, {
    List<String>? selectedCreatedAtIso = const [],
  }) {
    return repo.sendPendingOneByOne(
      surveyId,
      selectedCreatedAtIso: selectedCreatedAtIso,
    );
  }
}
