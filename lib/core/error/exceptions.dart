/// Excepción base del servidor
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() => message;
}

/// Excepción de autenticación (viene del Datasource)
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}
