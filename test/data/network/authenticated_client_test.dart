import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:ficha_vulnerabilidad/data/network/authenticated_client.dart';
import 'package:ficha_vulnerabilidad/data/datasources/local/auth_local_datasource.dart';
import 'package:ficha_vulnerabilidad/domain/entities/user.dart';
import 'package:ficha_vulnerabilidad/data/models/user_model.dart';

class FakeAuthLocalDataSource implements AuthLocalDataSource {
  User? _user;

  BasicAuthCredentials? _basicCredentials;

  FakeAuthLocalDataSource({User? user}) : _user = user;

  @override
  Future<void> saveSession(User user) async => _user = user;

  @override
  Future<User?> getSession() async => _user;

  @override
  Future<void> clearSession() async {
    _user = null;
    // Opcional: Si tu lógica de negocio limpia todo junto, también limpia esto:
    _basicCredentials = null;
  }

  @override
  Future<String?> getToken() async => _user?.token;

  // --- IMPLEMENTACIÓN CORREGIDA DE LOS MÉTODOS FALTANTES ---

  @override
  Future<void> saveBasicAuthCredentials({
    required String username,
    required String password,
  }) async {
    // Guardamos en memoria simulando el SecureStorage
    _basicCredentials = BasicAuthCredentials(username: username, password: password);
  }

  @override
  Future<BasicAuthCredentials?> getBasicAuthCredentials() async {
    return _basicCredentials;
  }

  @override
  Future<void> clearBasicAuthCredentials() async {
    _basicCredentials = null;
  }
}

void main() {
  test('AuthenticatedClient agrega Authorization Bearer token', () async {
    final local = FakeAuthLocalDataSource(
      user: const UserModel(
        idUser: '1',
        nombre: 'N',
        token: 't0k3n',
        roles: [],
      ),
    );

    final inner = MockClient((req) async {
      expect(req.headers['Authorization'], 'Bearer t0k3n');
      return http.Response('ok', 200);
    });

    final client = AuthenticatedClient(inner: inner, local: local);

    final resp = await client.get(Uri.parse('https://example.com/api'));
    expect(resp.statusCode, 200);
  });

  test('AuthenticatedClient no agrega header si no hay token', () async {
    final local = FakeAuthLocalDataSource(user: null);

    final inner = MockClient((req) async {
      expect(req.headers.containsKey('Authorization'), false);
      return http.Response('ok', 200);
    });

    final client = AuthenticatedClient(inner: inner, local: local);

    final resp = await client.get(Uri.parse('https://example.com/api'));
    expect(resp.statusCode, 200);
  });
}
