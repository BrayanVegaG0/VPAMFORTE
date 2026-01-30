import 'package:equatable/equatable.dart';

abstract class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object?> get props => [];
}

class SurveyLoadRequested extends SurveyEvent {
  const SurveyLoadRequested();
}

class SurveyAnswerChanged extends SurveyEvent {
  final String questionId;
  final dynamic value;

  const SurveyAnswerChanged({required this.questionId, required this.value});

  @override
  List<Object?> get props => [questionId, value];
}

class SurveyNextPageRequested extends SurveyEvent {
  const SurveyNextPageRequested();
}

class SurveyPrevPageRequested extends SurveyEvent {
  const SurveyPrevPageRequested();
}

class SurveyJumpToPageRequested extends SurveyEvent {
  final int pageIndex;
  const SurveyJumpToPageRequested({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];
}

class SurveyFinalizeRequested extends SurveyEvent {
  const SurveyFinalizeRequested();
}

class SendPendingSubmissions extends SurveyEvent {
  final String surveyId;
  final List<String> selectedCreatedAtIso;

  const SendPendingSubmissions(
    this.surveyId, {
    this.selectedCreatedAtIso = const [],
  });

  @override
  List<Object?> get props => [surveyId, selectedCreatedAtIso];
}

class SurveyClearLocalRequested extends SurveyEvent {
  const SurveyClearLocalRequested();
}

class DeletePendingSubmissionRequested extends SurveyEvent {
  final String surveyId;
  final String createdAtIso;

  const DeletePendingSubmissionRequested({
    required this.surveyId,
    required this.createdAtIso,
  });

  @override
  List<Object?> get props => [surveyId, createdAtIso];
}

class SurveyClearDraftRequested extends SurveyEvent {
  const SurveyClearDraftRequested();
}

class SurveyCedulaCompleted extends SurveyEvent {
  final String cedula;
  const SurveyCedulaCompleted(this.cedula);

  @override
  List<Object?> get props => [cedula];
}
