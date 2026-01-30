import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _GeoProvince {
  final int id;
  final String name;
  _GeoProvince({required this.id, required this.name});

  factory _GeoProvince.fromJson(Map<String, dynamic> j) => _GeoProvince(
    id: (j['id'] as num).toInt(),
    name: (j['name'] as String).trim(),
  );
}

class _GeoCanton {
  final int id;
  final String name;
  final int provinceInternalId;
  _GeoCanton({required this.id, required this.name, required this.provinceInternalId});

  factory _GeoCanton.fromJson(Map<String, dynamic> j) {
    final prov = j['province'] as Map<String, dynamic>;
    return _GeoCanton(
      id: (j['id'] as num).toInt(),
      name: (j['name'] as String).trim(),
      provinceInternalId: int.parse(prov['id'].toString()),
    );
  }
}

class _GeoParish {
  final int id;
  final String name;
  final String idDummy; // "50,06,10"
  final int cantonInternalId;

  _GeoParish({
    required this.id,
    required this.name,
    required this.idDummy,
    required this.cantonInternalId,
  });

  factory _GeoParish.fromJson(Map<String, dynamic> j) {
    final canton = j['canton'] as Map<String, dynamic>;
    return _GeoParish(
      id: (j['id'] as num).toInt(),
      name: (j['name'] as String).trim(),
      idDummy: (j['idDummy'] as String).trim(),
      cantonInternalId: int.parse(canton['id'].toString()),
    );
  }

  (int parishCode, int cantonCode, int provinceCode) parseDummyCodes() {
    final parts = idDummy.split(',').map((e) => e.trim()).toList();
    if (parts.length != 3) return (-1, -1, -1);
    return (int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }
}

class GeoOption {
  final String code; // lo que se guarda en answers
  final String label;
  const GeoOption({required this.code, required this.label});
}

/// Cache en memoria: carga assets 1 sola vez (con Future para evitar carreras)
class EcuadorGeoStore {
  EcuadorGeoStore._();
  static final EcuadorGeoStore I = EcuadorGeoStore._();

  bool _loaded = false;
  Future<void>? _loadingFuture;

  late final List<_GeoProvince> _provinces;
  late final Map<int, String> _cantonNameByInternalId;

  late final Map<int, List<GeoOption>> _cantonsByProvinceCode; // provCode -> cantons
  late final Map<String, List<GeoOption>> _parishesByProvCantonCode; // "prov|canton" -> parishes

  Future<void> ensureLoaded({
    String provincesAsset = 'assets/geo/provinces.json',
    String cantonsAsset = 'assets/geo/cantons.json',
    String parishesAsset = 'assets/geo/parishes.json',
  }) {
    if (_loaded) return Future.value();
    _loadingFuture ??= _doLoad(provincesAsset, cantonsAsset, parishesAsset);
    return _loadingFuture!;
  }

  Future<void> _doLoad(String provincesAsset, String cantonsAsset, String parishesAsset) async {
    try {
      final provincesRaw = await rootBundle.loadString(provincesAsset);
      final cantonsRaw = await rootBundle.loadString(cantonsAsset);
      final parishesRaw = await rootBundle.loadString(parishesAsset);

      final provList = (jsonDecode(provincesRaw) as List).cast<dynamic>()
          .map((e) => (e as Map).cast<String, dynamic>())
          .toList();

      final cantonList = (jsonDecode(cantonsRaw) as List).cast<dynamic>()
          .map((e) => (e as Map).cast<String, dynamic>())
          .toList();

      final parishList = (jsonDecode(parishesRaw) as List).cast<dynamic>()
          .map((e) => (e as Map).cast<String, dynamic>())
          .toList();

      _provinces = provList.map(_GeoProvince.fromJson).toList()
        ..sort((a, b) => a.name.compareTo(b.name));

      final cantons = cantonList.map(_GeoCanton.fromJson).toList();
      _cantonNameByInternalId = {for (final c in cantons) c.id: c.name};

      final parishes = parishList.map(_GeoParish.fromJson).toList();

      final parishesByKey = <String, List<GeoOption>>{};
      final cantonsByProv = <int, Map<int, GeoOption>>{};

      for (final p in parishes) {
        final (parishCode, cantonCode, provinceCode) = p.parseDummyCodes();
        if (provinceCode <= 0 || cantonCode < 0 || parishCode < 0) continue;

        final key = _key(provinceCode, cantonCode);

        (parishesByKey[key] ??= []).add(
          GeoOption(code: parishCode.toString(), label: p.name),
        );

        final cantonName = _cantonNameByInternalId[p.cantonInternalId] ?? 'Cantón ${p.cantonInternalId}';
        final option = GeoOption(code: cantonCode.toString(), label: cantonName);

        final byCantonCode = (cantonsByProv[provinceCode] ??= <int, GeoOption>{});
        byCantonCode[cantonCode] = option;
      }

      _parishesByProvCantonCode = {
        for (final e in parishesByKey.entries)
          e.key: (e.value..sort((a, b) => a.label.compareTo(b.label))),
      };

      _cantonsByProvinceCode = {
        for (final e in cantonsByProv.entries)
          e.key: (e.value.values.toList()..sort((a, b) => a.label.compareTo(b.label))),
      };

      _loaded = true;
    } finally {
      // Si falló, permitimos reintentar (no se queda pegado para siempre)
      if (!_loaded) _loadingFuture = null;
    }
  }

  List<GeoOption> getProvinces() {
    return _provinces
        .map((p) => GeoOption(code: p.id.toString(), label: p.name))
        .toList(growable: false);
  }

  List<GeoOption> getCantonsByProvinceCode(int provinceCode) {
    return _cantonsByProvinceCode[provinceCode] ?? const [];
  }

  List<GeoOption> getParishesByCodes({required int provinceCode, required int cantonCode}) {
    return _parishesByProvCantonCode[_key(provinceCode, cantonCode)] ?? const [];
  }

  static String _key(int prov, int canton) => '$prov|$canton';
}

class EcuadorLocationDropdown extends StatefulWidget {
  final String questionId;
  final bool markError;

  final String provinceQuestionId;
  final String cantonQuestionId;
  final String parishQuestionId;

  final Map<String, dynamic> answers;
  final void Function(String questionId, dynamic value) onAnswerChanged;

  const EcuadorLocationDropdown({
    super.key,
    required this.questionId,
    required this.markError,
    required this.answers,
    required this.onAnswerChanged,
    required this.provinceQuestionId,
    required this.cantonQuestionId,
    required this.parishQuestionId,
  });

  @override
  State<EcuadorLocationDropdown> createState() => _EcuadorLocationDropdownState();
}

class _EcuadorLocationDropdownState extends State<EcuadorLocationDropdown> {
  bool _loading = true;
  String? _error; // ✅ para no “quedarse infinito”

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await EcuadorGeoStore.I.ensureLoaded();
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Error cargando geodatos: $e';
      });
    }
  }

  String? _asStr(dynamic v) {
    if (v == null) return null;
    if (v is String) {
      final t = v.trim();
      return t.isEmpty ? null : t;
    }
    return v.toString();
  }

  int? _asInt(dynamic v) {
    final s = _asStr(v);
    if (s == null) return null;
    return int.tryParse(s);
  }

  InputDecoration _decoration({required String hint}) => InputDecoration(
    border: const OutlineInputBorder(),
    hintText: hint,
    errorText: widget.markError ? 'Campo obligatorio' : null,
  );

  String? _safeValue(String? current, List<GeoOption> items) {
    if (current == null) return null;
    final ok = items.any((o) => o.code == current);
    return ok ? current : null; // ✅ evita crash si el value no existe en items
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: LinearProgressIndicator(),
      );
    }

    if (_error != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 12)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _loading = true;
                _error = null;
              });
              _init();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      );
    }

    final provCode = _asInt(widget.answers[widget.provinceQuestionId]);
    final cantonCode = _asInt(widget.answers[widget.cantonQuestionId]);
    final parishCode = _asStr(widget.answers[widget.parishQuestionId]);

    final isProvince = widget.questionId == widget.provinceQuestionId;
    final isCanton = widget.questionId == widget.cantonQuestionId;
    final isParish = widget.questionId == widget.parishQuestionId;

    if (isProvince) {
      final items = EcuadorGeoStore.I.getProvinces();
      final current = _safeValue(_asStr(widget.answers[widget.provinceQuestionId]), items);

      return DropdownButtonFormField<String>(
        value: current,
        isExpanded: true,
        items: items
            .map((o) => DropdownMenuItem<String>(
          value: o.code,
          child: Text(o.label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ))
            .toList(),
        onChanged: (v) {
          widget.onAnswerChanged(widget.provinceQuestionId, v);
          widget.onAnswerChanged(widget.cantonQuestionId, null);
          widget.onAnswerChanged(widget.parishQuestionId, null);
        },
        decoration: _decoration(hint: 'Seleccione provincia'),
      );
    }

    if (isCanton) {
      final enabled = provCode != null;
      final items = enabled ? EcuadorGeoStore.I.getCantonsByProvinceCode(provCode!) : const <GeoOption>[];
      final current = _safeValue(_asStr(widget.answers[widget.cantonQuestionId]), items);

      return DropdownButtonFormField<String>(
        value: current,
        isExpanded: true,
        items: items
            .map((o) => DropdownMenuItem<String>(
          value: o.code,
          child: Text(o.label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ))
            .toList(),
        onChanged: !enabled
            ? null
            : (v) {
          widget.onAnswerChanged(widget.cantonQuestionId, v);
          widget.onAnswerChanged(widget.parishQuestionId, null);
        },
        decoration: _decoration(hint: enabled ? 'Seleccione cantón' : 'Seleccione provincia primero'),
      );
    }

    if (isParish) {
      final enabled = provCode != null && cantonCode != null;
      final items = enabled
          ? EcuadorGeoStore.I.getParishesByCodes(provinceCode: provCode!, cantonCode: cantonCode!)
          : const <GeoOption>[];

      final current = _safeValue(parishCode, items);

      return DropdownButtonFormField<String>(
        value: current,
        isExpanded: true,
        items: items
            .map((o) => DropdownMenuItem<String>(
          value: o.code,
          child: Text(o.label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ))
            .toList(),
        onChanged: !enabled
            ? null
            : (v) {
          widget.onAnswerChanged(widget.parishQuestionId, v);
        },
        decoration: _decoration(hint: enabled ? 'Seleccione parroquia' : 'Seleccione cantón primero'),
      );
    }

    return const SizedBox.shrink();
  }
}
