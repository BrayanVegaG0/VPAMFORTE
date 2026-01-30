import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// imports tuyos...
import 'presentation/pages/splash_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/surveys_page.dart';
import 'presentation/pages/registered_surveys_page.dart';
import 'presentation/pages/about_of_page.dart';
import 'presentation/pages/usuario_consentimiento_page.dart';

import 'presentation/state/auth/auth_bloc.dart';
import 'presentation/state/auth/auth_event.dart';
import 'presentation/state/survey/survey_bloc.dart';
import 'presentation/state/survey/survey_event.dart';

// datasources/repos/usecases tuyos...
import 'data/datasources/remote/auth_remote_datasource.dart';
import 'data/datasources/local/auth_local_datasource.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';

import 'data/datasources/remote/survey_remote_datasource.dart';
import 'data/datasources/remote/survey_soap_remote_datasource.dart';
import 'data/datasources/local/survey_local_datasource.dart';
import 'data/repositories_impl/survey_repository_impl.dart';
import 'domain/usecases/get_surveys_usecase.dart';
import 'domain/usecases/save_survey_draft_usecase.dart';
import 'domain/usecases/load_survey_draft_usecase.dart';
import 'domain/usecases/finalize_to_pending_usecase.dart';
import 'domain/usecases/load_pending_submissions_usecase.dart';
import 'domain/usecases/send_pending_submissions_usecase.dart';
import 'domain/usecases/clear_survey_local_usecase.dart';
import 'domain/usecases/delete_pending_submission_usecase.dart';
import 'domain/usecases/clear_survey_draft_usecase.dart';

import 'data/mappers/survey_answers_to_ficha_db_mapper.dart';
import 'data/datasources/remote/soap/ficha_soap_serializer.dart';

import 'data/datasources/remote/dinardap_soap_remote_datasource.dart';
import 'data/repositories_impl/dinardap_repository_impl.dart';
import 'domain/usecases/consult_dinardap_usecase.dart';

class App extends StatefulWidget {
  final Future<SharedPreferences> prefsFuture;
  const App({super.key, required this.prefsFuture});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    widget.prefsFuture.then((p) {
      if (!mounted) return;
      setState(() => _prefs = p);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1) Mientras carga prefs => Splash Flutter (SIEMPRE)
    if (_prefs == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      );
    }

    final prefs = _prefs!;

    // 2) Una vez prefs listos => construyes TODO como ya lo tenías
    final authRemote = AuthRemoteDataSourceSoap(client: http.Client());
    final authLocal = AuthLocalDataSourcePrefs(prefs: prefs);
    final authRepo = AuthRepositoryImpl(remote: authRemote, local: authLocal);

    final loginUseCase = LoginUseCase(authRepo);
    final logoutUseCase = LogoutUseCase(authRepo);

    final surveyRemote = SurveyRemoteDataSourceFake();
    final surveySoap = SurveySoapRemoteDataSourceHttp(client: http.Client());
    final surveyLocal = SurveyLocalDataSourcePrefs(prefs: prefs);
    final fichaMapper = SurveyAnswersToFichaDbMapper();
    final soapSerializer = FichaSoapSerializer();

    final surveyRepo = SurveyRepositoryImpl(
      remote: surveyRemote,
      soap: surveySoap,
      local: surveyLocal,
      authLocal: authLocal,
      fichaMapper: fichaMapper,
      soapSerializer: soapSerializer,
    );

    final getSurveysUseCase = GetSurveysUseCase(surveyRepo);
    final saveSurveyDraftUseCase = SaveSurveyDraftUseCase(surveyRepo);
    final loadSurveyDraftUseCase = LoadSurveyDraftUseCase(surveyRepo);
    final finalizeToPendingUseCase = FinalizeToPendingUseCase(surveyRepo);
    final loadPendingSubmissionsUseCase = LoadPendingSubmissionsUseCase(
      surveyRepo,
    );
    final sendPendingSubmissionsUseCase = SendPendingSubmissionsUseCase(
      surveyRepo,
    );
    final clearSurveyLocalUseCase = ClearSurveyLocalUseCase(surveyRepo);
    final deletePendingSubmissionUseCase = DeletePendingSubmissionUseCase(
      surveyRepo,
    );
    final clearSurveyDraftUseCase = ClearSurveyDraftUseCase(surveyRepo);

    final dinardapRemote = DinardapSoapRemoteDataSourceHttp(
      client: http.Client(),
      authLocal: authLocal,
    );
    final dinardapRepo = DinardapRepositoryImpl(remote: dinardapRemote);
    final consultDinardapUseCase = ConsultDinardapUseCase(dinardapRepo);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            loginUseCase: loginUseCase,
            logoutUseCase: logoutUseCase,
            localDataSource: authLocal,
          )..add(const AuthCheckSessionRequested()),
        ),
        BlocProvider<SurveyBloc>(
          create: (_) => SurveyBloc(
            getSurveysUseCase: getSurveysUseCase,
            saveSurveyDraftUseCase: saveSurveyDraftUseCase,
            loadSurveyDraftUseCase: loadSurveyDraftUseCase,
            finalizeToPendingUseCase: finalizeToPendingUseCase,
            loadPendingSubmissionsUseCase: loadPendingSubmissionsUseCase,
            sendPendingSubmissionsUseCase: sendPendingSubmissionsUseCase,
            clearSurveyLocalUseCase: clearSurveyLocalUseCase,
            deletePendingSubmissionUseCase: deletePendingSubmissionUseCase,
            clearSurveyDraftUseCase: clearSurveyDraftUseCase,
            consultDinardapUseCase: consultDinardapUseCase,
          )..add(const SurveyLoadRequested()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Tema general de la aplicación
          useMaterial3: true,

          // Configuración del AppBar
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF1565C0), // Fondo azul oscuro
            foregroundColor: Colors.white, // Iconos y texto en blanco
            elevation: 2,
            centerTitle: false,
            titleTextStyle: const TextStyle(
              color: Colors.blue, // Título en azul claro
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(
              color: Colors.white, // Iconos en blanco
            ),
          ),

          // Color primario de la app
          primaryColor: const Color(0xFF1565C0),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1565C0),
            primary: const Color(0xFF1565C0),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashPage(),
          '/': (_) => const HomePage(),
          '/login': (_) => const LoginPage(),
          '/surveys': (_) => const SurveysPage(),
          '/registered_surveys': (_) => const RegisteredSurveysPage(),
          '/about_of': (_) => const AboutOfPage(),
          '/usuario_consentimiento': (_) => const UsuarioConsentimientoPage(),
        },
      ),
    );
  }
}
