import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ficha_vulnerabilidad/domain/entities/survey.dart';
import 'package:ficha_vulnerabilidad/domain/repositories/survey_repository.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/get_surveys_usecase.dart';

class MockSurveyRepository extends Mock implements SurveyRepository {}

void main() {
  late MockSurveyRepository repository;
  late GetSurveysUseCase useCase;

  setUp(() {
    repository = MockSurveyRepository();
    useCase = GetSurveysUseCase(repository);
  });

  test('retorna lista de encuestas desde el repositorio', () async {
    final surveys = <Survey>[];

    when(() => repository.getSurveys())
        .thenAnswer((_) async => surveys);

    final result = await useCase();

    expect(result, surveys);
    verify(() => repository.getSurveys()).called(1);
  });
}
