import 'package:ficha_vulnerabilidad/domain/entities/ficha_vpam.dart';
import 'package:ficha_vulnerabilidad/domain/entities/response_vpam.dart';
import 'package:ficha_vulnerabilidad/domain/repositories/vpam_repository.dart';

class EvaluateVpamUseCase {
  final VpamRepository _repository;

  EvaluateVpamUseCase(this._repository);

  Future<ResponseVPAM> execute(FichaVPAM ficha) {
    return _repository.evaluateFicha(ficha);
  }
}
