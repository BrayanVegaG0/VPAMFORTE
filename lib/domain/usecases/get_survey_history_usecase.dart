import '../entities/survey_history_item.dart';
import '../repositories/survey_repository.dart';

class GetSurveyHistoryUseCase {
  final SurveyRepository repository;

  GetSurveyHistoryUseCase(this.repository);

  Future<List<SurveyHistoryItem>> call() {
    return repository.getHistory();
  }
}
