class DinardapPersonModel {
  final String? nombresCompletos;
  final String? fechaNacimiento;  // "19/04/2002"
  final String? nacionalidad;     // "ECUATORIANA"
  final String? sexo;             // "HOMBRE" / "MUJER"
  final String? calleDomicilio;

  DinardapPersonModel({
    required this.nombresCompletos,
    required this.fechaNacimiento,
    required this.nacionalidad,
    required this.sexo,
    required this.calleDomicilio,
  });
}
