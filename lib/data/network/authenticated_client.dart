import 'package:http/http.dart' as http;
import '../datasources/local/auth_local_datasource.dart';

/// Cliente HTTP que inyecta token en cada request.
/// Útil para consumir otros servicios (REST o incluso SOAP si lo requieren).
class AuthenticatedClient extends http.BaseClient {
  final http.Client inner;
  final AuthLocalDataSource local;

  /// Cambia el nombre del header si tu backend lo pide distinto.
  /// Ejemplos: 'Authorization' (Bearer), 'token', 'X-Auth-Token'
  final String tokenHeaderName;

  /// Si usas Bearer, deja esto en true.
  final bool bearer;

  AuthenticatedClient({
    required this.inner,
    required this.local,
    this.tokenHeaderName = 'Authorization',
    this.bearer = true,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await local.getToken();
    if (token != null) {
      request.headers[tokenHeaderName] = bearer ? 'Bearer $token' : token;
    }
    return inner.send(request);
  }
}
