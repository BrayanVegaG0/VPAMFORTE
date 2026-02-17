import 'package:ficha_vulnerabilidad/core/config/api_config.dart';
import 'package:ficha_vulnerabilidad/domain/entities/ficha_vpam.dart';
import 'package:ficha_vulnerabilidad/domain/entities/response_vpam.dart';
import 'package:ficha_vulnerabilidad/domain/repositories/vpam_repository.dart';
import 'package:ficha_vulnerabilidad/data/datasources/remote/api_service.dart';

class VpamRepositoryImpl implements VpamRepository {
  final ApiService _apiService;

  VpamRepositoryImpl({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  @override
  Future<ResponseVPAM> evaluateFicha(FichaVPAM ficha) async {
    final response = await _apiService.post(ApiConfig.evaluateEndpoint, {
      'datos': ficha.toJson(),
    });
    return ResponseVPAM.fromJson(response);
  }

  @override
  Future<ResponseVPAM> getLatestEvaluation() async {
    final response = await _apiService.get(ApiConfig.dashboardLatest);
    return ResponseVPAM.fromJson(response);
  }

  @override
  Future<List<ResponseVPAM>> getRecentEvaluations({int limit = 20}) async {
    final response = await _apiService.get(
      '${ApiConfig.dashboardRecent}?limit=$limit',
    );

    if (response['data'] is List) {
      return (response['data'] as List)
          .map((item) => ResponseVPAM.fromJson(item))
          .toList();
    }

    // Si la API devuelve la lista directamente (depende de la implementación exacta del backend)
    // Según las instrucciones, parece que devuelve el objeto directamente si es una lista.
    if (response is List) {
      return (response as List)
          .map((item) => ResponseVPAM.fromJson(item))
          .toList();
    }

    return [];
  }
}
