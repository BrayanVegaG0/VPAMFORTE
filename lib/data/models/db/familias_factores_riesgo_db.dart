// lib/data/models/db/familias_factores_riesgo_db.dart
//
// Modelo DB (modelo “tabla”) alineado a los campos de tu contrato/base.
// - NO incluye XML/SOAP.
// - Incluye: constructor, empty(), copyWith, toJson/fromJson.
// - idFamFactoresRiesgos se autogenera si no se pasa.
// - Campos con tildes en Java fueron normalizados en Dart (sin tildes) pero conservan
//   el nombre de CAMPO del contrato (idExplotacionSexual, idMaltratoFisico, etc.).

import 'package:uuid/uuid.dart';

class FamiliasFactoresRiesgoDb {
  final String idFamFactoresRiesgos;
  final String? idJefatura;
  final String? idNnaSeparado;



  final String? idEstadiaHogar;
  final String? idRelacionFamiliar;
  final String? idOpinionesEscuchadas;
  final String? idResponsabilidadesCotidianas;
  final String? idProblemasFamiliares;
  final String? idMaltratoHogar;
  final String? idSoloPeriodos;

  final String? idSinAlimentos;
  final String? idFrecuenciaSinAlimentos;

  final String? idManejaDinero;
  final String? quienManejaDinero;

  final String? idTocadoSuCuerpo;
  final String? quienTocaSuCuerpo;

  final String? idAbandonarlo;
  final String? quienAmenazaAbandonar;

  final String? idFrecuenciaTristeza;
  final String? idAfectaRelacionesFamiliar;

  final String? idFrecuenciaAlcohol;
  final String? idFrecuenciaTabaco;
  final String? idFrecuenciaDrogasIlegales;

  final String? idAlcoholPadre;
  final String? idTabacoPadre;
  final String? idDrogasPadre;

  final String? idAlcoholMadre;
  final String? idTabacoMadre;
  final String? idDrogasMadre;

  final String? idAlcoholHermanos;
  final String? idTabacoHermanos;
  final String? idDrogasHermanos;

  final String? idAlcoholOtrosFamiliares;
  final String? idTabacoOtrosFamiliares;
  final String? idDrogasOtrosFamiliares;

  final String? idAlcoholNoFamiliares;
  final String? idTabacoNoFamiliares;
  final String? idDrogasNoFamiliares;

  final String? idNecesidadPedirDinero;

  final String? idAgrecionVerbal;
  final String? idAgrecionFisica;
  final String? idAgrecionPsicologica;
  final String? idAgrecionSexual;
  final String? idAgrecionPatrimonial;
  final String? idAgrecionNinguno;

  final String? idDenunciaMaltrato;
  final String? cuantasDenuncias;

  final String? idAbandono;
  final String? idMendicidad;

  final String? idExplotacionSexual;
  final String? idExplotacionLaboral;
  final String? idMaltratoFisico;
  final String? idMaltratoPsicologico;

  final String? idMaltratoPatrimonial;
  final String? idMaltratoEmocional;
  final String? idDeseaseoPerDisc;
  final String? idDesaseoVivienda;

  final String? idFamPrivLibertad;
  final String? idFamRelaPrivLib;
  final String? idFamTipoPrivLib;
  final String? idTieneSentencia;

  final String? idFamDesa;
  final String? famDesaParentesco;
  final String? famDesaTiempo;
  final String? idTrabaFuera;
  final String? trabaFueraParentesco;
  final String? trabaFueraDonde;
  final String? idFamEsOtroPais;
  final String? idTiempoIngreso;
  final String? famEsOtroPaisDonde;
  final String? idTieneVisadoEcuat;
  final String? numVisadoEcuat;

  final String? idAma;
  final String? idAmaPregUno;
  final String? idAmaPregDos;
  final String? idAmaPregTres;
  final String? idAmaPregCuatro;
  final String? idAmaPregCinco;
  final String? idAmaPregSeis;
  final String? idAmaPregSiete;
  final String? idAmaPregOcho;
  final String? idAmaPregNueve;

  FamiliasFactoresRiesgoDb({
    String? idFamFactoresRiesgos,
    this.idEstadiaHogar,
    this.idRelacionFamiliar,
    this.idOpinionesEscuchadas,
    this.idResponsabilidadesCotidianas,
    this.idProblemasFamiliares,
    this.idMaltratoHogar,
    this.idSoloPeriodos,
    this.idSinAlimentos,
    this.idFrecuenciaSinAlimentos,
    this.idManejaDinero,
    this.quienManejaDinero,
    this.idTocadoSuCuerpo,
    this.quienTocaSuCuerpo,
    this.idAbandonarlo,
    this.quienAmenazaAbandonar,
    this.idFrecuenciaTristeza,
    this.idAfectaRelacionesFamiliar,
    this.idFrecuenciaAlcohol,
    this.idFrecuenciaTabaco,
    this.idFrecuenciaDrogasIlegales,
    this.idAlcoholPadre,
    this.idTabacoPadre,
    this.idDrogasPadre,
    this.idAlcoholMadre,
    this.idTabacoMadre,
    this.idDrogasMadre,
    this.idAlcoholHermanos,
    this.idTabacoHermanos,
    this.idDrogasHermanos,
    this.idAlcoholOtrosFamiliares,
    this.idTabacoOtrosFamiliares,
    this.idDrogasOtrosFamiliares,
    this.idAlcoholNoFamiliares,
    this.idTabacoNoFamiliares,
    this.idDrogasNoFamiliares,
    this.idNecesidadPedirDinero,
    this.idAgrecionVerbal,
    this.idAgrecionFisica,
    this.idAgrecionPsicologica,
    this.idAgrecionSexual,
    this.idAgrecionPatrimonial,
    this.idAgrecionNinguno,
    this.idDenunciaMaltrato,
    this.cuantasDenuncias,
    this.idAbandono,
    this.idMendicidad,
    this.idExplotacionSexual,
    this.idExplotacionLaboral,
    this.idMaltratoFisico,
    this.idMaltratoPsicologico,
    this.idMaltratoPatrimonial,
    this.idMaltratoEmocional,
    this.idDeseaseoPerDisc,
    this.idDesaseoVivienda,
    this.idJefatura,
    this.idNnaSeparado,
    this.idFamPrivLibertad,
    this.idFamRelaPrivLib,
    this.idFamTipoPrivLib,
    this.idTieneSentencia,
    this.idFamDesa,
    this.famDesaParentesco,
    this.famDesaTiempo,
    this.idTrabaFuera,
    this.trabaFueraParentesco,
    this.trabaFueraDonde,
    this.idFamEsOtroPais,
    this.idTiempoIngreso,
    this.famEsOtroPaisDonde,
    this.idTieneVisadoEcuat,
    this.numVisadoEcuat,
    this.idAma,
    this.idAmaPregUno,
    this.idAmaPregDos,
    this.idAmaPregTres,
    this.idAmaPregCuatro,
    this.idAmaPregCinco,
    this.idAmaPregSeis,
    this.idAmaPregSiete,
    this.idAmaPregOcho,
    this.idAmaPregNueve,

  }) : idFamFactoresRiesgos = idFamFactoresRiesgos ?? const Uuid().v4();

  static FamiliasFactoresRiesgoDb empty() => FamiliasFactoresRiesgoDb();

  FamiliasFactoresRiesgoDb copyWith({
    String? idEstadiaHogar,
    String? idRelacionFamiliar,
    String? idOpinionesEscuchadas,
    String? idResponsabilidadesCotidianas,
    String? idProblemasFamiliares,
    String? idMaltratoHogar,
    String? idSoloPeriodos,
    String? idSinAlimentos,
    String? idFrecuenciaSinAlimentos,
    String? idManejaDinero,
    String? quienManejaDinero,
    String? idTocadoSuCuerpo,
    String? quienTocaSuCuerpo,
    String? idAbandonarlo,
    String? quienAmenazaAbandonar,
    String? idFrecuenciaTristeza,
    String? idAfectaRelacionesFamiliar,
    String? idFrecuenciaAlcohol,
    String? idFrecuenciaTabaco,
    String? idFrecuenciaDrogasIlegales,
    String? idAlcoholPadre,
    String? idTabacoPadre,
    String? idDrogasPadre,
    String? idAlcoholMadre,
    String? idTabacoMadre,
    String? idDrogasMadre,
    String? idAlcoholHermanos,
    String? idTabacoHermanos,
    String? idDrogasHermanos,
    String? idAlcoholOtrosFamiliares,
    String? idTabacoOtrosFamiliares,
    String? idDrogasOtrosFamiliares,
    String? idAlcoholNoFamiliares,
    String? idTabacoNoFamiliares,
    String? idDrogasNoFamiliares,
    String? idNecesidadPedirDinero,
    String? idAgrecionVerbal,
    String? idAgrecionFisica,
    String? idAgrecionPsicologica,
    String? idAgrecionSexual,
    String? idAgrecionPatrimonial,
    String? idAgrecionNinguno,
    String? idDenunciaMaltrato,
    String? cuantasDenuncias,
    String? idAbandono,
    String? idMendicidad,
    String? idExplotacionSexual,
    String? idExplotacionLaboral,
    String? idMaltratoFisico,
    String? idMaltratoPsicologico,
    String? idMaltratoPatrimonial,
    String? idMaltratoEmocional,
    String? idDeseaseoPerDisc,
    String? idDesaseoVivienda,
    String? idJefatura,
    String? idNnaSeparado,
    String? idFamPrivLibertad,
    String? idFamRelaPrivLib,
    String? idFamTipoPrivLib,
    String? idTieneSentencia,
    String? idFamDesa,
    String? famDesaParentesco,
    String? famDesaTiempo,
    String? idTrabaFuera,
    String? trabaFueraParentesco,
    String? trabaFueraDonde,
    String? idFamEsOtroPais,
    String? idTiempoIngreso,
    String? famEsOtroPaisDonde,
    String? idTieneVisadoEcuat,
    String? numVisadoEcuat,
    String? idAma,
    String? idAmaPregUno,
    String? idAmaPregDos,
    String? idAmaPregTres,
    String? idAmaPregCuatro,
    String? idAmaPregCinco,
    String? idAmaPregSeis,
    String? idAmaPregSiete,
    String? idAmaPregOcho,
    String? idAmaPregNueve,
  }) {
    return FamiliasFactoresRiesgoDb(
      idFamFactoresRiesgos: idFamFactoresRiesgos,
      idEstadiaHogar: idEstadiaHogar ?? this.idEstadiaHogar,
      idRelacionFamiliar: idRelacionFamiliar ?? this.idRelacionFamiliar,
      idOpinionesEscuchadas: idOpinionesEscuchadas ?? this.idOpinionesEscuchadas,
      idResponsabilidadesCotidianas:
      idResponsabilidadesCotidianas ?? this.idResponsabilidadesCotidianas,
      idProblemasFamiliares: idProblemasFamiliares ?? this.idProblemasFamiliares,
      idMaltratoHogar: idMaltratoHogar ?? this.idMaltratoHogar,
      idSoloPeriodos: idSoloPeriodos ?? this.idSoloPeriodos,
      idSinAlimentos: idSinAlimentos ?? this.idSinAlimentos,
      idFrecuenciaSinAlimentos: idFrecuenciaSinAlimentos ?? this.idFrecuenciaSinAlimentos,
      idManejaDinero: idManejaDinero ?? this.idManejaDinero,
      quienManejaDinero: quienManejaDinero ?? this.quienManejaDinero,
      idTocadoSuCuerpo: idTocadoSuCuerpo ?? this.idTocadoSuCuerpo,
      quienTocaSuCuerpo: quienTocaSuCuerpo ?? this.quienTocaSuCuerpo,
      idAbandonarlo: idAbandonarlo ?? this.idAbandonarlo,
      quienAmenazaAbandonar: quienAmenazaAbandonar ?? this.quienAmenazaAbandonar,
      idFrecuenciaTristeza: idFrecuenciaTristeza ?? this.idFrecuenciaTristeza,
      idAfectaRelacionesFamiliar: idAfectaRelacionesFamiliar ?? this.idAfectaRelacionesFamiliar,
      idFrecuenciaAlcohol: idFrecuenciaAlcohol ?? this.idFrecuenciaAlcohol,
      idFrecuenciaTabaco: idFrecuenciaTabaco ?? this.idFrecuenciaTabaco,
      idFrecuenciaDrogasIlegales: idFrecuenciaDrogasIlegales ?? this.idFrecuenciaDrogasIlegales,
      idAlcoholPadre: idAlcoholPadre ?? this.idAlcoholPadre,
      idTabacoPadre: idTabacoPadre ?? this.idTabacoPadre,
      idDrogasPadre: idDrogasPadre ?? this.idDrogasPadre,
      idAlcoholMadre: idAlcoholMadre ?? this.idAlcoholMadre,
      idTabacoMadre: idTabacoMadre ?? this.idTabacoMadre,
      idDrogasMadre: idDrogasMadre ?? this.idDrogasMadre,
      idAlcoholHermanos: idAlcoholHermanos ?? this.idAlcoholHermanos,
      idTabacoHermanos: idTabacoHermanos ?? this.idTabacoHermanos,
      idDrogasHermanos: idDrogasHermanos ?? this.idDrogasHermanos,
      idAlcoholOtrosFamiliares: idAlcoholOtrosFamiliares ?? this.idAlcoholOtrosFamiliares,
      idTabacoOtrosFamiliares: idTabacoOtrosFamiliares ?? this.idTabacoOtrosFamiliares,
      idDrogasOtrosFamiliares: idDrogasOtrosFamiliares ?? this.idDrogasOtrosFamiliares,
      idAlcoholNoFamiliares: idAlcoholNoFamiliares ?? this.idAlcoholNoFamiliares,
      idTabacoNoFamiliares: idTabacoNoFamiliares ?? this.idTabacoNoFamiliares,
      idDrogasNoFamiliares: idDrogasNoFamiliares ?? this.idDrogasNoFamiliares,
      idNecesidadPedirDinero: idNecesidadPedirDinero ?? this.idNecesidadPedirDinero,
      idAgrecionVerbal: idAgrecionVerbal ?? this.idAgrecionVerbal,
      idAgrecionFisica: idAgrecionFisica ?? this.idAgrecionFisica,
      idAgrecionPsicologica: idAgrecionPsicologica ?? this.idAgrecionPsicologica,
      idAgrecionSexual: idAgrecionSexual ?? this.idAgrecionSexual,
      idAgrecionPatrimonial: idAgrecionPatrimonial ?? this.idAgrecionPatrimonial,
      idAgrecionNinguno: idAgrecionNinguno ?? this.idAgrecionNinguno,
      idDenunciaMaltrato: idDenunciaMaltrato ?? this.idDenunciaMaltrato,
      cuantasDenuncias: cuantasDenuncias ?? this.cuantasDenuncias,
      idAbandono: idAbandono ?? this.idAbandono,
      idMendicidad: idMendicidad ?? this.idMendicidad,
      idExplotacionSexual: idExplotacionSexual ?? this.idExplotacionSexual,
      idExplotacionLaboral: idExplotacionLaboral ?? this.idExplotacionLaboral,
      idMaltratoFisico: idMaltratoFisico ?? this.idMaltratoFisico,
      idMaltratoPsicologico: idMaltratoPsicologico ?? this.idMaltratoPsicologico,
      idMaltratoPatrimonial: idMaltratoPatrimonial ?? this.idMaltratoPatrimonial,
      idMaltratoEmocional: idMaltratoEmocional ?? this.idMaltratoEmocional,
      idDeseaseoPerDisc: idDeseaseoPerDisc ?? this.idDeseaseoPerDisc,
      idDesaseoVivienda: idDesaseoVivienda ?? this.idDesaseoVivienda,
      idJefatura: idJefatura ?? this.idJefatura,
      idNnaSeparado: idNnaSeparado ?? this.idNnaSeparado,
      idFamPrivLibertad: idFamPrivLibertad ?? this.idFamPrivLibertad,
      idFamRelaPrivLib: idFamRelaPrivLib ?? this.idFamRelaPrivLib,
      idFamTipoPrivLib: idFamTipoPrivLib ?? this.idFamTipoPrivLib,
      idTieneSentencia: idTieneSentencia ?? this.idTieneSentencia,
      idFamDesa: idFamDesa ?? this.idFamDesa,
      famDesaParentesco: famDesaParentesco ?? this.famDesaParentesco,
      famDesaTiempo: famDesaTiempo ?? this.famDesaTiempo,
      idTrabaFuera: idTrabaFuera ?? this.idTrabaFuera,
      trabaFueraParentesco: trabaFueraParentesco ?? this.trabaFueraParentesco,
      trabaFueraDonde: trabaFueraDonde ?? this.trabaFueraDonde,
      idFamEsOtroPais: idFamEsOtroPais ?? this.idFamEsOtroPais,
      idTiempoIngreso: idTiempoIngreso ?? this.idTiempoIngreso,
      famEsOtroPaisDonde: famEsOtroPaisDonde ?? this.famEsOtroPaisDonde,
      idTieneVisadoEcuat: idTieneVisadoEcuat ?? this.idTieneVisadoEcuat,
      numVisadoEcuat: numVisadoEcuat ?? this.numVisadoEcuat,
      idAma: idAma ?? this.idAma,
      idAmaPregUno: idAmaPregUno ?? this.idAmaPregUno,
      idAmaPregDos: idAmaPregDos ?? this.idAmaPregDos,
      idAmaPregTres: idAmaPregTres ?? this.idAmaPregTres,
      idAmaPregCuatro: idAmaPregCuatro ?? this.idAmaPregCuatro,
      idAmaPregCinco: idAmaPregCinco ?? this.idAmaPregCinco,
      idAmaPregSeis: idAmaPregSeis ?? this.idAmaPregSeis,
      idAmaPregSiete: idAmaPregSiete ?? this.idAmaPregSiete,
      idAmaPregOcho: idAmaPregOcho ?? this.idAmaPregOcho,
      idAmaPregNueve: idAmaPregNueve ?? this.idAmaPregNueve,
    );
  }

  Map<String, dynamic> toJson() => {
    'idFamFactoresRiesgos': idFamFactoresRiesgos,
    'idEstadiaHogar': idEstadiaHogar,
    'idRelacionFamiliar': idRelacionFamiliar,
    'idOpinionesEscuchadas': idOpinionesEscuchadas,
    'idResponsabilidadesCotidianas': idResponsabilidadesCotidianas,
    'idProblemasFamiliares': idProblemasFamiliares,
    'idMaltratoHogar': idMaltratoHogar,
    'idSoloPeriodos': idSoloPeriodos,
    'idSinAlimentos': idSinAlimentos,
    'idFrecuenciaSinAlimentos': idFrecuenciaSinAlimentos,
    'idManejaDinero': idManejaDinero,
    'quienManejaDinero': quienManejaDinero,
    'idTocadoSuCuerpo': idTocadoSuCuerpo,
    'quienTocaSuCuerpo': quienTocaSuCuerpo,
    'idAbandonarlo': idAbandonarlo,
    'quienAmenazaAbandonar': quienAmenazaAbandonar,
    'idFrecuenciaTristeza': idFrecuenciaTristeza,
    'idAfectaRelacionesFamiliar': idAfectaRelacionesFamiliar,
    'idFrecuenciaAlcohol': idFrecuenciaAlcohol,
    'idFrecuenciaTabaco': idFrecuenciaTabaco,
    'idFrecuenciaDrogasIlegales': idFrecuenciaDrogasIlegales,
    'idAlcoholPadre': idAlcoholPadre,
    'idTabacoPadre': idTabacoPadre,
    'idDrogasPadre': idDrogasPadre,
    'idAlcoholMadre': idAlcoholMadre,
    'idTabacoMadre': idTabacoMadre,
    'idDrogasMadre': idDrogasMadre,
    'idAlcoholHermanos': idAlcoholHermanos,
    'idTabacoHermanos': idTabacoHermanos,
    'idDrogasHermanos': idDrogasHermanos,
    'idAlcoholOtrosFamiliares': idAlcoholOtrosFamiliares,
    'idTabacoOtrosFamiliares': idTabacoOtrosFamiliares,
    'idDrogasOtrosFamiliares': idDrogasOtrosFamiliares,
    'idAlcoholNoFamiliares': idAlcoholNoFamiliares,
    'idTabacoNoFamiliares': idTabacoNoFamiliares,
    'idDrogasNoFamiliares': idDrogasNoFamiliares,
    'idNecesidadPedirDinero': idNecesidadPedirDinero,
    'idAgrecionVerbal': idAgrecionVerbal,
    'idAgrecionFisica': idAgrecionFisica,
    'idAgrecionPsicologica': idAgrecionPsicologica,
    'idAgrecionSexual': idAgrecionSexual,
    'idAgrecionPatrimonial': idAgrecionPatrimonial,
    'idAgrecionNinguno': idAgrecionNinguno,
    'idDenunciaMaltrato': idDenunciaMaltrato,
    'cuantasDenuncias': cuantasDenuncias,
    'idAbandono': idAbandono,
    'idMendicidad': idMendicidad,
    'idExplotacionSexual': idExplotacionSexual,
    'idExplotacionLaboral': idExplotacionLaboral,
    'idMaltratoFisico': idMaltratoFisico,
    'idMaltratoPsicologico': idMaltratoPsicologico,
    'idMaltratoPatrimonial': idMaltratoPatrimonial,
    'idMaltratoEmocional': idMaltratoEmocional,
    'idDeseaseoPerDisc': idDeseaseoPerDisc,
    'idDesaseoVivienda': idDesaseoVivienda,
    'idJefatura': idJefatura,
    'idNnaSeparado': idNnaSeparado,
    'idFamPrivLibertad': idFamPrivLibertad,
    'idFamRelaPrivLib': idFamRelaPrivLib,
    'idFamTipoPrivLib': idFamTipoPrivLib,
    'idTieneSentencia': idTieneSentencia,
    'idFamDesa': idFamDesa,
    'famDesaParentesco': famDesaParentesco,
    'famDesaTiempo': famDesaTiempo,
    'idTrabaFuera': idTrabaFuera,
    'trabaFueraParentesco': trabaFueraParentesco,
    'trabaFueraDonde': trabaFueraDonde,
    'idFamEsOtroPais': idFamEsOtroPais,
    'idTiempoIngreso': idTiempoIngreso,
    'famEsOtroPaisDonde': famEsOtroPaisDonde,
    'idTieneVisadoEcuat': idTieneVisadoEcuat,
    'numVisadoEcuat': numVisadoEcuat,
    'idAma': idAma,
    'idAmaPregUno': idAmaPregUno,
    'idAmaPregDos': idAmaPregDos,
    'idAmaPregTres': idAmaPregTres,
    'idAmaPregCuatro': idAmaPregCuatro,
    'idAmaPregCinco': idAmaPregCinco,
    'idAmaPregSeis': idAmaPregSeis,
    'idAmaPregSiete': idAmaPregSiete,
    'idAmaPregOcho': idAmaPregOcho,
    'idAmaPregNueve': idAmaPregNueve,
  };

  static FamiliasFactoresRiesgoDb fromJson(Map<String, dynamic> json) {
    return FamiliasFactoresRiesgoDb(
      idFamFactoresRiesgos: (json['idFamFactoresRiesgos'] as String?) ?? const Uuid().v4(),
      idEstadiaHogar: json['idEstadiaHogar'] as String?,
      idRelacionFamiliar: json['idRelacionFamiliar'] as String?,
      idOpinionesEscuchadas: json['idOpinionesEscuchadas'] as String?,
      idResponsabilidadesCotidianas: json['idResponsabilidadesCotidianas'] as String?,
      idProblemasFamiliares: json['idProblemasFamiliares'] as String?,
      idMaltratoHogar: json['idMaltratoHogar'] as String?,
      idSoloPeriodos: json['idSoloPeriodos'] as String?,
      idSinAlimentos: json['idSinAlimentos'] as String?,
      idFrecuenciaSinAlimentos: json['idFrecuenciaSinAlimentos'] as String?,
      idManejaDinero: json['idManejaDinero'] as String?,
      quienManejaDinero: json['quienManejaDinero'] as String?,
      idTocadoSuCuerpo: json['idTocadoSuCuerpo'] as String?,
      quienTocaSuCuerpo: json['quienTocaSuCuerpo'] as String?,
      idAbandonarlo: json['idAbandonarlo'] as String?,
      quienAmenazaAbandonar: json['quienAmenazaAbandonar'] as String?,
      idFrecuenciaTristeza: json['idFrecuenciaTristeza'] as String?,
      idAfectaRelacionesFamiliar: json['idAfectaRelacionesFamiliar'] as String?,
      idFrecuenciaAlcohol: json['idFrecuenciaAlcohol'] as String?,
      idFrecuenciaTabaco: json['idFrecuenciaTabaco'] as String?,
      idFrecuenciaDrogasIlegales: json['idFrecuenciaDrogasIlegales'] as String?,
      idAlcoholPadre: json['idAlcoholPadre'] as String?,
      idTabacoPadre: json['idTabacoPadre'] as String?,
      idDrogasPadre: json['idDrogasPadre'] as String?,
      idAlcoholMadre: json['idAlcoholMadre'] as String?,
      idTabacoMadre: json['idTabacoMadre'] as String?,
      idDrogasMadre: json['idDrogasMadre'] as String?,
      idAlcoholHermanos: json['idAlcoholHermanos'] as String?,
      idTabacoHermanos: json['idTabacoHermanos'] as String?,
      idDrogasHermanos: json['idDrogasHermanos'] as String?,
      idAlcoholOtrosFamiliares: json['idAlcoholOtrosFamiliares'] as String?,
      idTabacoOtrosFamiliares: json['idTabacoOtrosFamiliares'] as String?,
      idDrogasOtrosFamiliares: json['idDrogasOtrosFamiliares'] as String?,
      idAlcoholNoFamiliares: json['idAlcoholNoFamiliares'] as String?,
      idTabacoNoFamiliares: json['idTabacoNoFamiliares'] as String?,
      idDrogasNoFamiliares: json['idDrogasNoFamiliares'] as String?,
      idNecesidadPedirDinero: json['idNecesidadPedirDinero'] as String?,
      idAgrecionVerbal: json['idAgrecionVerbal'] as String?,
      idAgrecionFisica: json['idAgrecionFisica'] as String?,
      idAgrecionPsicologica: json['idAgrecionPsicologica'] as String?,
      idAgrecionSexual: json['idAgrecionSexual'] as String?,
      idAgrecionPatrimonial: json['idAgrecionPatrimonial'] as String?,
      idAgrecionNinguno: json['idAgrecionNinguno'] as String?,
      idDenunciaMaltrato: json['idDenunciaMaltrato'] as String?,
      cuantasDenuncias: json['cuantasDenuncias'] as String?,
      idAbandono: json['idAbandono'] as String?,
      idMendicidad: json['idMendicidad'] as String?,
      idExplotacionSexual: json['idExplotacionSexual'] as String?,
      idExplotacionLaboral: json['idExplotacionLaboral'] as String?,
      idMaltratoFisico: json['idMaltratoFisico'] as String?,
      idMaltratoPsicologico: json['idMaltratoPsicologico'] as String?,
      idMaltratoPatrimonial: json['idMaltratoPatrimonial'] as String?,
      idMaltratoEmocional: json['idMaltratoEmocional'] as String?,
      idDeseaseoPerDisc: json['idDeseaseoPerDisc'] as String?,
      idDesaseoVivienda: json['idDesaseoVivienda'] as String?,
      idJefatura: json['idJefatura'] as String?,
      idNnaSeparado: json['idNnaSeparado'] as String?,
      idFamPrivLibertad: json['idFamPrivLibertad'] as String?,
      idFamRelaPrivLib: json['idFamRelaPrivLib'] as String?,
      idFamTipoPrivLib: json['idFamTipoPrivLib'] as String?,
      idTieneSentencia: json['idTieneSentencia'] as String?,
      idFamDesa: json['idFamDesa'] as String?,
      famDesaParentesco: json['famDesaParentesco'] as String?,
      famDesaTiempo: json['famDesaTiempo'] as String?,
      idTrabaFuera: json['idTrabaFuera'] as String?,
      trabaFueraParentesco: json['trabaFueraParentesco'] as String?,
      trabaFueraDonde: json['trabaFueraDonde'] as String?,
      idFamEsOtroPais: json['idFamEsOtroPais'] as String?,
      idTiempoIngreso: json['idTiempoIngreso'] as String?,
      famEsOtroPaisDonde: json['famEsOtroPaisDonde'] as String?,
      idTieneVisadoEcuat: json['idTieneVisadoEcuat'] as String?,
      numVisadoEcuat: json['numVisadoEcuat'] as String?,
      idAma: json['idAma'] as String?,
      idAmaPregUno: json['idAmaPregUno'] as String?,
      idAmaPregDos: json['idAmaPregDos'] as String?,
      idAmaPregTres: json['idAmaPregTres'] as String?,
      idAmaPregCuatro: json['idAmaPregCuatro'] as String?,
      idAmaPregCinco: json['idAmaPregCinco'] as String?,
      idAmaPregSeis: json['idAmaPregSeis'] as String?,
      idAmaPregSiete: json['idAmaPregSiete'] as String?,
      idAmaPregOcho: json['idAmaPregOcho'] as String?,
      idAmaPregNueve: json['idAmaPregNueve'] as String?,
    );
  }
}
