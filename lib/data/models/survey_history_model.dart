import '../../domain/entities/survey_history_item.dart';

class SurveyHistoryModel extends SurveyHistoryItem {
  const SurveyHistoryModel({
    required super.id,
    required super.cedula,
    required super.nombres,
    super.edad,
    required super.servicio,
    required super.sentAt,
    required super.status,
  });

  factory SurveyHistoryModel.fromJson(Map<String, dynamic> json) {
    return SurveyHistoryModel(
      id: json['id'] as String,
      cedula: json['cedula'] as String,
      nombres: json['nombres'] as String,
      edad: json['edad'] as String?,
      servicio: json['servicio'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cedula': cedula,
      'nombres': nombres,
      'edad': edad,
      'servicio': servicio,
      'sentAt': sentAt.toIso8601String(),
      'status': status,
    };
  }

  factory SurveyHistoryModel.fromEntity(SurveyHistoryItem item) {
    return SurveyHistoryModel(
      id: item.id,
      cedula: item.cedula,
      nombres: item.nombres,
      edad: item.edad,
      servicio: item.servicio,
      sentAt: item.sentAt,
      status: item.status,
    );
  }
}
