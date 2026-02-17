class ApiConfig {
  // Configuración para desarrollo local
  static const String baseUrlLocal = 'http://localhost:8000';

  // Configuración para emulador Android
  static const String baseUrlAndroidEmulator = 'http://10.0.2.2:8000';

  // Configuración para dispositivo físico (ajustar según IP de la PC)
  static const String baseUrlDevice = 'http://192.168.1.100:8000';

  // Selecciona la URL según el entorno
  static String get baseUrl {
    // ⚠️ ACTUALIZADO: Usando tu IP de Wi-Fi detectada (10.235.38.152)
    return "http://10.235.38.152:8000";
  }

  // Endpoints (Actualizados según documentación oficial)
  static const String evaluateEndpoint = '/evaluar-ficha';
  static const String dashboardLatest = '/dashboard/latest';
  static const String dashboardRecent = '/dashboard/recent';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
