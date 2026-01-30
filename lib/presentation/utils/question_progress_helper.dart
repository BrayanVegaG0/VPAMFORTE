import '../../domain/entities/question.dart';
import '../../domain/rules/survey_rules_engine.dart';

/// Helper para calcular el progreso de la encuesta basado en preguntas visibles
/// en lugar de secciones, considerando el flujo condicional de preguntas.
class QuestionProgressHelper {
  /// Cuenta el total de preguntas visibles según las respuestas actuales
  static int countVisibleQuestions(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
  ) {
    return allQuestions.where((q) => rules.isVisible(q, answers)).length;
  }

  /// Cuenta las preguntas obligatorias que están visibles
  static int countRequiredVisibleQuestions(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
  ) {
    return allQuestions
        .where(
          (q) => rules.isVisible(q, answers) && rules.isRequired(q, answers),
        )
        .length;
  }

  /// Cuenta cuántas de las preguntas visibles han sido respondidas
  static int countAnsweredVisibleQuestions(
    List<Question> allQuestions,
    Map<String, dynamic> answers,
    SurveyRulesEngine rules,
  ) {
    int count = 0;
    for (final q in allQuestions) {
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
  ) {
    final total = countVisibleQuestions(allQuestions, answers, rules);
    if (total == 0) return 0.0;

    final answered = countAnsweredVisibleQuestions(
      allQuestions,
      answers,
      rules,
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
  ) {
    final answered = countAnsweredVisibleQuestions(
      allQuestions,
      answers,
      rules,
    );
    final total = countVisibleQuestions(allQuestions, answers, rules);
    final percentage = (calculateProgress(allQuestions, answers, rules) * 100)
        .round();

    return '$answered / $total preguntas ($percentage%)';
  }
}
