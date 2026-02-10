import 'package:equatable/equatable.dart';

class SurveyHistoryItem extends Equatable {
  final String id; // Typically the submission ID or UUID
  final String cedula;
  final String nombres;
  final String? edad;
  final String servicio; // e.g. "Discapacidad" or "Adulto Mayor"
  final DateTime sentAt;
  final String status; // "Enviado"

  const SurveyHistoryItem({
    required this.id,
    required this.cedula,
    required this.nombres,
    this.edad,
    required this.servicio,
    required this.sentAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    cedula,
    nombres,
    edad,
    servicio,
    sentAt,
    status,
  ];
}
