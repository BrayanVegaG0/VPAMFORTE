import 'package:equatable/equatable.dart';
import '../../../domain/entities/survey.dart';

enum SurveyStatus {
  initial,
  loading,
  ready,
  saving,
  submitting,
  success,
  failure,
}

class SurveyState extends Equatable {
  final SurveyStatus status;
  final List<Survey> surveys;
  final Survey? activeSurvey;
  final Map<String, dynamic> answers;

  final int pageIndex;
  final String? message;

  final bool goToRegistered;

  final bool isSending;
  final String? sendError;

  // Validación SOLO al presionar Siguiente/Finalizar
  final bool showValidationErrors;
  final List<String> invalidQuestionIds;
  final String? firstInvalidQuestionId;

  //DINARDARP
  final bool isDinardapLoading;
  final String? dinardapError;

  // GUARDADO AUTOMÁTICO
  final DateTime? lastSavedAt;

  const SurveyState({
    required this.status,
    required this.surveys,
    required this.activeSurvey,
    required this.answers,
    required this.pageIndex,
    required this.message,
    this.goToRegistered = false,
    this.isSending = false,
    this.sendError,
    this.showValidationErrors = false,
    this.invalidQuestionIds = const [],
    this.firstInvalidQuestionId,
    this.isDinardapLoading = false,
    this.dinardapError,
    this.lastSavedAt,
  });

  factory SurveyState.initial() => const SurveyState(
    status: SurveyStatus.initial,
    surveys: [],
    activeSurvey: null,
    answers: {},
    pageIndex: 0,
    message: null,
    goToRegistered: false,
    isSending: false,
    sendError: null,
    showValidationErrors: false,
    invalidQuestionIds: [],
    firstInvalidQuestionId: null,
    isDinardapLoading: false,
    dinardapError: null,
    lastSavedAt: null,
  );

  SurveyState copyWith({
    SurveyStatus? status,
    List<Survey>? surveys,
    Survey? activeSurvey,
    Map<String, dynamic>? answers,
    int? pageIndex,
    String? message,
    bool? goToRegistered,
    bool? isSending,
    String? sendError,
    bool? showValidationErrors,
    List<String>? invalidQuestionIds,
    String? firstInvalidQuestionId,
    bool? isDinardapLoading,
    String? dinardapError,
    DateTime? lastSavedAt,
  }) {
    return SurveyState(
      status: status ?? this.status,
      surveys: surveys ?? this.surveys,
      activeSurvey: activeSurvey ?? this.activeSurvey,
      answers: answers ?? this.answers,
      pageIndex: pageIndex ?? this.pageIndex,
      message: message,
      goToRegistered: goToRegistered ?? this.goToRegistered,
      isSending: isSending ?? this.isSending,
      sendError: sendError,
      showValidationErrors: showValidationErrors ?? this.showValidationErrors,
      invalidQuestionIds: invalidQuestionIds ?? this.invalidQuestionIds,
      firstInvalidQuestionId: firstInvalidQuestionId,
      isDinardapLoading: isDinardapLoading ?? this.isDinardapLoading,
      dinardapError: dinardapError,
      lastSavedAt: lastSavedAt ?? this.lastSavedAt,
    );
  }

  @override
  List<Object?> get props => [
    status,
    surveys,
    activeSurvey,
    answers,
    pageIndex,
    message,
    goToRegistered,
    isSending,
    sendError,
    showValidationErrors,
    invalidQuestionIds,
    firstInvalidQuestionId,
    isDinardapLoading,
    dinardapError,
    lastSavedAt,
  ];
}
