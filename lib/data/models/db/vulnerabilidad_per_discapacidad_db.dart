// lib/data/models/db/vulnerabilidad_per_discapacidad_db.dart
//
// Modelo DB (modelo “tabla”) alineado a los campos de tu contrato/base.
// - NO incluye XML/SOAP (eso va en el serializer).
// - Incluye: constructor, copyWith, toJson/fromJson.
// - idVulPerDiscapacidad se autogenera si no se pasa.

import 'package:uuid/uuid.dart';

class VulnerabilidadPerDiscapacidadDb {
  final String idVulPerDiscapacidad;

  final String? idRespondeEncuesta;
  final String? idServMdh;
  final String? especifRespondeEnc;
  final String? idTipoDocumento;
  final String? nroDocumento;
  final String? idNacionalidad;
  final String? otraNacionalidad;
  final String? nombresApellidos;
  final String? fechaNacimiento;
  final String? edad;
  final String? idSexo;
  final String? idEstadoCivil;
  final String? idProvincia;
  final String? idCanton;
  final String? idParroquia;
  final String? callePrincipal;
  final String? calleSecundaria;
  final String? referenciaUbicVi;
  final String? telefono;
  final String? celular;
  final String? correo;
  final String? facebookMessenger;
  final String? telefonoFamiliar;
  final String? viveSolo;
  final String? idContactoFamiliares;
  final String? contactoPadres;
  final String? contactoHijo;
  final String? contactoHermano;
  final String? contactoNieto;
  final String? contactoOtrosFamiliares;
  final String? contactoOtrosNoFamiliares;
  final String? idFrecuenciaActividadesRecre;
  final String? recreacionDomicilio;
  final String? recreacionCasaAmigos;
  final String? recreacionParque;
  final String? recreacionFinca;
  final String? recreacionPlaya;
  final String? recreacionMontania;
  final String? idComunicaEntorno;
  final String? comunicaEntornoOtros;





  final String? idFrecuenciaContacComunidad;


  final String? vivePadres;
  final String? viveSoloPadreOMadre;
  final String? viveConyuge;
  final String? viveHijos;
  final String? viveHermanos;
  final String? viveNietos;
  final String? viveOtrosFamil;
  final String? vivePerServDomestico;
  final String? viveOtrosNoFamiliares;


  final String? idZona;
  final String? idDistrito;


  final String? idTipoDiscapacidad;
  final String? porcentajeDiscapacidad;
  final String? idTieneCarnetDiscapadidad;
  final String? numCarnetDiscapacidad;

  final String? idPerDiscEmbarazada;
  final String? mesesGestacion;

  final String? idEtnia;
  final String? idEtniaIndigena;
  final String? idInstruccion;
  final String? idGrado;



  final String? servSalud;
  final String? servEducacion;
  final String? servInclusionSocial;
  final String? servDeporte;
  final String? servCultura;
  final String? servTransporte;
  final String? servNinguno;

  final String? idUserRegistra;

  final String? fechaMovil;

  final String? valEstructuraFamiliar;
  final String? valLenguaPerDisc;
  final String? valIndiceBarthelDisc;
  final String? valActBasicasVidaDisc;
  final String? valCargaCuidadorDisc;

  final String? idIdioma;
  final String? idLenguaNativa;













  final String? idIEss;
  final String? idIEssCampesino;
  final String? idISsfa;
  final String? idISspol;
  final String? idPrivado;
  final String? idNinguno;

  final String? idServMies;
  final String? idServGad;
  final String? idServIglesia;
  final String? idServFundacion;
  final String? idServPrivado;
  final String? idServNinguno;
  final String? idServOtro;
  final String? servOtroCual;

  final String? idNoTiempo;
  final String? idDistante;
  final String? idNoDinero;
  final String? idMalasReferencias;
  final String? idOtroNoAsiste;
  final String? otroNoAsisteCual;

  final String? idDondeDormir;
  final String? idNecesitoAlimentacion;
  final String? idProteccionViolenciaIntra;
  final String? idDesarrolloHabilidades;
  final String? idNecesitaOtro;
  final String? otroNecesitaCual;

  VulnerabilidadPerDiscapacidadDb({
    String? idVulPerDiscapacidad,
    this.idRespondeEncuesta,
    this.idServMdh,
    this.especifRespondeEnc,
    this.viveSolo,
    this.vivePadres,
    this.viveSoloPadreOMadre,
    this.viveConyuge,
    this.viveHijos,
    this.viveHermanos,
    this.viveNietos,
    this.viveOtrosFamil,
    this.vivePerServDomestico,
    this.viveOtrosNoFamiliares,
    this.idContactoFamiliares,
    this.contactoPadres,
    this.contactoHijo,
    this.contactoHermano,
    this.contactoNieto,
    this.contactoOtrosFamiliares,
    this.contactoOtrosNoFamiliares,
    this.idTipoDocumento,
    this.nroDocumento,
    this.nombresApellidos,
    this.idNacionalidad,
    this.otraNacionalidad,
    this.idSexo,
    this.idEstadoCivil,
    this.idProvincia,
    this.idCanton,
    this.idParroquia,
    this.idZona,
    this.idDistrito,
    this.callePrincipal,
    this.calleSecundaria,
    this.referenciaUbicVi,
    this.telefono,
    this.celular,
    this.fechaNacimiento,
    this.edad,
    this.idTipoDiscapacidad,
    this.porcentajeDiscapacidad,
    this.idTieneCarnetDiscapadidad,
    this.numCarnetDiscapacidad,
    this.idPerDiscEmbarazada,
    this.mesesGestacion,
    this.idEtnia,
    this.idEtniaIndigena,
    this.idInstruccion,
    this.idGrado,
    this.idFrecuenciaContacComunidad,
    this.idFrecuenciaActividadesRecre,
    this.servSalud,
    this.servEducacion,
    this.servInclusionSocial,
    this.servDeporte,
    this.servCultura,
    this.servTransporte,
    this.servNinguno,
    this.idUserRegistra,
    this.fechaMovil,
    this.valEstructuraFamiliar,
    this.valLenguaPerDisc,
    this.valIndiceBarthelDisc,
    this.valActBasicasVidaDisc,
    this.valCargaCuidadorDisc,
    this.idIdioma,
    this.idLenguaNativa,
    this.correo,
    this.facebookMessenger,
    this.telefonoFamiliar,
    this.recreacionDomicilio,
    this.recreacionCasaAmigos,
    this.recreacionParque,
    this.recreacionFinca,
    this.recreacionPlaya,
    this.recreacionMontania,
    this.idComunicaEntorno,
    this.comunicaEntornoOtros,

    this.idIEss,
    this.idIEssCampesino,
    this.idISsfa,
    this.idISspol,
    this.idPrivado,
    this.idNinguno,
    this.idServMies,
    this.idServGad,
    this.idServIglesia,
    this.idServFundacion,
    this.idServPrivado,
    this.idServNinguno,
    this.idServOtro,
    this.servOtroCual,
    this.idNoTiempo,
    this.idDistante,
    this.idNoDinero,
    this.idMalasReferencias,
    this.idOtroNoAsiste,
    this.otroNoAsisteCual,
    this.idDondeDormir,
    this.idNecesitoAlimentacion,
    this.idProteccionViolenciaIntra,
    this.idDesarrolloHabilidades,
    this.idNecesitaOtro,
    this.otroNecesitaCual,
  }) : idVulPerDiscapacidad = idVulPerDiscapacidad ?? const Uuid().v4();

  VulnerabilidadPerDiscapacidadDb copyWith({
    String? idRespondeEncuesta,
    String? idServMdh,
    String? especifRespondeEnc,
    String? viveSolo,
    String? vivePadres,
    String? viveSoloPadreOMadre,
    String? viveConyuge,
    String? viveHijos,
    String? viveHermanos,
    String? viveNietos,
    String? viveOtrosFamil,
    String? vivePerServDomestico,
    String? viveOtrosNoFamiliares,
    String? idContactoFamiliares,
    String? contactoPadres,
    String? contactoHijo,
    String? contactoHermano,
    String? contactoNieto,
    String? contactoOtrosFamiliares,
    String? contactoOtrosNoFamiliares,
    String? idTipoDocumento,
    String? nroDocumento,
    String? nombresApellidos,
    String? idNacionalidad,
    String? otraNacionalidad,
    String? idSexo,
    String? idEstadoCivil,
    String? idProvincia,
    String? idCanton,
    String? idParroquia,
    String? idZona,
    String? idDistrito,
    String? callePrincipal,
    String? calleSecundaria,
    String? referenciaUbicVi,
    String? telefono,
    String? celular,
    String? fechaNacimiento,
    String? edad,
    String? idTipoDiscapacidad,
    String? porcentajeDiscapacidad,
    String? idTieneCarnetDiscapadidad,
    String? numCarnetDiscapacidad,
    String? idPerDiscEmbarazada,
    String? mesesGestacion,
    String? idEtnia,
    String? idEtniaIndigena,
    String? idInstruccion,
    String? idGrado,
    String? idFrecuenciaContacComunidad,
    String? idFrecuenciaActividadesRecre,
    String? servSalud,
    String? servEducacion,
    String? servInclusionSocial,
    String? servDeporte,
    String? servCultura,
    String? servTransporte,
    String? servNinguno,
    String? idUserRegistra,
    String? fechaMovil,
    String? valEstructuraFamiliar,
    String? valLenguaPerDisc,
    String? valIndiceBarthelDisc,
    String? valActBasicasVidaDisc,
    String? valCargaCuidadorDisc,
    String? idIdioma,
    String? idLenguaNativa,
    String? correo,
    String? facebookMessenger,
    String? telefonoFamiliar,
    String? recreacionDomicilio,
    String? recreacionCasaAmigos,
    String? recreacionParque,
    String? recreacionFinca,
    String? recreacionPlaya,
    String? recreacionMontania,
    String? idComunicaEntorno,
    String? comunicaEntornoOtros,
    String? idIEss,
    String? idIEssCampesino,
    String? idISsfa,
    String? idISspol,
    String? idPrivado,
    String? idNinguno,
    String? idServMies,
    String? idServGad,
    String? idServIglesia,
    String? idServFundacion,
    String? idServPrivado,
    String? idServNinguno,
    String? idServOtro,
    String? servOtroCual,
    String? idNoTiempo,
    String? idDistante,
    String? idNoDinero,
    String? idMalasReferencias,
    String? idOtroNoAsiste,
    String? otroNoAsisteCual,
    String? idDondeDormir,
    String? idNecesitoAlimentacion,
    String? idProteccionViolenciaIntra,
    String? idDesarrolloHabilidades,
    String? idNecesitaOtro,
    String? otroNecesitaCual,
  }) {
    return VulnerabilidadPerDiscapacidadDb(
      idVulPerDiscapacidad: idVulPerDiscapacidad,
      idRespondeEncuesta: idRespondeEncuesta ?? this.idRespondeEncuesta,
      idServMdh: idServMdh ?? this.idServMdh,
      especifRespondeEnc: especifRespondeEnc ?? this.especifRespondeEnc,
      viveSolo: viveSolo ?? this.viveSolo,
      vivePadres: vivePadres ?? this.vivePadres,
      viveSoloPadreOMadre: viveSoloPadreOMadre ?? this.viveSoloPadreOMadre,
      viveConyuge: viveConyuge ?? this.viveConyuge,
      viveHijos: viveHijos ?? this.viveHijos,
      viveHermanos: viveHermanos ?? this.viveHermanos,
      viveNietos: viveNietos ?? this.viveNietos,
      viveOtrosFamil: viveOtrosFamil ?? this.viveOtrosFamil,
      vivePerServDomestico: vivePerServDomestico ?? this.vivePerServDomestico,
      viveOtrosNoFamiliares: viveOtrosNoFamiliares ?? this.viveOtrosNoFamiliares,
      idContactoFamiliares: idContactoFamiliares ?? this.idContactoFamiliares,
      contactoPadres: contactoPadres ?? this.contactoPadres,
      contactoHijo: contactoHijo ?? this.contactoHijo,
      contactoHermano: contactoHermano ?? this.contactoHermano,
      contactoNieto: contactoNieto ?? this.contactoNieto,
      contactoOtrosFamiliares: contactoOtrosFamiliares ?? this.contactoOtrosFamiliares,
      contactoOtrosNoFamiliares: contactoOtrosNoFamiliares ?? this.contactoOtrosNoFamiliares,
      idTipoDocumento: idTipoDocumento ?? this.idTipoDocumento,
      nroDocumento: nroDocumento ?? this.nroDocumento,
      nombresApellidos: nombresApellidos ?? this.nombresApellidos,
      idNacionalidad: idNacionalidad ?? this.idNacionalidad,
      otraNacionalidad: otraNacionalidad ?? this.otraNacionalidad,
      idSexo: idSexo ?? this.idSexo,
      idEstadoCivil: idEstadoCivil ?? this.idEstadoCivil,
      idProvincia: idProvincia ?? this.idProvincia,
      idCanton: idCanton ?? this.idCanton,
      idParroquia: idParroquia ?? this.idParroquia,
      idZona: idZona ?? this.idZona,
      idDistrito: idDistrito ?? this.idDistrito,
      callePrincipal: callePrincipal ?? this.callePrincipal,
      calleSecundaria: calleSecundaria ?? this.calleSecundaria,
      referenciaUbicVi: referenciaUbicVi ?? this.referenciaUbicVi,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      edad: edad ?? this.edad,
      idTipoDiscapacidad: idTipoDiscapacidad ?? this.idTipoDiscapacidad,
      porcentajeDiscapacidad: porcentajeDiscapacidad ?? this.porcentajeDiscapacidad,
      idTieneCarnetDiscapadidad: idTieneCarnetDiscapadidad ?? this.idTieneCarnetDiscapadidad,
      numCarnetDiscapacidad: numCarnetDiscapacidad ?? this.numCarnetDiscapacidad,
      idPerDiscEmbarazada: idPerDiscEmbarazada ?? this.idPerDiscEmbarazada,
      mesesGestacion: mesesGestacion ?? this.mesesGestacion,
      idEtnia: idEtnia ?? this.idEtnia,
      idEtniaIndigena: idEtniaIndigena ?? this.idEtniaIndigena,
      idInstruccion: idInstruccion ?? this.idInstruccion,
      idGrado: idGrado ?? this.idGrado,
      idFrecuenciaContacComunidad: idFrecuenciaContacComunidad ?? this.idFrecuenciaContacComunidad,
      idFrecuenciaActividadesRecre: idFrecuenciaActividadesRecre ?? this.idFrecuenciaActividadesRecre,
      servSalud: servSalud ?? this.servSalud,
      servEducacion: servEducacion ?? this.servEducacion,
      servInclusionSocial: servInclusionSocial ?? this.servInclusionSocial,
      servDeporte: servDeporte ?? this.servDeporte,
      servCultura: servCultura ?? this.servCultura,
      servTransporte: servTransporte ?? this.servTransporte,
      servNinguno: servNinguno ?? this.servNinguno,
      idUserRegistra: idUserRegistra ?? this.idUserRegistra,
      fechaMovil: fechaMovil ?? this.fechaMovil,
      valEstructuraFamiliar: valEstructuraFamiliar ?? this.valEstructuraFamiliar,
      valLenguaPerDisc: valLenguaPerDisc ?? this.valLenguaPerDisc,
      valIndiceBarthelDisc: valIndiceBarthelDisc ?? this.valIndiceBarthelDisc,
      valActBasicasVidaDisc: valActBasicasVidaDisc ?? this.valActBasicasVidaDisc,
      valCargaCuidadorDisc: valCargaCuidadorDisc ?? this.valCargaCuidadorDisc,
      idIdioma: idIdioma ?? this.idIdioma,
      idLenguaNativa: idLenguaNativa ?? this.idLenguaNativa,
      correo: correo ?? this.correo,
      facebookMessenger: facebookMessenger ?? this.facebookMessenger,
      telefonoFamiliar: telefonoFamiliar ?? this.telefonoFamiliar,
      recreacionDomicilio: recreacionDomicilio ?? this.recreacionDomicilio,
      recreacionCasaAmigos: recreacionCasaAmigos ?? this.recreacionCasaAmigos,
      recreacionParque: recreacionParque ?? this.recreacionParque,
      recreacionFinca: recreacionFinca ?? this.recreacionFinca,
      recreacionPlaya: recreacionPlaya ?? this.recreacionPlaya,
      recreacionMontania: recreacionMontania ?? this.recreacionMontania,
      idComunicaEntorno: idComunicaEntorno ?? this.idComunicaEntorno,
      comunicaEntornoOtros: comunicaEntornoOtros ?? this.comunicaEntornoOtros,
      idIEss: idIEss ?? this.idIEss,
      idIEssCampesino: idIEssCampesino ?? this.idIEssCampesino,
      idISsfa: idISsfa ?? this.idISsfa,
      idISspol: idISspol ?? this.idISspol,
      idPrivado: idPrivado ?? this.idPrivado,
      idNinguno: idNinguno ?? this.idNinguno,
      idServMies: idServMies ?? this.idServMies,
      idServGad: idServGad ?? this.idServGad,
      idServIglesia: idServIglesia ?? this.idServIglesia,
      idServFundacion: idServFundacion ?? this.idServFundacion,
      idServPrivado: idServPrivado ?? this.idServPrivado,
      idServNinguno: idServNinguno ?? this.idServNinguno,
      idServOtro: idServOtro ?? this.idServOtro,
      servOtroCual: servOtroCual ?? this.servOtroCual,
      idNoTiempo: idNoTiempo ?? this.idNoTiempo,
      idDistante: idDistante ?? this.idDistante,
      idNoDinero: idNoDinero ?? this.idNoDinero,
      idMalasReferencias: idMalasReferencias ?? this.idMalasReferencias,
      idOtroNoAsiste: idOtroNoAsiste ?? this.idOtroNoAsiste,
      otroNoAsisteCual: otroNoAsisteCual ?? this.otroNoAsisteCual,
      idDondeDormir: idDondeDormir ?? this.idDondeDormir,
      idNecesitoAlimentacion: idNecesitoAlimentacion ?? this.idNecesitoAlimentacion,
      idProteccionViolenciaIntra: idProteccionViolenciaIntra ?? this.idProteccionViolenciaIntra,
      idDesarrolloHabilidades: idDesarrolloHabilidades ?? this.idDesarrolloHabilidades,
      idNecesitaOtro: idNecesitaOtro ?? this.idNecesitaOtro,
      otroNecesitaCual: otroNecesitaCual ?? this.otroNecesitaCual,
    );
  }

  Map<String, dynamic> toJson() => {
    'idVulPerDiscapacidad': idVulPerDiscapacidad,
    'idRespondeEncuesta': idRespondeEncuesta,
    'idServMdh': idServMdh,
    'especifRespondeEnc': especifRespondeEnc,
    'viveSolo': viveSolo,
    'vivePadres': vivePadres,
    'viveSoloPadreOMadre': viveSoloPadreOMadre,
    'viveConyuge': viveConyuge,
    'viveHijos': viveHijos,
    'viveHermanos': viveHermanos,
    'viveNietos': viveNietos,
    'viveOtrosFamil': viveOtrosFamil,
    'vivePerServDomestico': vivePerServDomestico,
    'viveOtrosNoFamiliares': viveOtrosNoFamiliares,
    'idContactoFamiliares': idContactoFamiliares,
    'contactoPadres': contactoPadres,
    'contactoHijo': contactoHijo,
    'contactoHermano': contactoHermano,
    'contactoNieto': contactoNieto,
    'contactoOtrosFamiliares': contactoOtrosFamiliares,
    'contactoOtrosNoFamiliares': contactoOtrosNoFamiliares,
    'idTipoDocumento': idTipoDocumento,
    'nroDocumento': nroDocumento,
    'nombresApellidos': nombresApellidos,
    'idNacionalidad': idNacionalidad,
    'otraNacionalidad': otraNacionalidad,
    'idSexo': idSexo,
    'idEstadoCivil': idEstadoCivil,
    'idProvincia': idProvincia,
    'idCanton': idCanton,
    'idParroquia': idParroquia,
    'idZona': idZona,
    'idDistrito': idDistrito,
    'callePrincipal': callePrincipal,
    'calleSecundaria': calleSecundaria,
    'referenciaUbicVi': referenciaUbicVi,
    'telefono': telefono,
    'celular': celular,
    'fechaNacimiento': fechaNacimiento,
    'edad': edad,
    'idTipoDiscapacidad': idTipoDiscapacidad,
    'porcentajeDiscapacidad': porcentajeDiscapacidad,
    'idTieneCarnetDiscapadidad': idTieneCarnetDiscapadidad,
    'numCarnetDiscapacidad': numCarnetDiscapacidad,
    'idPerDiscEmbarazada': idPerDiscEmbarazada,
    'mesesGestacion': mesesGestacion,
    'idEtnia': idEtnia,
    'idEtniaIndigena': idEtniaIndigena,
    'idInstruccion': idInstruccion,
    'idGrado': idGrado,
    'idFrecuenciaContacComunidad': idFrecuenciaContacComunidad,
    'idFrecuenciaActividadesRecre': idFrecuenciaActividadesRecre,
    'servSalud': servSalud,
    'servEducacion': servEducacion,
    'servInclusionSocial': servInclusionSocial,
    'servDeporte': servDeporte,
    'servCultura': servCultura,
    'servTransporte': servTransporte,
    'servNinguno': servNinguno,
    'idUserRegistra': idUserRegistra,
    'fechaMovil': fechaMovil,
    'valEstructuraFamiliar': valEstructuraFamiliar,
    'valLenguaPerDisc': valLenguaPerDisc,
    'valIndiceBarthelDisc': valIndiceBarthelDisc,
    'valActBasicasVidaDisc': valActBasicasVidaDisc,
    'valCargaCuidadorDisc': valCargaCuidadorDisc,
    'idIdioma': idIdioma,
    'idLenguaNativa': idLenguaNativa,
    'correo': correo,
    'facebookMessenger': facebookMessenger,
    'telefonoFamiliar': telefonoFamiliar,
    'recreacionDomicilio': recreacionDomicilio,
    'recreacionCasaAmigos': recreacionCasaAmigos,
    'recreacionParque': recreacionParque,
    'recreacionFinca': recreacionFinca,
    'recreacionPlaya': recreacionPlaya,
    'recreacionMontania': recreacionMontania,
    'idComunicaEntorno': idComunicaEntorno,
    'comunicaEntornoOtros': comunicaEntornoOtros,
    'idIEss': idIEss,
    'idIEssCampesino': idIEssCampesino,
    'idISsfa': idISsfa,
    'idISspol': idISspol,
    'idPrivado': idPrivado,
    'idNinguno': idNinguno,
    'idServMies': idServMies,
    'idServGad': idServGad,
    'idServIglesia': idServIglesia,
    'idServFundacion': idServFundacion,
    'idServPrivado': idServPrivado,
    'idServNinguno': idServNinguno,
    'idServOtro': idServOtro,
    'servOtroCual': servOtroCual,
    'idNoTiempo': idNoTiempo,
    'idDistante': idDistante,
    'idNoDinero': idNoDinero,
    'idMalasReferencias': idMalasReferencias,
    'idOtroNoAsiste': idOtroNoAsiste,
    'otroNoAsisteCual': otroNoAsisteCual,
    'idDondeDormir': idDondeDormir,
    'idNecesitoAlimentacion': idNecesitoAlimentacion,
    'idProteccionViolenciaIntra': idProteccionViolenciaIntra,
    'idDesarrolloHabilidades': idDesarrolloHabilidades,
    'idNecesitaOtro': idNecesitaOtro,
    'otroNecesitaCual': otroNecesitaCual,
  };

  static VulnerabilidadPerDiscapacidadDb fromJson(Map<String, dynamic> json) {
    return VulnerabilidadPerDiscapacidadDb(
      idVulPerDiscapacidad: (json['idVulPerDiscapacidad'] as String?) ?? const Uuid().v4(),
      idRespondeEncuesta: json['idRespondeEncuesta'] as String?,
      idServMdh: json['idServMdh'] as String?,
      especifRespondeEnc: json['especifRespondeEnc'] as String?,
      viveSolo: json['viveSolo'] as String?,
      vivePadres: json['vivePadres'] as String?,
      viveSoloPadreOMadre: json['viveSoloPadreOMadre'] as String?,
      viveConyuge: json['viveConyuge'] as String?,
      viveHijos: json['viveHijos'] as String?,
      viveHermanos: json['viveHermanos'] as String?,
      viveNietos: json['viveNietos'] as String?,
      viveOtrosFamil: json['viveOtrosFamil'] as String?,
      vivePerServDomestico: json['vivePerServDomestico'] as String?,
      viveOtrosNoFamiliares: json['viveOtrosNoFamiliares'] as String?,
      idContactoFamiliares: json['idContactoFamiliares'] as String?,
      contactoPadres: json['contactoPadres'] as String?,
      contactoHijo: json['contactoHijo'] as String?,
      contactoHermano: json['contactoHermano'] as String?,
      contactoNieto: json['contactoNieto'] as String?,
      contactoOtrosFamiliares: json['contactoOtrosFamiliares'] as String?,
      contactoOtrosNoFamiliares: json['contactoOtrosNoFamiliares'] as String?,
      idTipoDocumento: json['idTipoDocumento'] as String?,
      nroDocumento: json['nroDocumento'] as String?,
      nombresApellidos: json['nombresApellidos'] as String?,
      idNacionalidad: json['idNacionalidad'] as String?,
      otraNacionalidad: json['otraNacionalidad'] as String?,
      idSexo: json['idSexo'] as String?,
      idEstadoCivil: json['idEstadoCivil'] as String?,
      idProvincia: json['idProvincia'] as String?,
      idCanton: json['idCanton'] as String?,
      idParroquia: json['idParroquia'] as String?,
      idZona: json['idZona'] as String?,
      idDistrito: json['idDistrito'] as String?,
      callePrincipal: json['callePrincipal'] as String?,
      calleSecundaria: json['calleSecundaria'] as String?,
      referenciaUbicVi: json['referenciaUbicVi'] as String?,
      telefono: json['telefono'] as String?,
      celular: json['celular'] as String?,
      fechaNacimiento: json['fechaNacimiento'] as String?,
      edad: json['edad'] as String?,
      idTipoDiscapacidad: json['idTipoDiscapacidad'] as String?,
      porcentajeDiscapacidad: json['porcentajeDiscapacidad'] as String?,
      idTieneCarnetDiscapadidad: json['idTieneCarnetDiscapadidad'] as String?,
      numCarnetDiscapacidad: json['numCarnetDiscapacidad'] as String?,
      idPerDiscEmbarazada: json['idPerDiscEmbarazada'] as String?,
      mesesGestacion: json['mesesGestacion'] as String?,
      idEtnia: json['idEtnia'] as String?,
      idEtniaIndigena: json['idEtniaIndigena'] as String?,
      idInstruccion: json['idInstruccion'] as String?,
      idGrado: json['idGrado'] as String?,
      idFrecuenciaContacComunidad: json['idFrecuenciaContacComunidad'] as String?,
      idFrecuenciaActividadesRecre: json['idFrecuenciaActividadesRecre'] as String?,
      servSalud: json['servSalud'] as String?,
      servEducacion: json['servEducacion'] as String?,
      servInclusionSocial: json['servInclusionSocial'] as String?,
      servDeporte: json['servDeporte'] as String?,
      servCultura: json['servCultura'] as String?,
      servTransporte: json['servTransporte'] as String?,
      servNinguno: json['servNinguno'] as String?,
      idUserRegistra: json['idUserRegistra'] as String?,
      fechaMovil: json['fechaMovil'] as String?,
      valEstructuraFamiliar: json['valEstructuraFamiliar'] as String?,
      valLenguaPerDisc: json['valLenguaPerDisc'] as String?,
      valIndiceBarthelDisc: json['valIndiceBarthelDisc'] as String?,
      valActBasicasVidaDisc: json['valActBasicasVidaDisc'] as String?,
      valCargaCuidadorDisc: json['valCargaCuidadorDisc'] as String?,
      idIdioma: json['idIdioma'] as String?,
      idLenguaNativa: json['idLenguaNativa'] as String?,
      correo: json['correo'] as String?,
      facebookMessenger: json['facebookMessenger'] as String?,
      telefonoFamiliar: json['telefonoFamiliar'] as String?,
      recreacionDomicilio: json['recreacionDomicilio'] as String?,
      recreacionCasaAmigos: json['recreacionCasaAmigos'] as String?,
      recreacionParque: json['recreacionParque'] as String?,
      recreacionFinca: json['recreacionFinca'] as String?,
      recreacionPlaya: json['recreacionPlaya'] as String?,
      recreacionMontania: json['recreacionMontania'] as String?,
      idComunicaEntorno: json['idComunicaEntorno'] as String?,
      comunicaEntornoOtros: json['comunicaEntornoOtros'] as String?,
      idIEss: json['idIEss'] as String?,
      idIEssCampesino: json['idIEssCampesino'] as String?,
      idISsfa: json['idISsfa'] as String?,
      idISspol: json['idISspol'] as String?,
      idPrivado: json['idPrivado'] as String?,
      idNinguno: json['idNinguno'] as String?,
      idServMies: json['idServMies'] as String?,
      idServGad: json['idServGad'] as String?,
      idServIglesia: json['idServIglesia'] as String?,
      idServFundacion: json['idServFundacion'] as String?,
      idServPrivado: json['idServPrivado'] as String?,
      idServNinguno: json['idServNinguno'] as String?,
      idServOtro: json['idServOtro'] as String?,
      servOtroCual: json['servOtroCual'] as String?,
      idNoTiempo: json['idNoTiempo'] as String?,
      idDistante: json['idDistante'] as String?,
      idNoDinero: json['idNoDinero'] as String?,
      idMalasReferencias: json['idMalasReferencias'] as String?,
      idOtroNoAsiste: json['idOtroNoAsiste'] as String?,
      otroNoAsisteCual: json['otroNoAsisteCual'] as String?,
      idDondeDormir: json['idDondeDormir'] as String?,
      idNecesitoAlimentacion: json['idNecesitoAlimentacion'] as String?,
      idProteccionViolenciaIntra: json['idProteccionViolenciaIntra'] as String?,
      idDesarrolloHabilidades: json['idDesarrolloHabilidades'] as String?,
      idNecesitaOtro: json['idNecesitaOtro'] as String?,
      otroNecesitaCual: json['otroNecesitaCual'] as String?,
    );
  }
}
