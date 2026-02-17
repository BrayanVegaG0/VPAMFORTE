import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ficha_vulnerabilidad/core/config/api_config.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Realiza una petición POST a la API
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');

      print('🔵 POST Request to: $url');
      // print('📦 Body: ${jsonEncode(body)}'); // Descomentar para debug si es necesario

      final response = await _client
          .post(
            url,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.connectionTimeout);

      print('📥 Response Status: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } on SocketException catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Sin conexión a internet. Verifica tu red.',
        originalError: e,
      );
    } on http.ClientException catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Error de conexión con el servidor.',
        originalError: e,
      );
    } on FormatException catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Respuesta del servidor inválida.',
        originalError: e,
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Error inesperado: ${e.toString()}',
        originalError: e,
      );
    }
  }

  /// Realiza una petición GET a la API
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');

      print('🔵 GET Request to: $url');

      final response = await _client
          .get(url, headers: {'Accept': 'application/json'})
          .timeout(ApiConfig.receiveTimeout);

      print('📥 Response Status: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } on SocketException catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Sin conexión a internet.',
        originalError: e,
      );
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Error al obtener datos: ${e.toString()}',
        originalError: e,
      );
    }
  }

  String _extractErrorMessage(http.Response response) {
    try {
      final Map<String, dynamic> errorBody = jsonDecode(response.body);
      return errorBody['detail'] ?? errorBody['message'] ?? 'Error desconocido';
    } catch (_) {
      return 'Error ${response.statusCode}: ${response.reasonPhrase}';
    }
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic originalError;

  ApiException({
    required this.statusCode,
    required this.message,
    this.originalError,
  });

  @override
  String toString() => message;
}
