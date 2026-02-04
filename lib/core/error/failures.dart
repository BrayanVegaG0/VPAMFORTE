import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure([this.message]);

  @override
  List<Object?> get props => [message];
}

/// Fallo por falta de conexión o timeout
class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

/// Fallo del servidor (500, 404, respuestas malformadas)
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Fallo de autenticación (Credenciales incorrectas, usuario bloqueado)
class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}

/// Fallo inesperado (Desconocido)
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message]);
}
