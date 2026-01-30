import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ficha_vulnerabilidad/domain/entities/user.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/login_usecase.dart';
import 'package:ficha_vulnerabilidad/domain/usecases/logout_usecase.dart';

import 'package:ficha_vulnerabilidad/presentation/state/auth/auth_bloc.dart';
import 'package:ficha_vulnerabilidad/presentation/state/auth/auth_event.dart';
import 'package:ficha_vulnerabilidad/presentation/state/auth/auth_state.dart';
import 'package:ficha_vulnerabilidad/data/datasources/local/auth_local_datasource.dart';

// Mocks
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}
class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late MockLoginUseCase loginUseCase;
  late MockLogoutUseCase logoutUseCase;
  late MockAuthLocalDataSource local;

  const user = User(
    idUser: '242814',
    nombre: 'KEVIN IVAN',
    token: 'abc123',
    roles: ['VULNERABILIDAD'],
  );

  setUp(() {
    loginUseCase = MockLoginUseCase();
    logoutUseCase = MockLogoutUseCase();
    local = MockAuthLocalDataSource();

    // Stubs por seguridad para evitar "MissingStubError" si tu AuthBloc los llama.
    when(() => local.saveSession(any())).thenAnswer((_) async {});
    when(() => local.saveBasicAuthCredentials(username: any(named: 'username'), password: any(named: 'password')))
        .thenAnswer((_) async {});
    when(() => local.clearSession()).thenAnswer((_) async {});
    when(() => local.getSession()).thenAnswer((_) async => null);
  });

  blocTest<AuthBloc, AuthState>(
    'emite [AuthLoading, AuthAuthenticated] cuando login es exitoso',
    build: () {
      when(() => loginUseCase(username: any(named: 'username'), password: any(named: 'password')))
          .thenAnswer((_) async => user);

      return AuthBloc(
        loginUseCase: loginUseCase,
        logoutUseCase: logoutUseCase,
        localDataSource: local,
      );
    },
    act: (bloc) => bloc.add(const AuthLoginRequested(username: 'u', password: 'p')),
    expect: () => [
      const AuthLoading(),
      const AuthAuthenticated(user),
    ],
    verify: (_) {
      verify(() => loginUseCase(username: 'u', password: 'p')).called(1);
      verify(() => local.saveSession(user)).called(1);
      verify(() => local.saveBasicAuthCredentials(username: 'u', password: 'p')).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emite [AuthLoading, AuthFailure, AuthUnauthenticated] cuando login falla',
    build: () {
      when(() => loginUseCase(username: any(named: 'username'), password: any(named: 'password')))
          .thenThrow(Exception('E002: CREDENCIALES INCORRECTAS'));

      return AuthBloc(
        loginUseCase: loginUseCase,
        logoutUseCase: logoutUseCase,
        localDataSource: local,
      );
    },
    act: (bloc) => bloc.add(const AuthLoginRequested(username: 'u', password: 'bad')),
    expect: () => [
      const AuthLoading(),
      isA<AuthFailure>(),
      const AuthUnauthenticated(),
    ],
    verify: (_) {
      verify(() => loginUseCase(username: 'u', password: 'bad')).called(1);
      verifyNever(() => local.saveSession(any()));
      verifyNever(() => local.saveBasicAuthCredentials(username: any(named: 'username'), password: any(named: 'password')));
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emite [AuthLoading, AuthUnauthenticated] cuando no hay sesión en AuthCheckSessionRequested',
    build: () {
      when(() => local.getSession()).thenAnswer((_) async => null);

      return AuthBloc(
        loginUseCase: loginUseCase,
        logoutUseCase: logoutUseCase,
        localDataSource: local,
      );
    },
    act: (bloc) => bloc.add(const AuthCheckSessionRequested()),
    expect: () => [
      const AuthLoading(),
      const AuthUnauthenticated(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emite [AuthLoading, AuthAuthenticated] cuando hay sesión en AuthCheckSessionRequested',
    build: () {
      when(() => local.getSession()).thenAnswer((_) async => user);

      return AuthBloc(
        loginUseCase: loginUseCase,
        logoutUseCase: logoutUseCase,
        localDataSource: local,
      );
    },
    act: (bloc) => bloc.add(const AuthCheckSessionRequested()),
    expect: () => [
      const AuthLoading(),
      const AuthAuthenticated(user),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'logout emite [AuthLoading, AuthUnauthenticated] cuando logout es exitoso',
    build: () {
      when(() => logoutUseCase()).thenAnswer((_) async {});
      return AuthBloc(
        loginUseCase: loginUseCase,
        logoutUseCase: logoutUseCase,
        localDataSource: local,
      );
    },
    act: (bloc) => bloc.add(const AuthLogoutRequested()),
    expect: () => [
      const AuthLoading(),
      const AuthUnauthenticated(),
    ],
    verify: (_) {
      verify(() => logoutUseCase()).called(1);
      verify(() => local.clearSession()).called(1);
    },
  );
}
