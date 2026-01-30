abstract class Condition {
  const Condition();
  bool evaluate(Map<String, dynamic> answers);
}

class EqualsCondition extends Condition {
  final String questionId;
  final dynamic value;

  const EqualsCondition({required this.questionId, required this.value});

  @override
  bool evaluate(Map<String, dynamic> answers) => answers[questionId] == value;
}

class AndCondition extends Condition {
  final List<Condition> conditions;
  const AndCondition(this.conditions);

  @override
  bool evaluate(Map<String, dynamic> answers) =>
      conditions.every((c) => c.evaluate(answers));
}

class OrCondition extends Condition {
  final List<Condition> conditions;
  const OrCondition(this.conditions);

  @override
  bool evaluate(Map<String, dynamic> answers) =>
      conditions.any((c) => c.evaluate(answers));
}

class OneOfCondition extends Condition {
  final String questionId;
  final List<dynamic> values;

  const OneOfCondition({required this.questionId, required this.values});
  @override
  bool evaluate(Map<String, dynamic> answers) {
    final answer = answers[questionId];
    // Verificamos si esa respuesta existe dentro de la lista de valores permitidos
    return values.contains(answer);
  }
}

class NotCondition extends Condition {
  final Condition condition;
  const NotCondition(this.condition);

  @override
  bool evaluate(Map<String, dynamic> answers) => !condition.evaluate(answers);
}

class ContainsCondition extends Condition {
  final String questionId;
  final dynamic value;

  const ContainsCondition({required this.questionId, required this.value});

  @override
  bool evaluate(Map<String, dynamic> answers) {
    final answer = answers[questionId];
    if (answer is List) {
      if (value is String)
        return answer.map((e) => e.toString()).contains(value);
      return answer.contains(value);
    }
    // Si la respuesta es un string separado por comas (por si acaso)
    if (answer is String) {
      return answer.split(',').map((e) => e.trim()).contains(value);
    }
    return answer == value;
  }
}
