enum SubmissionStatus { draft, pending, sent, error }

class SurveySubmission {
  final String surveyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// answers listo para mapear a SOAP
  /// clave recomendada: el "campo SOAP" o el questionId (si luego mapearás)
  final Map<String, dynamic> answers;

  final SubmissionStatus status;
  final int attempts;
  final String? lastError;

  const SurveySubmission({
    required this.surveyId,
    required this.createdAt,
    required this.updatedAt,
    required this.answers,
    required this.status,
    required this.attempts,
    required this.lastError,
  });

  SurveySubmission copyWith({
    DateTime? updatedAt,
    Map<String, dynamic>? answers,
    SubmissionStatus? status,
    int? attempts,
    String? lastError,
  }) {
    return SurveySubmission(
      surveyId: surveyId,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      answers: answers ?? this.answers,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      lastError: lastError,
    );
  }
}
