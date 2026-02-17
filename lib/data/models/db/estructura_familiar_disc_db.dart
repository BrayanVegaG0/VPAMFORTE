class EstructuraFamiliarDiscDb {
  // PK (puede ser autoincremental en SQLite)
  final int? idEstFamiliarDisc;

  // Campos de la tabla
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

  const EstructuraFamiliarDiscDb({
    this.idEstFamiliarDisc,
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

  EstructuraFamiliarDiscDb copyWith({
    int? idEstFamiliarDisc,
    String? cedula,
    String? nombresApellidos,
    int? edad,
    String? identidadGenero,
    String? idTieneDiscapacidad,
    String? idTipoDiscapacidad,
    int? porcentajeDiscapacidad,
    String? enfermedadCatastrofica,
    String? idEtapaGestacional,
    String? idMenorTrabaja,
    String? idParentesco,
    String? idGeneraIngresos,
    double? generaIngresosCuanto,
  }) {
    return EstructuraFamiliarDiscDb(
      idEstFamiliarDisc: idEstFamiliarDisc ?? this.idEstFamiliarDisc,
      cedula: cedula ?? this.cedula,
      nombresApellidos: nombresApellidos ?? this.nombresApellidos,
      edad: edad ?? this.edad,
      identidadGenero: identidadGenero ?? this.identidadGenero,
      idTieneDiscapacidad: idTieneDiscapacidad ?? this.idTieneDiscapacidad,
      idTipoDiscapacidad: idTipoDiscapacidad ?? this.idTipoDiscapacidad,
      porcentajeDiscapacidad:
          porcentajeDiscapacidad ?? this.porcentajeDiscapacidad,
      enfermedadCatastrofica:
          enfermedadCatastrofica ?? this.enfermedadCatastrofica,
      idEtapaGestacional: idEtapaGestacional ?? this.idEtapaGestacional,
      idMenorTrabaja: idMenorTrabaja ?? this.idMenorTrabaja,
      idParentesco: idParentesco ?? this.idParentesco,
      idGeneraIngresos: idGeneraIngresos ?? this.idGeneraIngresos,
      generaIngresosCuanto: generaIngresosCuanto ?? this.generaIngresosCuanto,
    );
  }

  /// Para insertar/actualizar en DB
  Map<String, dynamic> toMap() => {
    'id_est_familiar_disc': idEstFamiliarDisc,
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

  /// Para leer desde DB
  factory EstructuraFamiliarDiscDb.fromMap(Map<String, dynamic> map) {
    int? asInt(dynamic v) =>
        (v is num) ? v.toInt() : int.tryParse('${v ?? ''}');
    double? asDouble(dynamic v) =>
        (v is num) ? v.toDouble() : double.tryParse('${v ?? ''}');
    String? asString(dynamic v) => (v == null) ? null : v.toString();

    return EstructuraFamiliarDiscDb(
      idEstFamiliarDisc: asInt(map['id_est_familiar_disc']),
      cedula: (map['cedula'] ?? '').toString(),
      nombresApellidos: (map['nombres_apellidos'] ?? '').toString(),
      edad: asInt(map['edad']) ?? 0,
      identidadGenero: asString(map['identidad_genero']),
      idTieneDiscapacidad: asString(map['id_tiene_discapacidad']),
      idTipoDiscapacidad: asString(map['id_tipo_discapacidad']),
      porcentajeDiscapacidad: asInt(map['porcentaje_discapacidad']),
      enfermedadCatastrofica: asString(map['enfermedad_catastrofica']),
      idEtapaGestacional: asString(map['id_etapa_gestacional']),
      idMenorTrabaja: asString(map['id_menor_trabaja']),
      idParentesco: asString(map['idParentesco']),
      idGeneraIngresos: asString(map['id_genera_ingresos']),
      generaIngresosCuanto: asDouble(map['genera_ingresos_cuanto']),
    );
  }
}
