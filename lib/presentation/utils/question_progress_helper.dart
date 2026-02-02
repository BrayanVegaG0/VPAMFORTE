import '../../domain/entities/question.dart';
import '../../domain/entities/survey_section.dart';
import '../../domain/rules/survey_rules_engine.dart';

/// Helper para calcular el progreso de la encuesta basado en preguntas visibles
/// en lugar de secciones, considerando el flujo condicional de preguntas.
class QuestionProgressHelper {
  /// Cuenta el total de preguntas visibles según las respuestas actuales
  /// Solo cuenta preguntas de secciones que estén visibles
  static int countVisibleQuestions(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
    List<SurveySection> visibleSections,
  ) {
    // SurveySection es un enum, así que comparamos directamente
    final visibleSectionSet = visibleSections.toSet();
    return allQuestions
        .where(
          (q) =>
              visibleSectionSet.contains(q.section) &&
              rules.isVisible(q, answers),
        )
        .length;
  }

  /// Cuenta las preguntas obligatorias que están visibles
  static int countRequiredVisibleQuestions(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
    List<SurveySection> visibleSections,
  ) {
    final visibleSectionSet = visibleSections.toSet();
    return allQuestions
        .where(
          (q) =>
              visibleSectionSet.contains(q.section) &&
              rules.isVisible(q, answers) &&
              rules.isRequired(q, answers),
        )
        .length;
  }

  /// Cuenta cuántas de las preguntas visibles han sido respondidas
  static int countAnsweredVisibleQuestions(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
    List<SurveySection> visibleSections,
  ) {
    final visibleSectionSet = visibleSections.toSet();
    int count = 0;
    for (final q in allQuestions) {
      if (!visibleSectionSet.contains(q.section)) continue;
      if (!rules.isVisible(q, answers)) continue;

      final answer = answers[q.id];
      if (isAnswered(q, answer)) {
        count++;
      }
    }
    return count;
  }

  /// Calcula el progreso como un valor entre 0.0 y 1.0
  static double calculateProgress(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
    List<SurveySection> visibleSections,
  ) {
    final total = countVisibleQuestions(
      allQuestions,
      answers,
      rules,
      visibleSections,
    );
    if (total == 0) return 0.0;

    final answered = countAnsweredVisibleQuestions(
      allQuestions,
      answers,
      rules,
      visibleSections,
    );
    return answered / total;
  }

  /// Verifica si una pregunta ha sido respondida
  static bool isAnswered(Question q, dynamic answer) {
    switch (q.type) {
      case QuestionType.dropdown:
      case QuestionType.singleChoice:
        return answer != null && answer.toString().trim().isNotEmpty;

      case QuestionType.multiChoice:
        return answer is List && answer.isNotEmpty;

      case QuestionType.textShort:
      case QuestionType.textLong:
        return answer is String && answer.trim().isNotEmpty;

      case QuestionType.date:
        return answer is String && answer.trim().isNotEmpty;

      case QuestionType.yesNo:
        return answer is String && (answer == '1' || answer == '0');

      case QuestionType.householdMembers:
        if (answer == null) return false;
        if (answer is String) {
          final t = answer.trim();
          if (t.isEmpty) return false;
          try {
            // Intenta decodificar como JSON
            return t.isNotEmpty;
          } catch (_) {
            return false;
          }
        }
        return false;
    }
  }

  /// Obtiene un resumen de progreso en formato de texto
  static String getProgressSummary(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
    List<SurveySection> visibleSections,
  ) {
    final answered = countAnsweredVisibleQuestions(
      allQuestions,
      answers,
      rules,
      visibleSections,
    );
    final total = countVisibleQuestions(
      allQuestions,
      answers,
      rules,
      visibleSections,
    );
    final percentage =
        (calculateProgress(allQuestions, answers, rules, visibleSections) * 100)
            .round();

    return '$answered / $total preguntas ($percentage%)';
  }
}
