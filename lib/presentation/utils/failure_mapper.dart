import '../../core/error/failures.dart';

class FailureMapper {
  static String mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No hay conexión a internet. Verifica tu red.';
    } else if (failure is ServerFailure) {
      return 'Problema con el servidor. Intenta más tarde. (${failure.message})';
    } else if (failure is AuthFailure) {
      // Si el mensaje es E002, es más amigable
      if (failure.message?.contains('E002') ?? false) {
        return 'Credenciales incorrectas. Verifica tu cédula o contraseña.';
      }
      return failure.message ?? 'Error de autenticación.';
    } else {
      return 'Ocurrió un error inesperado. (${failure.message})';
    }
  }
}
