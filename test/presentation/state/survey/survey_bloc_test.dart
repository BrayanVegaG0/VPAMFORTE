import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ficha_vulnerabilidad/domain/entities/survey.dart';
import 'package:ficha_vulnerabilidad/domain/entities/question.dart';
import 'package:ficha_vulnerabilidad/domain/entities/survey_submission.dart';
import 'package:ficha_vulnerabilidad/domain/entities/survey_section.dart';
import 'package:ficha_vulnerabilidad/domain/entities/send_result.dart';

import 'package:ficha_vulnerabilidad/domain/usecases/get_surveys_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/save_survey_draft_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/load_survey_draft_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/finalize_to_pending_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/load_pending_submissions_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/send_pending_submissions_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/clear_survey_local_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/delete_pending_submission_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/clear_survey_draft_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/consult_dinardap_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/save_survey_history_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/get_survey_history_usecase.dart';

import 'package:ficha_vulnerabilidad/presentation/state/survey/survey_bloc.dart';
import 'package:ficha_vulnerabilidad/presentation/state/survey/survey_event.dart';
import 'package:ficha_vulnerabilidad/presentation/state/survey/survey_state.dart';

// Mocks
class MockGetSurveysUseCase extends Mock implements GetSurveysUseCase {}

class MockSaveSurveyDraftUseCase extends Mock
    implements SaveSurveyDraftUseCase {}

class MockLoadSurveyDraftUseCase extends Mock
    implements LoadSurveyDraftUseCase {}

class MockFinalizeToPendingUseCase extends Mock
    implements FinalizeToPendingUseCase {}

class MockLoadPendingSubmissionsUseCase extends Mock
    implements LoadPendingSubmissionsUseCase {}

class MockSendPendingSubmissionsUseCase extends Mock
    implements SendPendingSubmissionsUseCase {}

class MockClearSurveyLocalUseCase extends Mock
    implements ClearSurveyLocalUseCase {}

class MockDeletePendingSubmissionUseCase extends Mock
    implements DeletePendingSubmissionUseCase {}

class MockClearSurveyDraftUseCase extends Mock
    implements ClearSurveyDraftUseCase {}

class MockConsultDinardapUseCase extends Mock
    implements ConsultDinardapUseCase {}

class MockSaveSurveyHistoryUseCase extends Mock
    implements SaveSurveyHistoryUseCase {}

class MockGetSurveyHistoryUseCase extends Mock
    implements GetSurveyHistoryUseCase {}

class FakeSurveySubmission extends Fake implements SurveySubmission {}

void main() {
  late MockGetSurveysUseCase mockGetSurveys;
  late MockSaveSurveyDraftUseCase mockSaveDraft;
  late MockLoadSurveyDraftUseCase mockLoadDraft;
  late MockFinalizeToPendingUseCase mockFinalize;
  late MockLoadPendingSubmissionsUseCase mockLoadPending;
  late MockSendPendingSubmissionsUseCase mockSendPending;
  late MockClearSurveyLocalUseCase mockClearLocal;
  late MockDeletePendingSubmissionUseCase mockDeletePending;
  late MockClearSurveyDraftUseCase mockClearDraft;
  late MockConsultDinardapUseCase mockConsultDinardap;
  late MockSaveSurveyHistoryUseCase mockSaveHistory;
  late MockGetSurveyHistoryUseCase mockGetHistory;

  final fakeSurvey = Survey(
    id: 'survey-001',
    title: 'Encuesta Test',
    questions: [
      Question(
        id: 'q1',
        title: 'Pregunta radio',
        type: QuestionType.singleChoice,
        required: true,
        section: SurveySection.datosGenerales,
        options: [
          QuestionOption(id: '1', label: 'Opción A'),
          QuestionOption(id: '2', label: 'Opción B'),
        ],
      ),
      Question(
        id: 'q2',
        title: 'Pregunta sí/no',
        type: QuestionType.yesNo,
        required: true,
        section: SurveySection.datosGenerales,
      ),
    ],
  );

  setUpAll(() {
    registerFallbackValue(FakeSurveySubmission());
  });

  setUp(() {
    mockGetSurveys = MockGetSurveysUseCase();
    mockSaveDraft = MockSaveSurveyDraftUseCase();
    mockLoadDraft = MockLoadSurveyDraftUseCase();
    mockFinalize = MockFinalizeToPendingUseCase();
    mockLoadPending = MockLoadPendingSubmissionsUseCase();
    mockSendPending = MockSendPendingSubmissionsUseCase();
    mockClearLocal = MockClearSurveyLocalUseCase();
    mockDeletePending = MockDeletePendingSubmissionUseCase();
    mockClearDraft = MockClearSurveyDraftUseCase();
    mockConsultDinardap = MockConsultDinardapUseCase();
    mockSaveHistory = MockSaveSurveyHistoryUseCase();
    mockGetHistory = MockGetSurveyHistoryUseCase();

    when(() => mockGetSurveys()).thenAnswer((_) async => [fakeSurvey]);
    when(() => mockLoadDraft(any())).thenAnswer((_) async => null);
    when(() => mockSaveDraft(any())).thenAnswer((_) async {});
    when(() => mockFinalize(any())).thenAnswer((_) async {});
    when(() => mockLoadPending(any())).thenAnswer((_) async => []);
    when(() => mockSendPending(any())).thenAnswer(
      (_) async => const SendResult(successCount: 0, failureCount: 0),
    );
    when(() => mockClearLocal(any())).thenAnswer((_) async {});
    when(
      () => mockDeletePending(
        surveyId: any(named: 'surveyId'),
        createdAtIso: any(named: 'createdAtIso'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockClearDraft(any())).thenAnswer((_) async {});
    when(() => mockSaveHistory(any())).thenAnswer((_) async {});
    when(() => mockGetHistory()).thenAnswer((_) async => []);
  });

  SurveyBloc buildBloc() => SurveyBloc(
    getSurveysUseCase: mockGetSurveys,
    saveSurveyDraftUseCase: mockSaveDraft,
    loadSurveyDraftUseCase: mockLoadDraft,
    finalizeToPendingUseCase: mockFinalize,
    loadPendingSubmissionsUseCase: mockLoadPending,
    sendPendingSubmissionsUseCase: mockSendPending,
    clearSurveyLocalUseCase: mockClearLocal,
    deletePendingSubmissionUseCase: mockDeletePending,
    clearSurveyDraftUseCase: mockClearDraft,
    consultDinardapUseCase: mockConsultDinardap,
    saveSurveyHistoryUseCase: mockSaveHistory,
    getSurveyHistoryUseCase: mockGetHistory,
  );

  test('estado inicial es SurveyState.initial()', () {
    final bloc = buildBloc();
    expect(bloc.state, SurveyState.initial());
    bloc.close();
  });

  blocTest<SurveyBloc, SurveyState>(
    'emite [loading, ready] cuando SurveyLoadRequested es exitoso (sin borrador)',
    build: buildBloc,
    act: (b) => b.add(const SurveyLoadRequested()),
    expect: () => [
      SurveyState.initial().copyWith(status: SurveyStatus.loading),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: {},
        pageIndex: 0,
        message: null,
      ),
    ],
    verify: (_) {
      verify(() => mockGetSurveys()).called(1);
      verify(() => mockLoadDraft('survey-001')).called(1);
    },
  );

  blocTest<SurveyBloc, SurveyState>(
    'carga borrador desde local si existe (answers precargadas)',
    build: () {
      when(() => mockLoadDraft('survey-001')).thenAnswer((_) async {
        return SurveySubmission(
          surveyId: 'survey-001',
          createdAt: DateTime(2026, 1, 1),
          updatedAt: DateTime(2026, 1, 1),
          answers: const {'q1': '2'},
          status: SubmissionStatus.draft,
          attempts: 0,
          lastError: null,
        );
      });
      return buildBloc();
    },
    act: (b) => b.add(const SurveyLoadRequested()),
    expect: () => [
      SurveyState.initial().copyWith(status: SurveyStatus.loading),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: const {'q1': '2'},
        pageIndex: 0,
        message: 'Borrador cargado desde almacenamiento local.',
      ),
    ],
  );

  blocTest<SurveyBloc, SurveyState>(
    'SurveyAnswerChanged actualiza answers y guarda draft (saveSurveyDraftUseCase)',
    build: buildBloc,
    act: (b) async {
      b.add(const SurveyLoadRequested());
      await Future<void>.delayed(Duration.zero);
      b.add(const SurveyAnswerChanged(questionId: 'q1', value: '1'));
    },
    expect: () => [
      SurveyState.initial().copyWith(status: SurveyStatus.loading),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: {},
        pageIndex: 0,
        message: null,
      ),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: const {'q1': '1'},
        pageIndex: 0,
        message: null,
      ),
    ],
    verify: (_) {
      verify(() => mockSaveDraft(any())).called(1);
    },
  );

  blocTest<SurveyBloc, SurveyState>(
    'SurveyFinalizeRequested falla si falta requerida (q2)',
    build: buildBloc,
    act: (b) async {
      b.add(const SurveyLoadRequested());
      await Future<void>.delayed(Duration.zero);
      b.add(const SurveyAnswerChanged(questionId: 'q1', value: '1'));
      await Future<void>.delayed(Duration.zero);
      b.add(const SurveyFinalizeRequested());
    },
    expect: () => [
      SurveyState.initial().copyWith(status: SurveyStatus.loading),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: {},
        pageIndex: 0,
        message: null,
      ),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: const {'q1': '1'},
        pageIndex: 0,
        message: null,
      ),
      isA<SurveyState>().having(
        (s) => s.status,
        'status',
        SurveyStatus.failure,
      ),
      isA<SurveyState>().having((s) => s.status, 'status', SurveyStatus.ready),
    ],
    verify: (_) {
      verifyNever(() => mockFinalize(any()));
    },
  );

  blocTest<SurveyBloc, SurveyState>(
    'SurveyFinalizeRequested guarda pending si todas requeridas están completas',
    build: buildBloc,
    act: (b) async {
      b.add(const SurveyLoadRequested());
      await Future<void>.delayed(Duration.zero);

      b.add(const SurveyAnswerChanged(questionId: 'q1', value: '1'));
      await Future<void>.delayed(Duration.zero);

      b.add(const SurveyAnswerChanged(questionId: 'q2', value: true));
      await Future<void>.delayed(Duration.zero);

      b.add(const SurveyFinalizeRequested());
    },
    expect: () => [
      SurveyState.initial().copyWith(status: SurveyStatus.loading),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: {},
        pageIndex: 0,
        message: null,
      ),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: const {'q1': '1'},
        pageIndex: 0,
        message: null,
      ),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: const {'q1': '1', 'q2': true},
        pageIndex: 0,
        message: null,
      ),
      SurveyState.initial().copyWith(
        status: SurveyStatus.submitting,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: const {'q1': '1', 'q2': true},
        pageIndex: 0,
        message: null,
      ),
      isA<SurveyState>().having(
        (s) => s.status,
        'status',
        SurveyStatus.success,
      ),
      isA<SurveyState>().having((s) => s.status, 'status', SurveyStatus.ready),
    ],
    verify: (_) {
      verify(() => mockFinalize(any())).called(1);
    },
  );

  blocTest<SurveyBloc, SurveyState>(
    'SendPendingSubmissions emite isSending true/false y llama usecase',
    build: buildBloc,
    act: (b) async {
      b.add(const SurveyLoadRequested());
      await Future<void>.delayed(Duration.zero);
      b.add(const SendPendingSubmissions('survey-001'));
    },
    expect: () => [
      // load
      SurveyState.initial().copyWith(status: SurveyStatus.loading),
      SurveyState.initial().copyWith(
        status: SurveyStatus.ready,
        surveys: [fakeSurvey],
        activeSurvey: fakeSurvey,
        answers: {},
        pageIndex: 0,
        message: null,
      ),
      // send pending
      isA<SurveyState>().having((s) => s.isSending, 'isSending', true),
      isA<SurveyState>().having((s) => s.isSending, 'isSending', false),
    ],
    verify: (_) {
      verify(() => mockSendPending('survey-001')).called(1);
    },
  );
}
