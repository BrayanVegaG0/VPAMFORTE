import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/user.dart';
import '../../models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BasicAuthCredentials {
  final String username;
  final String password;
  const BasicAuthCredentials({required this.username, required this.password});
}

abstract class AuthLocalDataSource {
  Future<void> saveSession(User user);
  Future<User?> getSession();
  Future<void> clearSession();
  Future<String?> getToken();

  Future<void> saveBasicAuthCredentials({
    required String username,
    required String password,
  });

  Future<BasicAuthCredentials?> getBasicAuthCredentials();
  Future<void> clearBasicAuthCredentials();
}

class AuthLocalDataSourcePrefs implements AuthLocalDataSource {
  static const _kIdUser = 'auth_iduser';
  static const _kNombre = 'auth_nombre';
  static const _kToken = 'auth_token';
  static const _kRoles = 'auth_roles';

  // Secure keys
  static const _kUserSecure = 'basic_auth_user';
  static const _kPassSecure = 'basic_auth_pass';

  final SharedPreferences prefs;
  final FlutterSecureStorage secure;

  AuthLocalDataSourcePrefs({
    required this.prefs,
    FlutterSecureStorage? secure,
  }) : secure = secure ?? const FlutterSecureStorage();

  @override
  Future<void> saveSession(User user) async {
    await prefs.setString(_kIdUser, user.idUser);
    await prefs.setString(_kNombre, user.nombre);
    await prefs.setString(_kToken, user.token);
    await prefs.setStringList(_kRoles, user.roles);
  }

  @override
  Future<void> saveBasicAuthCredentials({
    required String username,
    required String password,
  }) async {
    await secure.write(key: _kUserSecure, value: username);
    await secure.write(key: _kPassSecure, value: password);
  }

  @override
  Future<BasicAuthCredentials?> getBasicAuthCredentials() async {
    final u = await secure.read(key: _kUserSecure);
    final p = await secure.read(key: _kPassSecure);
    if (u == null || u.isEmpty || p == null || p.isEmpty) return null;
    return BasicAuthCredentials(username: u, password: p);
  }

  @override
  Future<void> clearBasicAuthCredentials() async {
    await secure.delete(key: _kUserSecure);
    await secure.delete(key: _kPassSecure);
  }

  @override
  Future<User?> getSession() async {
    final token = prefs.getString(_kToken);
    if (token == null || token.isEmpty) return null;

    final idUser = prefs.getString(_kIdUser) ?? '';
    final nombre = prefs.getString(_kNombre) ?? '';
    final roles = prefs.getStringList(_kRoles) ?? const <String>[];

    if (idUser.isEmpty || nombre.isEmpty) return null;

    return UserModel(
      idUser: idUser,
      nombre: nombre,
      token: token,
      roles: roles,
    );
  }

  @override
  Future<void> clearSession() async {
    await prefs.remove(_kIdUser);
    await prefs.remove(_kNombre);
    await prefs.remove(_kToken);
    await prefs.remove(_kRoles);
    await clearBasicAuthCredentials();
  }

  @override
  Future<String?> getToken() async {
    final t = prefs.getString(_kToken);
    if (t == null || t.isEmpty) return null;
    return t;
  }


}
