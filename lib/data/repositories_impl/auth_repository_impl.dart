import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  const AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<User> login({required String username, required String password}) async {
    final user = await remote.login(username: username, password: password);
    await local.saveSession(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await local.clearSession();
    await remote.logout();
  }
}
