import 'package:uuid/uuid.dart';

class BaremoDb {
  final String idBaremo;

  final String? idConfinadoCama;
  final String? idConfinadoSillaRuedas;
  final String? idUsuarioSillaRuedas;
  final String? idAndaNoPonersePie;
  final String? idAndaNecesitaGuia;
  final String? idAcostarse;
  final String? idLevantarse;
  final String? idCambiosPostulares;
  final String? idRopaCama;
  final String? idPrendasSuperiorCuerpo;
  final String? idPrendasInferiorCuerpo;
  final String? idPrendasCalzado;
  final String? idAbrotarBotonesCremalleras;
  final String? idDucharse;
  final String? idUsoRetrete;
  final String? idLavarseManosPeinarse;
  final String? idLavarsePiesHigMenstrual;
  final String? idOtrasActHigienePersonal;
  final String? idSujetarCubiertos;
  final String? idSujetarJarras;
  final String? idServirseCortarCarne;
  final String? idAyudaUrg;
  final String? idLlamadasPuerta;
  final String? idUsarTelefono;
  final String? idSeguridadAcceso;
  final String? idUsoDispositivosDomesticos;
  final String? idUsoRadiosLibros;
  final String? idAparatosEspeciales;
  final String? idPrecaucionesEspeciales;
  final String? idDependenciaPersona;
  final String? idIncapacidadTotal;
  final String? idConductasAgresivas;
  final String? idConductasInadaptadas;
  final String? idProteccionAbsoluta;
  final String? idDisponibilidadContinua;
  final String? idNormasHabitualesConvivencia;
  final String? idConocimientoNormas;
  final String? idNormasEspeciales;
  final String? idRutinaCotidiana;
  final String? idProblemasHabituales;

  BaremoDb({
    String? idBaremo,
    this.idConfinadoCama,
    this.idConfinadoSillaRuedas,
    this.idUsuarioSillaRuedas,
    this.idAndaNoPonersePie,
    this.idAndaNecesitaGuia,
    this.idAcostarse,
    this.idLevantarse,
    this.idCambiosPostulares,
    this.idRopaCama,
    this.idPrendasSuperiorCuerpo,
    this.idPrendasInferiorCuerpo,
    this.idPrendasCalzado,
    this.idAbrotarBotonesCremalleras,
    this.idDucharse,
    this.idUsoRetrete,
    this.idLavarseManosPeinarse,
    this.idLavarsePiesHigMenstrual,
    this.idOtrasActHigienePersonal,
    this.idSujetarCubiertos,
    this.idSujetarJarras,
    this.idServirseCortarCarne,
    this.idAyudaUrg,
    this.idLlamadasPuerta,
    this.idUsarTelefono,
    this.idSeguridadAcceso,
    this.idUsoDispositivosDomesticos,
    this.idUsoRadiosLibros,
    this.idAparatosEspeciales,
    this.idPrecaucionesEspeciales,
    this.idDependenciaPersona,
    this.idIncapacidadTotal,
    this.idConductasAgresivas,
    this.idConductasInadaptadas,
    this.idProteccionAbsoluta,
    this.idDisponibilidadContinua,
    this.idNormasHabitualesConvivencia,
    this.idConocimientoNormas,
    this.idNormasEspeciales,
    this.idRutinaCotidiana,
    this.idProblemasHabituales,
  }) : idBaremo = idBaremo ?? const Uuid().v4();

  BaremoDb copyWith({
    String? idConfinadoCama,
    String? idConfinadoSillaRuedas,
    String? idUsuarioSillaRuedas,
    String? idAndaNoPonersePie,
    String? idAndaNecesitaGuia,
    String? idAcostarse,
    String? idLevantarse,
    String? idCambiosPostulares,
    String? idRopaCama,
    String? idPrendasSuperiorCuerpo,
    String? idPrendasInferiorCuerpo,
    String? idPrendasCalzado,
    String? idAbrotarBotonesCremalleras,
    String? idDucharse,
    String? idUsoRetrete,
    String? idLavarseManosPeinarse,
    String? idLavarsePiesHigMenstrual,
    String? idOtrasActHigienePersonal,
    String? idSujetarCubiertos,
    String? idSujetarJarras,
    String? idServirseCortarCarne,
    String? idAyudaUrg,
    String? idLlamadasPuerta,
    String? idUsarTelefono,
    String? idSeguridadAcceso,
    String? idUsoDispositivosDomesticos,
    String? idUsoRadiosLibros,
    String? idAparatosEspeciales,
    String? idPrecaucionesEspeciales,
    String? idDependenciaPersona,
    String? idIncapacidadTotal,
    String? idConductasAgresivas,
    String? idConductasInadaptadas,
    String? idProteccionAbsoluta,
    String? idDisponibilidadContinua,
    String? idNormasHabitualesConvivencia,
    String? idConocimientoNormas,
    String? idNormasEspeciales,
    String? idRutinaCotidiana,
    String? idProblemasHabituales,
  }) {
    return BaremoDb(
      idBaremo: idBaremo,
      idConfinadoCama: idConfinadoCama ?? this.idConfinadoCama,
      idConfinadoSillaRuedas:
      idConfinadoSillaRuedas ?? this.idConfinadoSillaRuedas,
      idUsuarioSillaRuedas:
      idUsuarioSillaRuedas ?? this.idUsuarioSillaRuedas,
      idAndaNoPonersePie: idAndaNoPonersePie ?? this.idAndaNoPonersePie,
      idAndaNecesitaGuia: idAndaNecesitaGuia ?? this.idAndaNecesitaGuia,
      idAcostarse: idAcostarse ?? this.idAcostarse,
      idLevantarse: idLevantarse ?? this.idLevantarse,
      idCambiosPostulares: idCambiosPostulares ?? this.idCambiosPostulares,
      idRopaCama: idRopaCama ?? this.idRopaCama,
      idPrendasSuperiorCuerpo:
      idPrendasSuperiorCuerpo ?? this.idPrendasSuperiorCuerpo,
      idPrendasInferiorCuerpo:
      idPrendasInferiorCuerpo ?? this.idPrendasInferiorCuerpo,
      idPrendasCalzado: idPrendasCalzado ?? this.idPrendasCalzado,
      idAbrotarBotonesCremalleras:
      idAbrotarBotonesCremalleras ?? this.idAbrotarBotonesCremalleras,
      idDucharse: idDucharse ?? this.idDucharse,
      idUsoRetrete: idUsoRetrete ?? this.idUsoRetrete,
      idLavarseManosPeinarse:
      idLavarseManosPeinarse ?? this.idLavarseManosPeinarse,
      idLavarsePiesHigMenstrual:
      idLavarsePiesHigMenstrual ?? this.idLavarsePiesHigMenstrual,
      idOtrasActHigienePersonal:
      idOtrasActHigienePersonal ?? this.idOtrasActHigienePersonal,
      idSujetarCubiertos: idSujetarCubiertos ?? this.idSujetarCubiertos,
      idSujetarJarras: idSujetarJarras ?? this.idSujetarJarras,
      idServirseCortarCarne:
      idServirseCortarCarne ?? this.idServirseCortarCarne,
      idAyudaUrg: idAyudaUrg ?? this.idAyudaUrg,
      idLlamadasPuerta: idLlamadasPuerta ?? this.idLlamadasPuerta,
      idUsarTelefono: idUsarTelefono ?? this.idUsarTelefono,
      idSeguridadAcceso: idSeguridadAcceso ?? this.idSeguridadAcceso,
      idUsoDispositivosDomesticos:
      idUsoDispositivosDomesticos ?? this.idUsoDispositivosDomesticos,
      idUsoRadiosLibros: idUsoRadiosLibros ?? this.idUsoRadiosLibros,
      idAparatosEspeciales: idAparatosEspeciales ?? this.idAparatosEspeciales,
      idPrecaucionesEspeciales:
      idPrecaucionesEspeciales ?? this.idPrecaucionesEspeciales,
      idDependenciaPersona: idDependenciaPersona ?? this.idDependenciaPersona,
      idIncapacidadTotal: idIncapacidadTotal ?? this.idIncapacidadTotal,
      idConductasAgresivas: idConductasAgresivas ?? this.idConductasAgresivas,
      idConductasInadaptadas:
      idConductasInadaptadas ?? this.idConductasInadaptadas,
      idProteccionAbsoluta: idProteccionAbsoluta ?? this.idProteccionAbsoluta,
      idDisponibilidadContinua:
      idDisponibilidadContinua ?? this.idDisponibilidadContinua,
      idNormasHabitualesConvivencia:
      idNormasHabitualesConvivencia ?? this.idNormasHabitualesConvivencia,
      idConocimientoNormas: idConocimientoNormas ?? this.idConocimientoNormas,
      idNormasEspeciales: idNormasEspeciales ?? this.idNormasEspeciales,
      idRutinaCotidiana: idRutinaCotidiana ?? this.idRutinaCotidiana,
      idProblemasHabituales: idProblemasHabituales ?? this.idProblemasHabituales,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_baremo': idBaremo,
    'id_confinado_cama': idConfinadoCama,
    'id_confinado_silla_ruedas': idConfinadoSillaRuedas,
    'id_usuario_silla_ruedas': idUsuarioSillaRuedas,
    'id_anda_no_ponerse_pie': idAndaNoPonersePie,
    'id_anda_necesita_guia': idAndaNecesitaGuia,
    'id_acostarse': idAcostarse,
    'id_levantarse': idLevantarse,
    'id_cambios_postulares': idCambiosPostulares,
    'id_ropa_cama': idRopaCama,
    'id_prendas_superior_cuerpo': idPrendasSuperiorCuerpo,
    'id_prendas_inferior_cuerpo': idPrendasInferiorCuerpo,
    'id_prendas_calzado': idPrendasCalzado,
    'id_abrotar_botones_cremalleras': idAbrotarBotonesCremalleras,
    'id_ducharse': idDucharse,
    'id_uso_retrete': idUsoRetrete,
    'id_lavarse_manos_peinarse': idLavarseManosPeinarse,
    'id_lavarse_pies_hig_menstrual': idLavarsePiesHigMenstrual,
    'id_otras_act_higiene_personal': idOtrasActHigienePersonal,
    'id_sujetar_cubiertos': idSujetarCubiertos,
    'id_sujetar_jarras': idSujetarJarras,
    'id_servirse_cortar_carne': idServirseCortarCarne,
    'id_ayuda_urg': idAyudaUrg,
    'id_llamadas_puerta': idLlamadasPuerta,
    'id_usar_telefono': idUsarTelefono,
    'id_seguridad_acceso': idSeguridadAcceso,
    'id_uso_dispositivos_domesticos': idUsoDispositivosDomesticos,
    'id_uso_radios_libros': idUsoRadiosLibros,
    'id_aparatos_especiales': idAparatosEspeciales,
    'id_precauciones_especiales': idPrecaucionesEspeciales,
    'id_dependencia_persona': idDependenciaPersona,
    'id_incapacidad_total': idIncapacidadTotal,
    'id_conductas_agresivas': idConductasAgresivas,
    'id_conductas_inadaptadas': idConductasInadaptadas,
    'id_proteccion_absoluta': idProteccionAbsoluta,
    'id_disponibilidad_continua': idDisponibilidadContinua,
    'id_normas_habituales_convivencia': idNormasHabitualesConvivencia,
    'id_conocimiento_normas': idConocimientoNormas,
    'id_normas_especiales': idNormasEspeciales,
    'id_rutina_cotidiana': idRutinaCotidiana,
    'id_problemas_habituales': idProblemasHabituales,
  };

  static BaremoDb fromJson(Map<String, dynamic> json) {
    return BaremoDb(
      idBaremo: (json['id_baremo'] as String?) ?? const Uuid().v4(),
      idConfinadoCama: json['id_confinado_cama'] as String?,
      idConfinadoSillaRuedas: json['id_confinado_silla_ruedas'] as String?,
      idUsuarioSillaRuedas: json['id_usuario_silla_ruedas'] as String?,
      idAndaNoPonersePie: json['id_anda_no_ponerse_pie'] as String?,
      idAndaNecesitaGuia: json['id_anda_necesita_guia'] as String?,
      idAcostarse: json['id_acostarse'] as String?,
      idLevantarse: json['id_levantarse'] as String?,
      idCambiosPostulares: json['id_cambios_postulares'] as String?,
      idRopaCama: json['id_ropa_cama'] as String?,
      idPrendasSuperiorCuerpo: json['id_prendas_superior_cuerpo'] as String?,
      idPrendasInferiorCuerpo: json['id_prendas_inferior_cuerpo'] as String?,
      idPrendasCalzado: json['id_prendas_calzado'] as String?,
      idAbrotarBotonesCremalleras:
      json['id_abrotar_botones_cremalleras'] as String?,
      idDucharse: json['id_ducharse'] as String?,
      idUsoRetrete: json['id_uso_retrete'] as String?,
      idLavarseManosPeinarse: json['id_lavarse_manos_peinarse'] as String?,
      idLavarsePiesHigMenstrual:
      json['id_lavarse_pies_hig_menstrual'] as String?,
      idOtrasActHigienePersonal:
      json['id_otras_act_higiene_personal'] as String?,
      idSujetarCubiertos: json['id_sujetar_cubiertos'] as String?,
      idSujetarJarras: json['id_sujetar_jarras'] as String?,
      idServirseCortarCarne: json['id_servirse_cortar_carne'] as String?,
      idAyudaUrg: json['id_ayuda_urg'] as String?,
      idLlamadasPuerta: json['id_llamadas_puerta'] as String?,
      idUsarTelefono: json['id_usar_telefono'] as String?,
      idSeguridadAcceso: json['id_seguridad_acceso'] as String?,
      idUsoDispositivosDomesticos:
      json['id_uso_dispositivos_domesticos'] as String?,
      idUsoRadiosLibros: json['id_uso_radios_libros'] as String?,
      idAparatosEspeciales: json['id_aparatos_especiales'] as String?,
      idPrecaucionesEspeciales:
      json['id_precauciones_especiales'] as String?,
      idDependenciaPersona: json['id_dependencia_persona'] as String?,
      idIncapacidadTotal: json['id_incapacidad_total'] as String?,
      idConductasAgresivas: json['id_conductas_agresivas'] as String?,
      idConductasInadaptadas: json['id_conductas_inadaptadas'] as String?,
      idProteccionAbsoluta: json['id_proteccion_absoluta'] as String?,
      idDisponibilidadContinua: json['id_disponibilidad_continua'] as String?,
      idNormasHabitualesConvivencia:
      json['id_normas_habituales_convivencia'] as String?,
      idConocimientoNormas: json['id_conocimiento_normas'] as String?,
      idNormasEspeciales: json['id_normas_especiales'] as String?,
      idRutinaCotidiana: json['id_rutina_cotidiana'] as String?,
      idProblemasHabituales: json['id_problemas_habituales'] as String?,
    );
  }
}
