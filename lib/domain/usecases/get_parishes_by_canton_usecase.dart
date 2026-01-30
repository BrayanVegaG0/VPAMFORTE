import '../entities/geo/parish.dart';
import '../repositories/geo_repository.dart';

class GetParishesByCantonUseCase {
  final GeoRepository repo;
  GetParishesByCantonUseCase(this.repo);

  Future<List<Parish>> call(int cantonId) => repo.getParishesByCanton(cantonId);
}
