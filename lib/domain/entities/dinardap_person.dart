class DinardapPerson {
  final String? nombresCompletos;
  final String? fechaNacimientoDdMmYyyy;
  final String? nacionalidad;
  final String? sexo;
  final String? estadoCivil;
  final String? domicilio; // ✅ Nuevo campo

  DinardapPerson({
    required this.nombresCompletos,
    required this.fechaNacimientoDdMmYyyy,
    required this.nacionalidad,
    required this.sexo,
    required this.estadoCivil,
    this.domicilio,
  });
}
