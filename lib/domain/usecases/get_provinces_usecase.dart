import '../entities/geo/province.dart';
import '../repositories/geo_repository.dart';

class GetProvincesUseCase {
  final GeoRepository repo;
  GetProvincesUseCase(this.repo);

  Future<List<Province>> call() => repo.getProvinces();
}
