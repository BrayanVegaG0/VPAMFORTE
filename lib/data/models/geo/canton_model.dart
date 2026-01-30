class CantonModel {
  final int id;
  final String name;
  final int provinceId;

  CantonModel({required this.id, required this.name, required this.provinceId});

  factory CantonModel.fromJson(Map<String, dynamic> json) {
    final prov = json['province'] as Map<String, dynamic>;
    return CantonModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] as String).trim(),
      provinceId: int.parse(prov['id'].toString()),
    );
  }
}
