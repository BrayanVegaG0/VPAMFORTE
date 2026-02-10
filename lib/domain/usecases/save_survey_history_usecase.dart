import '../entities/survey_history_item.dart';
import '../repositories/survey_repository.dart';

class SaveSurveyHistoryUseCase {
  final SurveyRepository repository;

  SaveSurveyHistoryUseCase(this.repository);

  Future<void> call(SurveyHistoryItem item) {
    return repository.saveHistoryItem(item);
  }
}
