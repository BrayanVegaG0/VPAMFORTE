class HouseholdMember {
  final String cedula;
  final String nombresApellidos;
  final int edad;

  final String? identidadGenero;
  final String? idTieneDiscapacidad;
  final String? idTipoDiscapacidad;
  final int? porcentajeDiscapacidad;
  final String? enfermedadCatastrofica;
  final String? idEtapaGestacional;
  final String? idMenorTrabaja;
  final String? idParentesco;
  final String? idGeneraIngresos;
  final double? generaIngresosCuanto;

  const HouseholdMember({
    required this.cedula,
    required this.nombresApellidos,
    required this.edad,
    this.identidadGenero,
    this.idTieneDiscapacidad,
    this.idTipoDiscapacidad,
    this.porcentajeDiscapacidad,
    this.enfermedadCatastrofica,
    this.idEtapaGestacional,
    this.idMenorTrabaja,
    this.idParentesco,
    this.idGeneraIngresos,
    this.generaIngresosCuanto,
  });

  Map<String, dynamic> toJson() => {
    'cedula': cedula,
    'nombres_apellidos': nombresApellidos,
    'edad': edad,
    'identidad_genero': identidadGenero,
    'id_tiene_discapacidad': idTieneDiscapacidad,
    'id_tipo_discapacidad': idTipoDiscapacidad,
    'porcentaje_discapacidad': porcentajeDiscapacidad,
    'enfermedad_catastrofica': enfermedadCatastrofica,
    'id_etapa_gestacional': idEtapaGestacional,
    'id_menor_trabaja': idMenorTrabaja,
    'idParentesco': idParentesco,
    'id_genera_ingresos': idGeneraIngresos,
    'genera_ingresos_cuanto': generaIngresosCuanto,
  };

  factory HouseholdMember.fromJson(Map<String, dynamic> j) => HouseholdMember(
    cedula: (j['cedula'] ?? '').toString(),
    nombresApellidos: (j['nombres_apellidos'] ?? '').toString(),
    edad: (j['edad'] as num?)?.toInt() ?? int.tryParse('${j['edad']}') ?? 0,
    identidadGenero: j['identidad_genero']?.toString(),
    idTieneDiscapacidad: j['id_tiene_discapacidad']?.toString(),
    idTipoDiscapacidad: j['id_tipo_discapacidad']?.toString(),
    porcentajeDiscapacidad: (j['porcentaje_discapacidad'] as num?)?.toInt() ??
        int.tryParse('${j['porcentaje_discapacidad']}'),
    enfermedadCatastrofica: j['enfermedad_catastrofica']?.toString(),
    idEtapaGestacional: j['id_etapa_gestacional']?.toString(),
    idMenorTrabaja: j['id_menor_trabaja']?.toString(),
    idParentesco: j['idParentesco']?.toString(),
    idGeneraIngresos: j['id_genera_ingresos']?.toString(),
    generaIngresosCuanto: (j['genera_ingresos_cuanto'] as num?)?.toDouble() ??
        double.tryParse('${j['genera_ingresos_cuanto']}'),
  );
}
