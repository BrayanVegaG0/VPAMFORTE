import '../../domain/entities/geo/province.dart';
import '../../domain/entities/geo/canton.dart';
import '../../domain/entities/geo/parish.dart';
import '../../domain/repositories/geo_repository.dart';
import '../datasources/local/geo_local_datasource.dart';
import '../mappers/geo_mapper.dart';

class GeoRepositoryImpl implements GeoRepository {
  final GeoLocalDataSource local;
  final GeoMapper mapper;

  GeoRepositoryImpl({required this.local, required this.mapper});

  @override
  Future<List<Province>> getProvinces() async {
    final bundle = await local.loadAll();
    return bundle.provinces.map(mapper.toProvince).toList();
  }

  @override
  Future<List<Canton>> getCantonsByProvince(int provinceId) async {
    final bundle = await local.loadAll();
    final list = bundle.cantonsByProvinceId[provinceId] ?? const [];
    return list.map(mapper.toCanton).toList();
  }

  @override
  Future<List<Parish>> getParishesByCanton(int cantonId) async {
    final bundle = await local.loadAll();
    final list = bundle.parishesByCantonId[cantonId] ?? const [];
    return list.map(mapper.toParish).toList();
  }
}
