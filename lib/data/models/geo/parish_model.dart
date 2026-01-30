class ParishModel {
  final int id;
  final String name;
  final String idDummy;
  final int cantonId;

  ParishModel({required this.id, required this.name, required this.idDummy, required this.cantonId});

  factory ParishModel.fromJson(Map<String, dynamic> json) {
    final canton = json['canton'] as Map<String, dynamic>;
    return ParishModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] as String).trim(),
      idDummy: (json['idDummy'] as String).trim(),
      cantonId: int.parse(canton['id'].toString()),
    );
  }

  /// Si quieres extraer exactamente como tu ejemplo:
  /// "50,06,10" => parroquia=50, canton=06, provincia=10
  (int parishId, int cantonId, int provinceId) parseDummyTriple() {
    final parts = idDummy.split(',').map((e) => e.trim()).toList();
    if (parts.length != 3) return (id, cantonId, -1);
    return (int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }
}
