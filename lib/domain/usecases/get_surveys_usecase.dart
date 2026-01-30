import '../entities/survey.dart';
import '../repositories/survey_repository.dart';

class GetSurveysUseCase {
  final SurveyRepository repository;

  const GetSurveysUseCase(this.repository);

  Future<List<Survey>> call() => repository.getSurveys();
}
