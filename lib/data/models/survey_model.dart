import '../../domain/entities/survey.dart';

class SurveyModel extends Survey {
  const SurveyModel({
    required super.id,
    required super.title,
    required super.questions,
  });

// Si luego conectas API real, aquí va fromJson/toJson.
}
