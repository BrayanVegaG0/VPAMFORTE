import 'dart:io';
import 'package:http/http.dart';

import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart'
    as core_error; // Tu nueva clase ServerException está aquí, AuthException puede seguir viniendo del datasource o de aquí si la unificas.
// Si AuthException sigue en datasource, impórtalo o usa alias.
// Asumo que AuthException viene de remote datasource o exceptions.dart.
// Vamos a importar exceptions.dart que acabas de crear.

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart'; // Aquí estaba AuthException original
import '../datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  const AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    try {
      final user = await remote.login(username: username, password: password);
      await local.saveSession(user);
      return user;
    } on SocketException {
      throw const NetworkFailure();
    } on ClientException {
      throw const NetworkFailure();
    } on AuthException catch (e) {
      // Ojo: AuthException viene del datasource (según tu código previo)
      // o de core/error/exceptions.dart si refactorizaste.
      // Asumo que el datasource lanza AuthException.
      throw AuthFailure(e.message);
    } on core_error.AuthException catch (e) {
      // Por si acaso lanzas la del core en algún lado
      throw AuthFailure(e.message);
    } on core_error.ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw UnexpectedFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await local.clearSession();
      await remote.logout();
    } catch (_) {
      // Logout fallido localmente no debería bloquear al usuario, pero
      // si quieres strict check:
      // throw UnexpectedFailure();
    }
  }
}
