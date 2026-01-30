import 'dart:convert';
import 'package:flutter/services.dart';

import '../../models/geo/province_model.dart';
import '../../models/geo/canton_model.dart';
import '../../models/geo/parish_model.dart';

class GeoBundle {
  final List<ProvinceModel> provinces;
  final List<CantonModel> cantons;
  final List<ParishModel> parishes;

  /// Índices para filtrar rápido
  final Map<int, List<CantonModel>> cantonsByProvinceId;
  final Map<int, List<ParishModel>> parishesByCantonId;

  GeoBundle({
    required this.provinces,
    required this.cantons,
    required this.parishes,
    required this.cantonsByProvinceId,
    required this.parishesByCantonId,
  });
}

abstract class GeoLocalDataSource {
  Future<GeoBundle> loadAll();
}

class GeoLocalDataSourceImpl implements GeoLocalDataSource {
  GeoBundle? _cache;

  final String provincesAssetPath;
  final String cantonsAssetPath;
  final String parishesAssetPath;

  GeoLocalDataSourceImpl({
    this.provincesAssetPath = 'assets/geo/provinces.json',
    this.cantonsAssetPath = 'assets/geo/cantons.json',
    this.parishesAssetPath = 'assets/geo/parishes.json',
  });

  @override
  Future<GeoBundle> loadAll() async {
    if (_cache != null) return _cache!;

    final provincesRaw = await rootBundle.loadString(provincesAssetPath);
    final cantonsRaw = await rootBundle.loadString(cantonsAssetPath);
    final parishesRaw = await rootBundle.loadString(parishesAssetPath);

    final provincesJson = (jsonDecode(provincesRaw) as List).cast<Map<String, dynamic>>();
    final cantonsJson = (jsonDecode(cantonsRaw) as List).cast<Map<String, dynamic>>();
    final parishesJson = (jsonDecode(parishesRaw) as List).cast<Map<String, dynamic>>();

    final provinces = provincesJson.map(ProvinceModel.fromJson).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    final cantons = cantonsJson.map(CantonModel.fromJson).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    final parishes = parishesJson.map(ParishModel.fromJson).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    final cantonsByProvince = <int, List<CantonModel>>{};
    for (final c in cantons) {
      (cantonsByProvince[c.provinceId] ??= []).add(c);
    }

    final parishesByCanton = <int, List<ParishModel>>{};
    for (final p in parishes) {
      (parishesByCanton[p.cantonId] ??= []).add(p);
    }

    _cache = GeoBundle(
      provinces: provinces,
      cantons: cantons,
      parishes: parishes,
      cantonsByProvinceId: cantonsByProvince,
      parishesByCantonId: parishesByCanton,
    );

    return _cache!;
  }
}
