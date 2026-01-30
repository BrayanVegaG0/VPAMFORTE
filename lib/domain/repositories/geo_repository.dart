import '../entities/geo/province.dart';
import '../entities/geo/canton.dart';
import '../entities/geo/parish.dart';

abstract class GeoRepository {
  Future<List<Province>> getProvinces();
  Future<List<Canton>> getCantonsByProvince(int provinceId);
  Future<List<Parish>> getParishesByCanton(int cantonId);
}