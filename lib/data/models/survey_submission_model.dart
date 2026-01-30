import '../../domain/entities/survey_submission.dart';

class SurveySubmissionModel extends SurveySubmission {
  const SurveySubmissionModel({
    required super.surveyId,
    required super.createdAt,
    required super.updatedAt,
    required super.answers,
    required super.status,
    required super.attempts,
    required super.lastError,
  });

  Map<String, dynamic> toJson() => {
    'surveyId': surveyId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'answers': answers,
    'status': status.name,
    'attempts': attempts,
    'lastError': lastError,
  };

  factory SurveySubmissionModel.fromJson(Map<String, dynamic> json) {
    final rawStatus = (json['status'] ?? 'pending').toString();
    final parsedStatus = SubmissionStatus.values.firstWhere(
          (e) => e.name == rawStatus,
      orElse: () => SubmissionStatus.pending,
    );

    // ✅ answers robusto
    final rawAnswers = json['answers'];
    final answers = (rawAnswers is Map)
        ? Map<String, dynamic>.from(rawAnswers as Map)
        : <String, dynamic>{};

    return SurveySubmissionModel(
      surveyId: (json['surveyId'] ?? '').toString(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString()) ?? DateTime.now(),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? '').toString()) ?? DateTime.now(),
      answers: answers,
      status: parsedStatus,
      attempts: (json['attempts'] as num?)?.toInt() ?? 0,
      lastError: json['lastError'] as String?,
    );
  }
}
