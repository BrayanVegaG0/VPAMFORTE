class FichaVPAM {
  final int idFicha;
  final double ingresoTotalMensual;
  final int miembrosHogar;
  final List<String> origenIngresoFamiliar;
  final ApoyoEconomicoEstado apoyoEconomicoEstado;
  final double gastoSalud;
  final double gastoAlimentacion;
  final double gastoVestimenta;
  final double gastoAyudasTecnicas;
  final String pisoVivienda;
  final String paredVivienda;
  final String techoVivienda;
  final int serviciosAgua;
  final ServiciosBasicos serviciosBasicos;
  final int diagnosticoNeurodegenerativo;
  final Map<String, bool> ayudasTecnicas;
  final String atencionMedicaFrecuencia;
  final List<String> lugarAtencionMedica;
  final Map<String, String> consumoSustancias;
  final List<String> serviciosAtencion;
  final String ocupacionLaboral;

  FichaVPAM({
    required this.idFicha,
    required this.ingresoTotalMensual,
    required this.miembrosHogar,
    required this.origenIngresoFamiliar,
    required this.apoyoEconomicoEstado,
    required this.gastoSalud,
    required this.gastoAlimentacion,
    required this.gastoVestimenta,
    required this.gastoAyudasTecnicas,
    required this.pisoVivienda,
    required this.paredVivienda,
    required this.techoVivienda,
    required this.serviciosAgua,
    required this.serviciosBasicos,
    required this.diagnosticoNeurodegenerativo,
    required this.ayudasTecnicas,
    required this.atencionMedicaFrecuencia,
    required this.lugarAtencionMedica,
    required this.consumoSustancias,
    required this.serviciosAtencion,
    required this.ocupacionLaboral,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_ficha': idFicha,
      'P19_ingreso_total_mensual': ingresoTotalMensual,
      'miembros_hogar': miembrosHogar,
      'P18_origen_ingreso_familiar': origenIngresoFamiliar,
      'P20_apoyo_economico_estado': apoyoEconomicoEstado.toJson(),
      'gasto_salud': gastoSalud,
      'gasto_alimentacion': gastoAlimentacion,
      'gasto_vestimenta': gastoVestimenta,
      'gasto_ayudas_tecnicas': gastoAyudasTecnicas,
      'P1_piso_vivienda': pisoVivienda,
      'P2_pared_vivienda': paredVivienda,
      'P3_techo_vivienda': techoVivienda,
      'P4_servicios_agua': serviciosAgua,
      'P5_servicios_basicos': serviciosBasicos.toJson(),
      'diagnostico_neurodegenerativo': diagnosticoNeurodegenerativo,
      'P25_ayudas_tecnicas': ayudasTecnicas,
      'P23_atencion_medica_frecuencia': atencionMedicaFrecuencia,
      'P24_lugar_atencion_medica': lugarAtencionMedica,
      'P26_consumo_sustancias': consumoSustancias,
      'P32_servicios_atencion': serviciosAtencion,
      'P34_ocupacion_laboral': ocupacionLaboral,
    };
  }
}

class ApoyoEconomicoEstado {
  final String respuestaPrincipal;
  final List<String> detalleBeneficios;

  ApoyoEconomicoEstado({
    required this.respuestaPrincipal,
    required this.detalleBeneficios,
  });

  Map<String, dynamic> toJson() {
    return {
      'respuesta_principal': respuestaPrincipal,
      'detalle_beneficios': detalleBeneficios,
    };
  }
}

class ServiciosBasicos {
  final bool luz;
  final bool agua;
  final bool alcantarillado;
  final bool telefono;
  final bool internet;

  ServiciosBasicos({
    required this.luz,
    required this.agua,
    required this.alcantarillado,
    required this.telefono,
    required this.internet,
  });

  Map<String, dynamic> toJson() {
    return {
      'luz': luz,
      'agua': agua,
      'alcantarillado': alcantarillado,
      'telefono': telefono,
      'internet': internet,
    };
  }
}
