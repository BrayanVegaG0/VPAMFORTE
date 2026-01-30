import '../../domain/entities/geo/province.dart';
import '../../domain/entities/geo/canton.dart';
import '../../domain/entities/geo/parish.dart';
import '../models/geo/province_model.dart';
import '../models/geo/canton_model.dart';
import '../models/geo/parish_model.dart';

class GeoMapper {
  Province toProvince(ProvinceModel m) => Province(id: m.id, name: m.name, zone: m.zone);
  Canton toCanton(CantonModel m) => Canton(id: m.id, name: m.name, provinceId: m.provinceId);
  Parish toParish(ParishModel m) => Parish(id: m.id, name: m.name, cantonId: m.cantonId, idDummy: m.idDummy);
}