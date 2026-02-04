import '../entities/question.dart';
import '../entities/survey.dart';
import '../entities/input_constraints.dart';
import '../entities/survey_section.dart';

class ValidationError {
  final String questionId;
  final String message;
  const ValidationError({required this.questionId, required this.message});
}

class SurveyRulesEngine {
  const SurveyRulesEngine();

  bool isVisible(Question q, Map<String, dynamic> answers) {
    return q.visibleIf?.evaluate(answers) ?? true;
  }

  bool isRequired(Question q, Map<String, dynamic> answers) {
    final cond = q.requiredIf?.evaluate(answers) ?? true;
    return q.required && cond;
  }

  List<ValidationError> validate(Survey survey, Map<String, dynamic> answers) {
    final errors = <ValidationError>[];

    for (final q in survey.questions) {
      if (!isVisible(q, answers)) continue;

      // required efectivo
      if (isRequired(q, answers)) {
        final v = answers[q.id];
        final emptyText = v is String && v.trim().isEmpty;
        final emptyList = v is List && v.isEmpty;

        if (v == null || emptyText || emptyList) {
          errors.add(
            ValidationError(
              questionId: q.id,
              message: 'Falta responder: ${q.title}',
            ),
          );
          continue; // si está vacío, no sigas con constraints
        }
      }

      // ✅ constraints (si tiene valor o si required ya pasó)
      final err = _validateConstraints(q, answers);
      if (err != null) {
        errors.add(ValidationError(questionId: q.id, message: err));
      }
    }

    return errors;
  }

  List<ValidationError> validateSection(
    Survey survey,
    SurveySection section,
    Map<String, dynamic> answers,
  ) {
    final errors = <ValidationError>[];

    final questions = survey.questions.where((q) => q.section == section);

    for (final q in questions) {
      if (!isVisible(q, answers)) continue;

      if (isRequired(q, answers)) {
        final v = answers[q.id];
        final emptyText = v is String && v.trim().isEmpty;
        final emptyList = v is List && v.isEmpty;

        if (v == null || emptyText || emptyList) {
          errors.add(
            ValidationError(
              questionId: q.id,
              message: 'Falta responder: ${q.title}',
            ),
          );
          continue;
        }
      }

      final err = _validateConstraints(q, answers);
      if (err != null) {
        errors.add(ValidationError(questionId: q.id, message: err));
      }
    }

    return errors;
  }

  String? _validateConstraints(Question q, Map<String, dynamic> answers) {
    final c = q.constraints;
    if (c == null)
      return _validateCustomRules(
        q,
        answers,
      ); // Check custom rules even if no constraints

    final raw = answers[q.id];
    if (raw == null) return null; // required lo valida arriba

    final s = (raw is String) ? raw.trim() : raw.toString().trim();

    if (c.minLength != null && s.length < c.minLength!) {
      return 'Mínimo ${c.minLength} caracteres: ${q.title}';
    }
    if (c.maxLength != null && s.length > c.maxLength!) {
      return 'Máximo ${c.maxLength} caracteres: ${q.title}';
    }

    if (c.pattern != null && !RegExp(c.pattern!).hasMatch(s)) {
      return 'Formato inválido: ${q.title}';
    }

    if (c.mode == InputMode.integer || c.mode == InputMode.decimal) {
      final n = num.tryParse(s);
      if (n == null) return 'Debe ser un número: ${q.title}';

      if (c.minValue != null && n < c.minValue!) {
        return 'Debe ser ≥ ${c.minValue}: ${q.title}';
      }
      if (c.maxValue != null && n > c.maxValue!) {
        return 'Debe ser ≤ ${c.maxValue}: ${q.title}';
      }
    }

    return _validateCustomRules(q, answers);
  }

  String? _validateCustomRules(Question q, Map<String, dynamic> answers) {
    // Regla de Edad vs Servicio
    if (q.id == 'fechaNacimientoM') {
      final serviceId = answers['idServMdh']?.toString();
      final dobIso = answers['fechaNacimientoM']?.toString();

      if (serviceId != null && dobIso != null) {
        final age = _calculateAge(dobIso);
        if (age != null) {
          // 3 = Adulto Mayor => >= 65
          if (serviceId == '3' && age < 65) {
            return 'Servicio Adulto Mayor no cumple con el requisito de edad: debe tener 65 años o más.';
          }
          // 2 = Desarrollo Infantil => <= 3
          if (serviceId == '2' && age > 3) {
            return 'Servicio Desarrollo Infantil no cumple con el requisito de edad: debe tener 3 años o menos.';
          }
        }
      }
    }
    return null;
  }

  int? _calculateAge(String dobIso) {
    try {
      final birth = DateTime.parse(dobIso);
      final now = DateTime.now();
      int age = now.year - birth.year;
      if (now.month < birth.month ||
          (now.month == birth.month && now.day < birth.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return null;
    }
  }
}
