import '../entities/geo/canton.dart';
import '../repositories/geo_repository.dart';

class GetCantonsByProvinceUseCase {
  final GeoRepository repo;
  GetCantonsByProvinceUseCase(this.repo);

  Future<List<Canton>> call(int provinceId) => repo.getCantonsByProvince(provinceId);
}
