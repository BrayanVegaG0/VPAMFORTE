class ProvinceModel {
  final int id;
  final int zone;
  final String name;

  ProvinceModel({required this.id, required this.zone, required this.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: (json['id'] as num).toInt(),
      zone: (json['zone'] as num).toInt(),
      name: (json['name'] as String).trim(),
    );
  }
}