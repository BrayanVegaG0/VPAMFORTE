import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/local/auth_local_datasource.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

import '../../../core/error/failures.dart' hide AuthFailure;
import '../../utils/failure_mapper.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthLocalDataSource localDataSource;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.localDataSource,
  }) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckSessionRequested>(_onCheckSession);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await loginUseCase(
        username: event.username,
        password: event.password,
      );

      // ... guardado de sesión ...
      await localDataSource.saveSession(user);
      await localDataSource.saveBasicAuthCredentials(
        username: event.username,
        password: event.password,
      );

      emit(AuthAuthenticated(user));
    } on Failure catch (f) {
      final msg = FailureMapper.mapFailureToMessage(f);
      emit(AuthFailure(msg));
      emit(const AuthUnauthenticated());
    } catch (e) {
      // Fallback para errores no mapeados (aunque el repo debería atrapar todo)
      emit(AuthFailure("Error desconocido: $e"));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await logoutUseCase();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onCheckSession(
    AuthCheckSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final user = await localDataSource.getSession();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }
}
