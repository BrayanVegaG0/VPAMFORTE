import '../../../models/db/ficha_adulto_mayor_disc_db.dart';

class FichaSoapSerializer {
  // PKs locales (UUID) que JAMÁS deben llegar como UUID al backend en INSERT.
  // En su lugar: 0.
  static const Set<String> _pkTags = {
    'idVulPerDiscapacidad',
    'idVulViviendaDisc',
    'idFamFactoresRiesgos',
    'idIngGastosDisc',
    'idSaludDisc',
    'idFichaPam',
    'idIndiceBarthelDisc',
    'idLawtonBrody',
    'idMinimentalPam',
    'idYesavagePam',
    // agrega aquí cualquier otro id* que sea PK de entidad
  };

  String buildEnvelope(FichaAdultoMayorDiscDb ficha) {
    final parts = <String>[
      _vulnerabilidadPerDiscapacidad(ficha),
      _familiasFactoresRiesgo(ficha),
      _vulnerabilidadViviendaDisc(ficha),
      _ingresosGastosDisc(ficha),
      _saludDisc(ficha),
      _fichaPam(ficha),
      _indiceBarthel(ficha),
      _lawtonBrody(ficha),
      _minimentalPam(ficha),
      _yesavagePam(ficha),
    ].where((x) => x.trim().isNotEmpty).join('\n');

    return '''
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:ns1="http://impl.service.siimies.web.ficha.vulnerabilidad/">
  <soapenv:Header/>
  <soapenv:Body>
    <ns1:insertFichaAdultoMayorDisc>
      $parts
    </ns1:insertFichaAdultoMayorDisc>
  </soapenv:Body>
</soapenv:Envelope>
''';
  }

  // -------------------------
  // 1) VulnerabilidadPerDiscapacidad
  // -------------------------
  String _vulnerabilidadPerDiscapacidad(FichaAdultoMayorDiscDb f) {
    final v = f.vulnerabilidadPerDiscapacidad;

    final inner = [
      // PK FORZADA A 0
      _t('idVulPerDiscapacidad', v.idVulPerDiscapacidad),

      // campos de negocio (los tuyos)
      _t('idRespondeEncuesta', v.idRespondeEncuesta),
      //_t('idServMies', v.idServMies),
      _t('especifRespondeEnc', v.especifRespondeEnc),
      _t('idTipoDocumento', v.idTipoDocumento),
      _t('nroDocumento', v.nroDocumento),
      _t('nombresApellidos', v.nombresApellidos),
      _t('fechaNacimiento', v.fechaNacimiento),
      _t('idNacionalidad', v.idNacionalidad),
      _t('otraNacionalidad', v.otraNacionalidad),
      _t('idSexo', v.idSexo),
      _t('idEstadoCivil', v.idEstadoCivil),
      _t('idProvincia', v.idProvincia),
      _t('idCanton', v.idCanton),
      _t('idParroquia', v.idParroquia),
      _t('callePrincipal', v.callePrincipal),
      _t('calleSecundaria', v.calleSecundaria),
      _t('referenciaUbicVi', v.referenciaUbicVi),
      _t('telefono', v.telefono),
      _t('celular', v.celular),
      _t('correo', v.correo),
      _t('facebookMessenger', v.facebookMessenger),
      _t('telefonoFamiliar', v.telefonoFamiliar),

      _t('viveSolo', v.viveSolo),

      _t('idContactoFamiliares', v.idContactoFamiliares),
      _t('contactoPadres', v.contactoPadres),
      _t('contactoHijo', v.contactoHijo),
      _t('contactoHermano', v.contactoHermano),
      _t('contactoNieto', v.contactoNieto),
      _t('contactoOtrosFamiliares', v.contactoOtrosFamiliares),
      _t('contactoOtrosNoFamiliares', v.contactoOtrosNoFamiliares),

      _t('idFrecuenciaActividadesRecre', v.idFrecuenciaActividadesRecre),
      _t('recreacionDomicilio', v.recreacionDomicilio),
      _t('recreacionCasaAmigos', v.recreacionCasaAmigos),
      _t('recreacionParque', v.recreacionParque),
      _t('recreacionFinca', v.recreacionFinca),
      _t('recreacionPlaya', v.recreacionPlaya),
      _t('recreacionMontaña', v.recreacionMontania),

      _t('idComunicaEntorno', v.idComunicaEntorno),
      _t('comunicaEntornoOtros', v.comunicaEntornoOtros),

      _t('idIEss', v.idIEss),
      _t('idISsfa', v.idISsfa),
      _t('idISspol', v.idISspol),
      _t('idPrivado', v.idPrivado),
      _t('idIEssCampesino', v.idIEssCampesino),
      _t('idNinguno', v.idNinguno),

      _t('idServMies', v.idServMies),
      _t('idServGad', v.idServGad),
      _t('idServIglesia', v.idServIglesia),
      _t('idServFundacion', v.idServFundacion),
      _t('idServPrivado', v.idServPrivado),
      _t('idServOtro', v.idServOtro),
      _t('idServNinguno', v.idServNinguno),
      _t('servOtroCual', v.servOtroCual),

      _t('idNoTiempo', v.idNoTiempo),
      _t('idDistante', v.idDistante),
      _t('idNoDinero', v.idNoDinero),
      _t('idMalasReferencias', v.idMalasReferencias),
      _t('idOtroNoAsiste', v.idOtroNoAsiste),
      _t('otroNoAsisteCual', v.otroNoAsisteCual),

      _t('idDondeDormir', v.idDondeDormir),
      _t('idNecesitoAlimentacion', v.idNecesitoAlimentacion),
      _t('idProteccionViolenciaIntra', v.idProteccionViolenciaIntra),
      _t('idDesarrolloHabilidades', v.idDesarrolloHabilidades),
      _t('idNecesitaOtro', v.idNecesitaOtro),
      _t('otroNecesitaCual', v.otroNecesitaCual),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('vulnerabilidadPerDiscapacidad', inner);
  }

  // -------------------------
  // 2) FamiliasFactoresRiesgo
  // -------------------------
  String _familiasFactoresRiesgo(FichaAdultoMayorDiscDb f) {
    final x = f.familiasFactoresRiesgo;

    final inner = [
      _t('idFamFactoresRiesgos', x.idFamFactoresRiesgos),

      _t('idJefatura', x.idJefatura),
      _t('idNnaSeparado', x.idNnaSeparado),
      _t('idNecesidadPedirDinero', x.idNecesidadPedirDinero),

      _t('idFrecuenciaAlcohol', x.idFrecuenciaAlcohol),
      _t('idFrecuenciaTabaco', x.idFrecuenciaTabaco),
      _t('idFrecuenciaDrogasIlegales', x.idFrecuenciaDrogasIlegales),

      _t('idFamPrivLibertad', x.idFamPrivLibertad),
      _t('idFamRelaPrivLib', x.idFamRelaPrivLib),
      _t('idFamTipoPrivLib', x.idFamTipoPrivLib),
      _t('idTieneSentencia', x.idTieneSentencia),

      _t('idFamDesa', x.idFamDesa),
      _t('famDesaParentesco', x.famDesaParentesco),
      _t('famDesaTiempo', x.famDesaTiempo),

      _t('idTrabaFuera', x.idTrabaFuera),
      _t('trabaFueraDonde', x.trabaFueraDonde),

      _t('idFamEsOtroPais', x.idFamEsOtroPais),
      _t('idTiempoIngreso', x.idTiempoIngreso),
      _t('famEsOtroPaisDonde', x.famEsOtroPaisDonde),
      _t('idTieneVisadoEcuat', x.idTieneVisadoEcuat),
      _t('numVisadoEcuat', x.numVisadoEcuat),

      _t('idAma', x.idAma),
      _t('idAmaPregUno', x.idAmaPregUno),
      _t('idAmaPregDos', x.idAmaPregDos),
      _t('idAmaPregTres', x.idAmaPregTres),
      _t('idAmaPregCuatro', x.idAmaPregCuatro),
      _t('idAmaPregCinco', x.idAmaPregCinco),
      _t('idAmaPregSeis', x.idAmaPregSeis),
      _t('idAmaPregSiete', x.idAmaPregSiete),
      _t('idAmaPregOcho', x.idAmaPregOcho),
      _t('idAmaPregNueve', x.idAmaPregNueve),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('familiasFactoresRiesgo', inner);
  }

  // -------------------------
  // 3) VulnerabilidadViviendaDisc
  // -------------------------
  String _vulnerabilidadViviendaDisc(FichaAdultoMayorDiscDb f) {
    final v = f.vulnerabilidadViviendaDisc;

    final inner = [
      _t('idVulViviendaDisc', v.idVulViviendaDisc),
      _t('cuen', v.cuen),

      _t('numCuartosDisponeVivienda', v.idNumCuartos),
      _t('idCuartoExclDormir', v.idCuartoExclDormir),
      _t('numCuartorDormir', v.idNumCuartorDormir),
      _t('idLugarDuerme', v.idLugarDuerme),

      _t('idEnergiaElectrica', v.idEnergiaElectrica),
      _t('idAguaPotable', v.idAguaPotable),
      _t('idAlcantarillado', v.idAlcantarillado),
      _t('idRecoleccionBasura', v.idRecoleccionBasura),
      _t('idInternet', v.idInternet),

      _t('idTiempoLlegarServMies', v.idTiempoLlegarServMies),
      _t('idTransporteLlegada', v.idTransporteLlegada),

      _t('idDeslizamientoTierra', v.idDeslizamientoTierra),
      _t('idInundaciones', v.idInundaciones),
      _t('idSequia', v.idSequia),
      _t('idMareTerremotoTsunami', v.idMareTerremotoTsunami),
      _t('idActVolcanicas', v.idActVolcanicas),
      _t('idIncendiosForestales', v.idIncendiosForestales),
      _t('idContIndusMinerPetroleo', v.idContIndusMinerPetroleo),
      _t('idExplosionGasGasolina', v.idExplosionGasGasolina),

      _t('idBares', v.idBares),
      _t('idDiscotecas', v.idDiscotecas),
      _t('idCantinas', v.idCantinas),
      _t('idBurdeles', v.idBurdeles),

      _t('idViveCueva', v.idViveCueva),
      _t('idViveCalle', v.idViveCalle),
      _t('idViveAlbergue', v.idViveAlbergue),
      _t('idViveHosHotMotel', v.idViveHosHotMotel),
      _t('idViveCovacha', v.idViveCovacha),
      _t('idViveChoza', v.idViveChoza),
      _t('idViveMediagua', v.idViveMediagua),
      _t('idViveCuartos', v.idViveCuartos),
      _t('idViveOtrosLugarPerma', v.idViveOtrosLugarPerma),
      _t('viveOtrosLugarPermaCual', v.viveOtrosLugarPermaCual),
      _t('idViveMasSeisMeses', v.idViveMasSeisMeses),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('vulnerabilidadViviendaDisc', inner);
  }

  // -------------------------
  // 4) IngGastosDisc
  // -------------------------
  String _ingresosGastosDisc(FichaAdultoMayorDiscDb f) {
    final i = f.ingGastosDisc;

    final inner = [
      _t('idIngGastosDisc', i.idIngGastosDisc),
      _t('fuenteTrabajoDependencia', i.fuenteTrabajoDependencia),
      _t('fuenteTrabajoPropio', i.fuenteTrabajoPropio),
      _t('pensionJubilacion', i.pensionJubilacion),
      _t('remesasNacInt', i.remesasNacInt),
      _t('pensionAlimenticia', i.pensionAlimenticia),
      _t('fuenteMontepio', i.fuenteMontepio),
      _t('truequePartir', i.truequePartir),
      _t('fuenteOtros', i.fuenteOtros),
      _t('especifOtroTipoIngreso', i.especifOtroTipoIngreso),
      _t('ingresos', i.ingresos),
      _t('apoyoEconomico', i.apoyoEconomico),
      _t('bonoJoaquinGl', i.bonoJoaquinGL),
      _t('bonoVariable', i.bonoVariable),
      _t('bonoMejoresAnios', i.bonoMejoresAnios),
      _t('bonoDesaHumano', i.bonoDesaHumano),
      _t('pensionAm', i.pensionAm),
      _t('pensionPcd', i.pensionPcd),
      _t('pensionTodaVida', i.pensionTodaVida),
      _t('coberturaContin', i.coberturaContin),
      _t('bonoOrfandad', i.bonoOrfandad),
      _t('idBonoOtro', i.idBonoOtro),
      _t('bonoOtro', i.bonoOtro),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('ingresosGastosDisc', inner);
  }

  // -------------------------
  // 5) SaludDisc
  // -------------------------
  String _saludDisc(FichaAdultoMayorDiscDb f) {
    final s = f.saludDisc;

    final inner = [
      _t('idSaludDisc', s.idSaludDisc),
      _t('idAyudaOrgPriv', s.idAyudaOrgPriv),
      //_t('cualOrgPriv', s.cualOrgPriv),
      _t('idNnDesnutricion', s.idNnDesnutricion),
      _t('idFamHospitalizado', s.idFamHospitalizado),
      _t('idFrecuenciaAtencion', s.idFrecuenciaAtencion),

      _t('idOxigenoUtiliza', s.idOxigenoUtiliza),
      _t('idSillaRuedasUtiliza', s.idSillaRuedasUtiliza),
      _t('idAndadorUtiliza', s.idAndadorUtiliza),
      _t('idMuletasUtiliza', s.idMuletasUtiliza),
      _t('idBastonUtiliza', s.idBastonUtiliza),
      _t('idFerulasPiesUtiliza', s.idFerulasPiesUtiliza),
      _t('idProtesisUtiliza', s.idProtesisUtiliza),
      _t('idAudifonosUtiliza', s.idAudifonosUtiliza),
      _t('idOtrosAyudaTecUtiliza', s.idOtrosAyudaTecUtiliza),
      _t('especifOtraAyudaTecUtiliza', s.especifOtraAyudaTecUtiliza),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('saludDisc', inner);
  }

  // -------------------------
  // 6) FichaPamDb
  // -------------------------
  String _fichaPam(FichaAdultoMayorDiscDb f) {
    final p = f.fichaPam;

    final inner = [
      _t('idFichaPam', p.idFichaPam),
      _t('fechaNacimiento', p.fechaNacimiento),
      _t('idCedConDiscapacidad', p.idCedConDiscapacidad),
      _t('numeroCedula', p.numeroCedula),
      _t('porcentajeDiscapacidad', p.porcentajeDiscapacidad),
      _t('idEtnia', p.idEtnia),
      _t('idEtniaIndigena', p.idEtniaIndigena),
      _t('idIdioma', p.idIdioma),
      _t('idLenguaNativa', p.idLenguaNativa),
      _t('idInstruccion', p.idInstruccion),
      _t('idGrado', p.idGrado),
      _t('idTrabaja', p.idTrabaja),
      _t('idOcupacionLaboral', p.idOcupacionLaboral),
      _t('otroOcupacionLaboral', p.otroOcupacionLaboral),
      _t('diasTrabajaSemana', p.diasTrabajaSemana),
      _t('horasTrabajaDia', p.horasTrabajaDia),
      _t('idRazonTrabaja', p.idRazonTrabaja),
      _t('otroRazonTrabaja', p.otroRazonTrabaja),
      _t('idGastoVestimentaPam', p.idGastoVestimentaPam),
      _t('valorVestimentaPam', p.valorVestimentaPam),
      _t('idGastoSaludPam', p.idGastoSaludPam),
      _t('valorGastoSaludPam', p.valorGastoSaludPam),
      _t('idAlimentacionPam', p.idAlimentacionPam),
      _t('valorAlimentacionPam', p.valorAlimentacionPam),
      _t('idGastoAyudasTecnicasPam', p.idGastoAyudasTecnicasPam),
      _t('valorAyudaTecnicasPam', p.valorAyudaTecnicasPam),
      _t('idRequiereCuidados', p.idRequiereCuidados),
      _t('idCuentaPersonaCuide', p.idCuentaPersonaCuide),
      _t('idQuienCuidadosDomicilio', p.idQuienCuidadosDomicilio),
      _t('otrosQuienCuidadosDom', p.otrosQuienCuidadosDom),
      _t('idAyudaFamDinero', p.idAyudaFamDinero),
      _t('idAyudaFamComida', p.idAyudaFamComida),
      _t('idAyudaFamRopa', p.idAyudaFamRopa),
      _t('idAyudaFamQuehaceres', p.idAyudaFamQuehaceres),
      _t('idAyudaFamCuidadoPersonal', p.idAyudaFamCuidadoPersonal),
      _t('idAyudaFamTransporte', p.idAyudaFamTransporte),
      _t('idAyudaFamEntretenimiento', p.idAyudaFamEntretenimiento),
      _t('idAyudaFamCompania', p.idAyudaFamCompania),
      _t('idAyudaFamNinguna', p.idAyudaFamNinguna),
      _t('idAyudaFamOtro', p.idAyudaFamOtro),
      _t('cualAyudaFamOtro', p.cualAyudaFamOtro),
      _t('idFrecuenciaAyudaFam', p.idFrecuenciaAyudaFam),
      _t('idPamCuidaPersonas', p.idPamCuidaPersonas),
      _t('cuantosNnPamCuida', p.cuantosNnPamCuida),
      _t('cuantosAdolescentesPamCuida', p.cuantosAdolescentesPamCuida),
      _t('cuantosPcdPamCuida', p.cuantosPcdPamCuida),
      _t('cuantosPamCuida', p.cuantosPamCuida),
      _t('cuantosOtrosPamCuida', p.cuantosOtrosPamCuida),
      _t('cualesOtrosPamCuida', p.cualesOtrosPamCuida),
      _t('cuantosMedicamentosUtilizaPam', p.cuantosMedicamentosUtilizaPam),
      _t('cuantasVecesCaidoPamSeisMeses', p.cuantasVecesCaidoPamSeisMeses),
      _t('idProblemasDientesPamDoceMeses', p.idProblemasDientesPamDoceMeses),
      _t('idComeTresComidasDiarias', p.idComeTresComidasDiarias),
      _t('idSindromeGolondrina', p.idSindromeGolondrina),
      _t('numDomiciliosRota', p.numDomiciliosRota),
      _t('tiempoPasaCadaDomicilio', p.tiempoPasaCadaDomicilio),
      _t('idEnfermedadNeurodegenerativa', p.idEnfermedadNeurodegenerativa),
      _t('cualEnfermedadNeurodegenerativa', p.cualEnfermedadNeurodegenerativa),
      _t(
        'otrosCualEnfermedadNeurodegenerativa',
        p.otrosCualEnfermedadNeurodegenerativa,
      ),
      _t('idViviendaAccesibilidad', p.idViviendaAccesibilidad),
      _t('accesRampas', p.accesRampas),
      _t('accesPasamanos', p.accesPasamanos),
      _t('accesManija', p.accesManija),
      _t('accesAgarradera', p.accesAgarradera),
      _t('accesVentilacion', p.accesVentilacion),
      _t('accesIluminacion', p.accesIluminacion),
      _t('accesTrasladoFacil', p.accesTrasladoFacil),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('fichaPam', inner);
  }

  // -------------------------
  // 7) IndiceBarthelDisc
  // -------------------------
  String _indiceBarthel(FichaAdultoMayorDiscDb f) {
    final x = f.indiceBarthel;

    final inner = [
      _t('idIndiceBarthelDisc', x.idIndiceBarthelDisc),
      _t('idComer', x.idComer),
      _t('idTrasladoSillaCama', x.idTrasladoSillaCama),
      _t('idAseoPersonal', x.idAseoPersonal),
      _t('idUsoRetrete', x.idUsoRetrete),
      _t('idBaniarse', x.idBaniarse),
      _t('idDesplazarse', x.idDesplazarse),
      _t('idSubirBajarEscaleras', x.idSubirBajarEscaleras),
      _t('idVestirseDesvestirse', x.idVestirseDesvestirse),
      _t('idControlHeces', x.idControlHeces),
      _t('idControlOrina', x.idControlOrina),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('indiceBarthelDisc', inner);
  }

  // -------------------------
  // 8) LawtonBrody
  // -------------------------
  String _lawtonBrody(FichaAdultoMayorDiscDb f) {
    final x = f.lawtonBrody;

    final inner = [
      _t('idLawtonBrody', x.idLawtonBrody),
      _t('idCapacidadTelefono', x.idCapacidadTelefono),
      _t('idHacerCompras', x.idHacerCompras),
      _t('idPrepararComida', x.idPrepararComida),
      _t('idCuidadoCasa', x.idCuidadoCasa),
      _t('idLavadoRopa', x.idLavadoRopa),
      _t('idTransporte', x.idTransporte),
      _t('idMedicacion', x.idMedicacion),
      _t('idUtilizarDinero', x.idUtilizarDinero),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('lawtonBrody', inner);
  }

  // -------------------------
  // 9) MiniMentalPam
  // -------------------------
  String _minimentalPam(FichaAdultoMayorDiscDb f) {
    final x = f.minimentalPam;

    final inner = [
      _t('idMinimentalPam', x.idMinimentalPam),
      _t('idTiempoUno', x.idTiempoUno),
      _t('idTiempoDos', x.idTiempoDos),
      _t('idTiempoTres', x.idTiempoTres),
      _t('idTiempoCuatro', x.idTiempoCuatro),
      _t('idTiempoCinco', x.idTiempoCinco),
      _t('idEspacioUno', x.idEspacioUno),
      _t('idEspacioDos', x.idEspacioDos),
      _t('idEspacioTres', x.idEspacioTres),
      _t('idEspacioCuatro', x.idEspacioCuatro),
      _t('idEspacioCinco', x.idEspacioCinco),
      _t('idMemoriaUno', x.idMemoriaUno),
      _t('idMemoriaDos', x.idMemoriaDos),
      _t('idMemoriaTres', x.idMemoriaTres),
      _t('idCalculoUno', x.idCalculoUno),
      _t('idCalculoDos', x.idCalculoDos),
      _t('idCalculoTres', x.idCalculoTres),
      _t('idCalculoCuatro', x.idCalculoCuatro),
      _t('idCalculoCinco', x.idCalculoCinco),
      _t('idMemoriaDifUno', x.idMemoriaDifUno),
      _t('idMemoriaDifDos', x.idMemoriaDifDos),
      _t('idMemoriaDifTres', x.idMemoriaDifTres),
      _t('idDenominacionUno', x.idDenominacionUno),
      _t('idDenominacionDos', x.idDenominacionDos),
      _t('idRepeticionUno', x.idRepeticionUno),
      _t('idComprensionUno', x.idComprensionUno),
      _t('idComprensionDos', x.idComprensionDos),
      _t('idComprensionTres', x.idComprensionTres),
      _t('idLecturaUno', x.idLecturaUno),
      _t('idEscrituraUno', x.idEscrituraUno),
      _t('idCopiaUno', x.idCopiaUno),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('minimentalPam', inner);
  }

  // -------------------------
  // 10) YesavagePam
  // -------------------------
  String _yesavagePam(FichaAdultoMayorDiscDb f) {
    final x = f.yesavagePam;

    final inner = [
      _t('idYesavagePam', x.idYesavagePam),
      _t('idYesavageUno', x.idYesavageUno),
      _t('idYesavageDos', x.idYesavageDos),
      _t('idYesavageTres', x.idYesavageTres),
      _t('idYesavageCuatro', x.idYesavageCuatro),
      _t('idYesavageCinco', x.idYesavageCinco),
      _t('idYesavageSeis', x.idYesavageSeis),
      _t('idYesavageSiete', x.idYesavageSiete),
      _t('idYesavageOcho', x.idYesavageOcho),
      _t('idYesavageNueve', x.idYesavageNueve),
      _t('idYesavageDiez', x.idYesavageDiez),
      _t('idYesavageOnce', x.idYesavageOnce),
      _t('idYesavageDoce', x.idYesavageDoce),
      _t('idYesavageTrece', x.idYesavageTrece),
      _t('idYesavageCatorce', x.idYesavageCatorce),
      _t('idYesavageQuince', x.idYesavageQuince),
    ].where((e) => e.isNotEmpty).join('\n');

    return _wrapIfHasBusinessFields('yesavagePam', inner);
  }

  // ==========================================================
  // Helpers
  // ==========================================================

  /// Envuelve el bloque solo si hay algo más que “PK=0”.
  String _wrapIfHasBusinessFields(String tag, String inner) {
    final trimmed = inner.trim();
    if (trimmed.isEmpty) return '';

    // si el contenido solo tiene un id en 0 (bloque vacío), no lo mandes
    final lines = trimmed
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final nonPkLines = lines.where((l) {
      // elimina líneas que sean <idX>0</idX>
      final isPk0 = _pkTags.any((pk) => l == '<$pk>0</$pk>');
      return !isPk0;
    }).toList();

    if (nonPkLines.isEmpty) return '';

    return '<$tag>\n$trimmed\n</$tag>';
  }

  String _t(String tag, Object? value) {
    if (value == null) return '';

    // PKs: si vienen con UUID, se fuerzan a 0 en INSERT.
    if (_pkTags.contains(tag)) {
      return '<$tag>0</$tag>';
    }

    final s = value
        .toString()
        .trim()
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');

    if (s.isEmpty) return '';
    return '<$tag>$s</$tag>';
  }
}
