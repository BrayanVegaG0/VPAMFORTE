import 'package:uuid/uuid.dart';

class FichaPcdDb {
  final String idFichapcd;

  final String? idAtenMed;
  final String? idRecursosSuf;
  final String? idApoyoEmoc;
  final String? idRedApoyo;
  final String? idOportFormProf;
  final String? idDecisVida;
  final String? idOportunEmpleo;
  final String? idAccesInfoDere;
  final String? idNoVolDecis;
  final String? idParticipaEntor;
  final String? idSinApoyo;
  final String? idAccederObst;
  final String? idExpresarOpin;
  final String? idApoyoDesaHabil;
  final String? idDiscrimViolencia;
  final String? idIntitutoAprender;
  final String? idCondicMinimSeg;
  final String? idEnseUtiliMat;
  final String? idApoyoDecisVida;
  final String? idValOpiniones;
  final String? idEnseFormaAcces;
  final String? idSegComuni;
  final String? idAyudaTecnic;
  final String? idApoyoDialog;
  final String? idAudifAyuTec;
  final String? idMantAyuTec;
  final String? idAyuTecBuenEst;
  final String? idAyuTecMovMas;
  final String? idMedDifMov;
  final String? idApoyoPsico;
  final String? idNoAsisteTrat;
  final String? idAccesContrMental;
  final String? idEntornoAdaptado;
  final String? idBienestarSenia;
  final String? idExprDeciPref;
  final String? idAccesTerapias;
  final String? idExclAct;
  final String? idAyuTecCom;
/*
  final String? idVulPerDiscapacidad;

  final String? userRegistra;
  final String? userModifica;
  final String? fechaRegistra;
  final String? fechaModifica;*/

  FichaPcdDb({
    String? idFichapcd,
    this.idAtenMed,
    this.idRecursosSuf,
    this.idApoyoEmoc,
    this.idRedApoyo,
    this.idOportFormProf,
    this.idDecisVida,
    this.idOportunEmpleo,
    this.idAccesInfoDere,
    this.idNoVolDecis,
    this.idParticipaEntor,
    this.idSinApoyo,
    this.idAccederObst,
    this.idExpresarOpin,
    this.idApoyoDesaHabil,
    this.idDiscrimViolencia,
    this.idIntitutoAprender,
    this.idCondicMinimSeg,
    this.idEnseUtiliMat,
    this.idApoyoDecisVida,
    this.idValOpiniones,
    this.idEnseFormaAcces,
    this.idSegComuni,
    this.idAyudaTecnic,
    this.idApoyoDialog,
    this.idAudifAyuTec,
    this.idMantAyuTec,
    this.idAyuTecBuenEst,
    this.idAyuTecMovMas,
    this.idMedDifMov,
    this.idApoyoPsico,
    this.idNoAsisteTrat,
    this.idAccesContrMental,
    this.idEntornoAdaptado,
    this.idBienestarSenia,
    this.idExprDeciPref,
    this.idAccesTerapias,
    this.idExclAct,
    this.idAyuTecCom,
/*    this.idVulPerDiscapacidad,
    this.userRegistra,
    this.userModifica,
    this.fechaRegistra,
    this.fechaModifica,*/
  }) : idFichapcd = idFichapcd ?? const Uuid().v4();

  FichaPcdDb copyWith({
    String? idAtenMed,
    String? idRecursosSuf,
    String? idApoyoEmoc,
    String? idRedApoyo,
    String? idOportFormProf,
    String? idDecisVida,
    String? idOportunEmpleo,
    String? idAccesInfoDere,
    String? idNoVolDecis,
    String? idParticipaEntor,
    String? idSinApoyo,
    String? idAccederObst,
    String? idExpresarOpin,
    String? idApoyoDesaHabil,
    String? idDiscrimViolencia,
    String? idIntitutoAprender,
    String? idCondicMinimSeg,
    String? idEnseUtiliMat,
    String? idApoyoDecisVida,
    String? idValOpiniones,
    String? idEnseFormaAcces,
    String? idSegComuni,
    String? idAyudaTecnic,
    String? idApoyoDialog,
    String? idAudifAyuTec,
    String? idMantAyuTec,
    String? idAyuTecBuenEst,
    String? idAyuTecMovMas,
    String? idMedDifMov,
    String? idApoyoPsico,
    String? idNoAsisteTrat,
    String? idAccesContrMental,
    String? idEntornoAdaptado,
    String? idBienestarSenia,
    String? idExprDeciPref,
    String? idAccesTerapias,
    String? idExclAct,
    String? idAyuTecCom,
    String? idVulPerDiscapacidad,
    String? userRegistra,
    String? userModifica,
    String? fechaRegistra,
    String? fechaModifica,
  }) {
    return FichaPcdDb(
      idFichapcd: idFichapcd,
      idAtenMed: idAtenMed ?? this.idAtenMed,
      idRecursosSuf: idRecursosSuf ?? this.idRecursosSuf,
      idApoyoEmoc: idApoyoEmoc ?? this.idApoyoEmoc,
      idRedApoyo: idRedApoyo ?? this.idRedApoyo,
      idOportFormProf: idOportFormProf ?? this.idOportFormProf,
      idDecisVida: idDecisVida ?? this.idDecisVida,
      idOportunEmpleo: idOportunEmpleo ?? this.idOportunEmpleo,
      idAccesInfoDere: idAccesInfoDere ?? this.idAccesInfoDere,
      idNoVolDecis: idNoVolDecis ?? this.idNoVolDecis,
      idParticipaEntor: idParticipaEntor ?? this.idParticipaEntor,
      idSinApoyo: idSinApoyo ?? this.idSinApoyo,
      idAccederObst: idAccederObst ?? this.idAccederObst,
      idExpresarOpin: idExpresarOpin ?? this.idExpresarOpin,
      idApoyoDesaHabil: idApoyoDesaHabil ?? this.idApoyoDesaHabil,
      idDiscrimViolencia: idDiscrimViolencia ?? this.idDiscrimViolencia,
      idIntitutoAprender: idIntitutoAprender ?? this.idIntitutoAprender,
      idCondicMinimSeg: idCondicMinimSeg ?? this.idCondicMinimSeg,
      idEnseUtiliMat: idEnseUtiliMat ?? this.idEnseUtiliMat,
      idApoyoDecisVida: idApoyoDecisVida ?? this.idApoyoDecisVida,
      idValOpiniones: idValOpiniones ?? this.idValOpiniones,
      idEnseFormaAcces: idEnseFormaAcces ?? this.idEnseFormaAcces,
      idSegComuni: idSegComuni ?? this.idSegComuni,
      idAyudaTecnic: idAyudaTecnic ?? this.idAyudaTecnic,
      idApoyoDialog: idApoyoDialog ?? this.idApoyoDialog,
      idAudifAyuTec: idAudifAyuTec ?? this.idAudifAyuTec,
      idMantAyuTec: idMantAyuTec ?? this.idMantAyuTec,
      idAyuTecBuenEst: idAyuTecBuenEst ?? this.idAyuTecBuenEst,
      idAyuTecMovMas: idAyuTecMovMas ?? this.idAyuTecMovMas,
      idMedDifMov: idMedDifMov ?? this.idMedDifMov,
      idApoyoPsico: idApoyoPsico ?? this.idApoyoPsico,
      idNoAsisteTrat: idNoAsisteTrat ?? this.idNoAsisteTrat,
      idAccesContrMental: idAccesContrMental ?? this.idAccesContrMental,
      idEntornoAdaptado: idEntornoAdaptado ?? this.idEntornoAdaptado,
      idBienestarSenia: idBienestarSenia ?? this.idBienestarSenia,
      idExprDeciPref: idExprDeciPref ?? this.idExprDeciPref,
      idAccesTerapias: idAccesTerapias ?? this.idAccesTerapias,
      idExclAct: idExclAct ?? this.idExclAct,
      idAyuTecCom: idAyuTecCom ?? this.idAyuTecCom,
/*      idVulPerDiscapacidad: idVulPerDiscapacidad ?? this.idVulPerDiscapacidad,
      userRegistra: userRegistra ?? this.userRegistra,
      userModifica: userModifica ?? this.userModifica,
      fechaRegistra: fechaRegistra ?? this.fechaRegistra,
      fechaModifica: fechaModifica ?? this.fechaModifica,*/
    );
  }

  Map<String, dynamic> toJson() => {
    'id_fichapcd': idFichapcd,
    'id_aten_med': idAtenMed,
    'id_recursos_suf': idRecursosSuf,
    'id_apoyo_emoc': idApoyoEmoc,
    'id_red_apoyo': idRedApoyo,
    'id_oport_form_prof': idOportFormProf,
    'id_decis_vida': idDecisVida,
    'id_oportun_empleo': idOportunEmpleo,
    'id_acces_info_dere': idAccesInfoDere,
    'id_no_vol_decis': idNoVolDecis,
    'id_participa_entor': idParticipaEntor,
    'id_sin_apoyo': idSinApoyo,
    'id_acceder_obst': idAccederObst,
    'id_expresar_opin': idExpresarOpin,
    'id_apoyo_desa_habil': idApoyoDesaHabil,
    'id_discrim_violencia': idDiscrimViolencia,
    'id_intituto_aprender': idIntitutoAprender,
    'id_condic_minim_seg': idCondicMinimSeg,
    'id_ense_utili_mat': idEnseUtiliMat,
    'id_apoyo_decis_vida': idApoyoDecisVida,
    'id_val_opiniones': idValOpiniones,
    'id_ense_forma_acces': idEnseFormaAcces,
    'id_seg_comuni': idSegComuni,
    'id_ayuda_tecnic': idAyudaTecnic,
    'id_apoyo_dialog': idApoyoDialog,
    'id_audif_ayu_tec': idAudifAyuTec,
    'id_mant_ayu_tec': idMantAyuTec,
    'id_ayu_tec_buen_est': idAyuTecBuenEst,
    'id_ayu_tec_mov_mas': idAyuTecMovMas,
    'id_med_dif_mov': idMedDifMov,
    'id_apoyo_psico': idApoyoPsico,
    'id_no_asiste_trat': idNoAsisteTrat,
    'id_acces_contr_mental': idAccesContrMental,
    'id_entorno_adaptado': idEntornoAdaptado,
    'id_bienestar_senia': idBienestarSenia,
    'id_expr_deci_pref': idExprDeciPref,
    'id_acces_terapias': idAccesTerapias,
    'id_excl_act': idExclAct,
    'id_ayu_tec_com': idAyuTecCom,
/*    'id_vul_per_discapacidad': idVulPerDiscapacidad,
    'user_registra': userRegistra,
    'user_modifica': userModifica,
    'fecha_registra': fechaRegistra,
    'fecha_modifica': fechaModifica,*/
  };

  static FichaPcdDb fromJson(Map<String, dynamic> json) {
    return FichaPcdDb(
      idFichapcd: (json['id_fichapcd'] as String?) ?? const Uuid().v4(),
      idAtenMed: json['id_aten_med'] as String?,
      idRecursosSuf: json['id_recursos_suf'] as String?,
      idApoyoEmoc: json['id_apoyo_emoc'] as String?,
      idRedApoyo: json['id_red_apoyo'] as String?,
      idOportFormProf: json['id_oport_form_prof'] as String?,
      idDecisVida: json['id_decis_vida'] as String?,
      idOportunEmpleo: json['id_oportun_empleo'] as String?,
      idAccesInfoDere: json['id_acces_info_dere'] as String?,
      idNoVolDecis: json['id_no_vol_decis'] as String?,
      idParticipaEntor: json['id_participa_entor'] as String?,
      idSinApoyo: json['id_sin_apoyo'] as String?,
      idAccederObst: json['id_acceder_obst'] as String?,
      idExpresarOpin: json['id_expresar_opin'] as String?,
      idApoyoDesaHabil: json['id_apoyo_desa_habil'] as String?,
      idDiscrimViolencia: json['id_discrim_violencia'] as String?,
      idIntitutoAprender: json['id_intituto_aprender'] as String?,
      idCondicMinimSeg: json['id_condic_minim_seg'] as String?,
      idEnseUtiliMat: json['id_ense_utili_mat'] as String?,
      idApoyoDecisVida: json['id_apoyo_decis_vida'] as String?,
      idValOpiniones: json['id_val_opiniones'] as String?,
      idEnseFormaAcces: json['id_ense_forma_acces'] as String?,
      idSegComuni: json['id_seg_comuni'] as String?,
      idAyudaTecnic: json['id_ayuda_tecnic'] as String?,
      idApoyoDialog: json['id_apoyo_dialog'] as String?,
      idAudifAyuTec: json['id_audif_ayu_tec'] as String?,
      idMantAyuTec: json['id_mant_ayu_tec'] as String?,
      idAyuTecBuenEst: json['id_ayu_tec_buen_est'] as String?,
      idAyuTecMovMas: json['id_ayu_tec_mov_mas'] as String?,
      idMedDifMov: json['id_med_dif_mov'] as String?,
      idApoyoPsico: json['id_apoyo_psico'] as String?,
      idNoAsisteTrat: json['id_no_asiste_trat'] as String?,
      idAccesContrMental: json['id_acces_contr_mental'] as String?,
      idEntornoAdaptado: json['id_entorno_adaptado'] as String?,
      idBienestarSenia: json['id_bienestar_senia'] as String?,
      idExprDeciPref: json['id_expr_deci_pref'] as String?,
      idAccesTerapias: json['id_acces_terapias'] as String?,
      idExclAct: json['id_excl_act'] as String?,
      idAyuTecCom: json['id_ayu_tec_com'] as String?,
/*      idVulPerDiscapacidad: json['id_vul_per_discapacidad'] as String?,
      userRegistra: json['user_registra'] as String?,
      userModifica: json['user_modifica'] as String?,
      fechaRegistra: json['fecha_registra'] as String?,
      fechaModifica: json['fecha_modifica'] as String?,*/
    );
  }
}
