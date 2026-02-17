import '../entities/ficha_vpam.dart';
import '../entities/response_vpam.dart';

abstract class VpamRepository {
  Future<ResponseVPAM> evaluateFicha(FichaVPAM ficha);
  Future<ResponseVPAM> getLatestEvaluation();
  Future<List<ResponseVPAM>> getRecentEvaluations({int limit = 20});
}
