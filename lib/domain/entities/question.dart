import 'package:ficha_vulnerabilidad/domain/entities/survey_section.dart';
import 'package:ficha_vulnerabilidad/domain/rules/condition.dart';
import 'package:ficha_vulnerabilidad/domain/entities/input_constraints.dart';

enum QuestionType {
  singleChoice,
  yesNo,
  dropdown,
  multiChoice,
  textShort,
  textLong,
  date,
  householdMembers,
}

class QuestionOption {
  final String id;
  final String label;

  const QuestionOption({required this.id, required this.label});
}

class Question {
  final String id;
  final String title;
  final QuestionType type;
  final bool required;
  final List<QuestionOption> options;
  final SurveySection section;

  // ✅ Reglas (opcionales)
  final Condition? visibleIf;
  final Condition? requiredIf;

  final InputConstraints? constraints;
  const Question({
    required this.id,
    required this.title,
    required this.type,
    required this.required,
    this.options = const [],
    required this.section,
    this.visibleIf,
    this.requiredIf,
    this.constraints,
  });
}
