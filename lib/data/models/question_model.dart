import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.title,
    required super.type,
    required super.required,
    super.options = const [],
    required super.section,
    super.visibleIf,
    super.requiredIf,
    super.constraints,
  });

// Si luego conectas API real, aquí va fromJson/toJson.
}
