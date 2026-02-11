import 'package:uuid/uuid.dart';

class CargaCuidadorDiscDb {
  final String idCargaCuidadorDiscDisc;

  final String? idAyudaFamilia;
  final String? idSuficienteTiempo;
  final String? idAgobiadoCompatibilizar;
  final String? idVerguenzaConductaFam;
  final String? idEnfadadoCercaFam;
  final String? idCuidarFamAfectaNeg;
  final String? idMiedoFuturoFam;
  final String? idFamDependeUsted;
  final String? idTensoCercaFam;
  final String? idSaludEmpeorado;
  final String? idMpTieneIntimidad;
  final String? idVidaSocialAfectada;
  final String? idIncomodoDistanciarse;
  final String? idFamiliarUnicaPersCuidar;
  final String? idNoTieneSuficientesIngre;
  final String? idNoCapazCuidarFam;
  final String? idPerdidoControl;
  final String? idDejarCuidadoFamiliar;
  final String? idIndeciso;
  final String? idDeberiaHacerMasFam;
  final String? idGradoCargaExperimenta;

  final String? idVulPerDiscapacidad;
  final String? idPersonaCuidadora;
  final String? idCuidadoOtrasPersonas;
  final String? idCuidadoraDisc;
  final String? idMiembroHogarSustituto;
  final String? idSustitutoTrabaja;
  final String? idDiscCuidaPersonasHogar;

  CargaCuidadorDiscDb({
    String? idCargaCuidadorDiscDisc,
    this.idAyudaFamilia,
    this.idSuficienteTiempo,
    this.idAgobiadoCompatibilizar,
    this.idVerguenzaConductaFam,
    this.idEnfadadoCercaFam,
    this.idCuidarFamAfectaNeg,
    this.idMiedoFuturoFam,
    this.idFamDependeUsted,
    this.idTensoCercaFam,
    this.idSaludEmpeorado,
    this.idMpTieneIntimidad,
    this.idVidaSocialAfectada,
    this.idIncomodoDistanciarse,
    this.idFamiliarUnicaPersCuidar,
    this.idNoTieneSuficientesIngre,
    this.idNoCapazCuidarFam,
    this.idPerdidoControl,
    this.idDejarCuidadoFamiliar,
    this.idIndeciso,
    this.idDeberiaHacerMasFam,
    this.idGradoCargaExperimenta,
    this.idVulPerDiscapacidad,
    this.idPersonaCuidadora,
    this.idCuidadoOtrasPersonas,
    this.idCuidadoraDisc,
    this.idMiembroHogarSustituto,
    this.idSustitutoTrabaja,
    this.idDiscCuidaPersonasHogar,
  }) : idCargaCuidadorDiscDisc =
      idCargaCuidadorDiscDisc ?? const Uuid().v4();

  CargaCuidadorDiscDb copyWith({
    String? idAyudaFamilia,
    String? idSuficienteTiempo,
    String? idAgobiadoCompatibilizar,
    String? idVerguenzaConductaFam,
    String? idEnfadadoCercaFam,
    String? idCuidarFamAfectaNeg,
    String? idMiedoFuturoFam,
    String? idFamDependeUsted,
    String? idTensoCercaFam,
    String? idSaludEmpeorado,
    String? idMpTieneIntimidad,
    String? idVidaSocialAfectada,
    String? idIncomodoDistanciarse,
    String? idFamiliarUnicaPersCuidar,
    String? idNoTieneSuficientesIngre,
    String? idNoCapazCuidarFam,
    String? idPerdidoControl,
    String? idDejarCuidadoFamiliar,
    String? idIndeciso,
    String? idDeberiaHacerMasFam,
    String? idGradoCargaExperimenta,
    String? idVulPerDiscapacidad,
    String? idPersonaCuidadora,
    String? idCuidadoOtrasPersonas,
    String? idCuidadoraDisc,
    String? idMiembroHogarSustituto,
    String? idSustitutoTrabaja,
    String? idDiscCuidaPersonasHogar,
  }) {
    return CargaCuidadorDiscDb(
      idCargaCuidadorDiscDisc: idCargaCuidadorDiscDisc,
      idAyudaFamilia: idAyudaFamilia ?? this.idAyudaFamilia,
      idSuficienteTiempo: idSuficienteTiempo ?? this.idSuficienteTiempo,
      idAgobiadoCompatibilizar:
      idAgobiadoCompatibilizar ?? this.idAgobiadoCompatibilizar,
      idVerguenzaConductaFam:
      idVerguenzaConductaFam ?? this.idVerguenzaConductaFam,
      idEnfadadoCercaFam: idEnfadadoCercaFam ?? this.idEnfadadoCercaFam,
      idCuidarFamAfectaNeg:
      idCuidarFamAfectaNeg ?? this.idCuidarFamAfectaNeg,
      idMiedoFuturoFam: idMiedoFuturoFam ?? this.idMiedoFuturoFam,
      idFamDependeUsted: idFamDependeUsted ?? this.idFamDependeUsted,
      idTensoCercaFam: idTensoCercaFam ?? this.idTensoCercaFam,
      idSaludEmpeorado: idSaludEmpeorado ?? this.idSaludEmpeorado,
      idMpTieneIntimidad: idMpTieneIntimidad ?? this.idMpTieneIntimidad,
      idVidaSocialAfectada:
      idVidaSocialAfectada ?? this.idVidaSocialAfectada,
      idIncomodoDistanciarse:
      idIncomodoDistanciarse ?? this.idIncomodoDistanciarse,
      idFamiliarUnicaPersCuidar:
      idFamiliarUnicaPersCuidar ?? this.idFamiliarUnicaPersCuidar,
      idNoTieneSuficientesIngre:
      idNoTieneSuficientesIngre ?? this.idNoTieneSuficientesIngre,
      idNoCapazCuidarFam: idNoCapazCuidarFam ?? this.idNoCapazCuidarFam,
      idPerdidoControl: idPerdidoControl ?? this.idPerdidoControl,
      idDejarCuidadoFamiliar:
      idDejarCuidadoFamiliar ?? this.idDejarCuidadoFamiliar,
      idIndeciso: idIndeciso ?? this.idIndeciso,
      idDeberiaHacerMasFam:
      idDeberiaHacerMasFam ?? this.idDeberiaHacerMasFam,
      idGradoCargaExperimenta:
      idGradoCargaExperimenta ?? this.idGradoCargaExperimenta,
      idVulPerDiscapacidad:
      idVulPerDiscapacidad ?? this.idVulPerDiscapacidad,
      idPersonaCuidadora: idPersonaCuidadora ?? this.idPersonaCuidadora,
      idCuidadoOtrasPersonas:
      idCuidadoOtrasPersonas ?? this.idCuidadoOtrasPersonas,
      idCuidadoraDisc: idCuidadoraDisc ?? this.idCuidadoraDisc,
      idMiembroHogarSustituto:
      idMiembroHogarSustituto ?? this.idMiembroHogarSustituto,
      idSustitutoTrabaja: idSustitutoTrabaja ?? this.idSustitutoTrabaja,
      idDiscCuidaPersonasHogar:
      idDiscCuidaPersonasHogar ?? this.idDiscCuidaPersonasHogar,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_carga_cuidador_disc_disc': idCargaCuidadorDiscDisc,
    'id_ayuda_familia': idAyudaFamilia,
    'id_suficiente_tiempo': idSuficienteTiempo,
    'id_agobiado_compatibilizar': idAgobiadoCompatibilizar,
    'id_verguenza_conducta_fam': idVerguenzaConductaFam,
    'id_enfadado_cerca_fam': idEnfadadoCercaFam,
    'id_cuidar_fam_afecta_neg': idCuidarFamAfectaNeg,
    'id_miedo_futuro_fam': idMiedoFuturoFam,
    'id_fam_depende_usted': idFamDependeUsted,
    'id_tenso_cerca_fam': idTensoCercaFam,
    'id_salud_empeorado': idSaludEmpeorado,
    'id_mp_tiene_intimidad': idMpTieneIntimidad,
    'id_vida_social_afectada': idVidaSocialAfectada,
    'id_incomodo_distanciarse': idIncomodoDistanciarse,
    'id_familiar_unica_pers_cuidar': idFamiliarUnicaPersCuidar,
    'id_no_tiene_suficientes_ingre': idNoTieneSuficientesIngre,
    'id_no_capaz_cuidar_fam': idNoCapazCuidarFam,
    'id_perdido_control': idPerdidoControl,
    'id_dejar_cuidado_familiar': idDejarCuidadoFamiliar,
    'id_indeciso': idIndeciso,
    'id_deberia_hacer_mas_fam': idDeberiaHacerMasFam,
    'id_grado_carga_experimenta': idGradoCargaExperimenta,
    'id_vul_per_discapacidad': idVulPerDiscapacidad,
    'id_persona_cuidadora': idPersonaCuidadora,
    'id_cuidado_otras_personas': idCuidadoOtrasPersonas,
    'id_cuidadora_disc': idCuidadoraDisc,
    'id_miembro_hogar_sustituto': idMiembroHogarSustituto,
    'id_sustituto_trabaja': idSustitutoTrabaja,
    'id_disc_cuida_personas_hogar': idDiscCuidaPersonasHogar,
  };

  static CargaCuidadorDiscDb fromJson(Map<String, dynamic> json) {
    return CargaCuidadorDiscDb(
      idCargaCuidadorDiscDisc:
      (json['id_carga_cuidador_disc_disc'] as String?) ?? const Uuid().v4(),
      idAyudaFamilia: json['id_ayuda_familia'] as String?,
      idSuficienteTiempo: json['id_suficiente_tiempo'] as String?,
      idAgobiadoCompatibilizar:
      json['id_agobiado_compatibilizar'] as String?,
      idVerguenzaConductaFam: json['id_verguenza_conducta_fam'] as String?,
      idEnfadadoCercaFam: json['id_enfadado_cerca_fam'] as String?,
      idCuidarFamAfectaNeg: json['id_cuidar_fam_afecta_neg'] as String?,
      idMiedoFuturoFam: json['id_miedo_futuro_fam'] as String?,
      idFamDependeUsted: json['id_fam_depende_usted'] as String?,
      idTensoCercaFam: json['id_tenso_cerca_fam'] as String?,
      idSaludEmpeorado: json['id_salud_empeorado'] as String?,
      idMpTieneIntimidad: json['id_mp_tiene_intimidad'] as String?,
      idVidaSocialAfectada: json['id_vida_social_afectada'] as String?,
      idIncomodoDistanciarse: json['id_incomodo_distanciarse'] as String?,
      idFamiliarUnicaPersCuidar:
      json['id_familiar_unica_pers_cuidar'] as String?,
      idNoTieneSuficientesIngre:
      json['id_no_tiene_suficientes_ingre'] as String?,
      idNoCapazCuidarFam: json['id_no_capaz_cuidar_fam'] as String?,
      idPerdidoControl: json['id_perdido_control'] as String?,
      idDejarCuidadoFamiliar: json['id_dejar_cuidado_familiar'] as String?,
      idIndeciso: json['id_indeciso'] as String?,
      idDeberiaHacerMasFam: json['id_deberia_hacer_mas_fam'] as String?,
      idGradoCargaExperimenta:
      json['id_grado_carga_experimenta'] as String?,
      idVulPerDiscapacidad: json['id_vul_per_discapacidad'] as String?,
      idPersonaCuidadora: json['id_persona_cuidadora'] as String?,
      idCuidadoOtrasPersonas: json['id_cuidado_otras_personas'] as String?,
      idCuidadoraDisc: json['id_cuidadora_disc'] as String?,
      idMiembroHogarSustituto:
      json['id_miembro_hogar_sustituto'] as String?,
      idSustitutoTrabaja: json['id_sustituto_trabaja'] as String?,
      idDiscCuidaPersonasHogar:
      json['id_disc_cuida_personas_hogar'] as String?,
    );
  }
}
