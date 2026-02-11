import 'package:ficha_vulnerabilidad/data/models/db/ing_gastos_disc_db.dart';
import 'package:uuid/uuid.dart';

import '../models/db/ficha_adulto_mayor_disc_db.dart';
import '../models/db/vulnerabilidad_per_discapacidad_db.dart';
import '../models/db/familias_factores_riesgo_db.dart';
import '../models/db/vulnerabilidad_vivienda_disc_db.dart';
import '../models/db/salud_disc_db.dart';
import '../models/db/ficha_pam_db.dart';
import '../models/db/indice_barthel_disc_db.dart';
import '../models/db/lawton_brody_db.dart';
import '../models/db/minimental_pam_db.dart';
import '../models/db/yesavage_pam_db.dart';

import '../models/db/ficha_pcd_db.dart';
import '../models/db/baremo_db.dart';
import '../models/db/carga_cuidador_disc_db.dart';

class SurveyAnswersToFichaDbMapper {
  FichaAdultoMayorDiscDb map(Map<String, dynamic> a) {
    // =========================
    // VulnerabilidadPerDiscapacidadDb
    // =========================
    final per = VulnerabilidadPerDiscapacidadDb(
      idVulPerDiscapacidad: const Uuid().v4(),

      // 1..6 Datos generales
      idRespondeEncuesta: _s(a['idRespondeEncuestaM']),
      idServMdh: _s(a['idServMdh']),
      especifRespondeEnc: _s(a['especifRespondeEncM']),
      idTipoDocumento: _s(a['idTipoDocumentoM']),
      nroDocumento: _s(a['nroDocumentoM']),
      idNacionalidad: _s(a['idNacionalidadM']),
      otraNacionalidad: _s(a['otraNacionalidadM']),
      nombresApellidos: _joinNames(_s(a['Nombres']), _s(a['Apellidos'])),
      fechaNacimiento: _date(a['fechaNacimientoM']),
      idSexo: _s(a['idSexoM']),
      idEstadoCivil: _s(a['idEstadoCivilM']),
      idProvincia: _s(a['idProvinciaM']),
      idCanton: _s(a['idCantonM']),
      idParroquia: _s(a['idParroquiaM']),
      callePrincipal: _s(a['callePrincipalM']),
      calleSecundaria: _s(a['calleSecundariaM']),
      referenciaUbicVi: _s(a['referenciaUbicViM']),
      telefono: _s(a['telefonoM']),
      celular: _s(a['celularM']),
      correo: _s(a['correoM']),
      facebookMessenger: _s(a['facebookMessengerM']),
      telefonoFamiliar: _s(a['telefonoFamiliarM']),
      // 24 vive solo (Switch -> bool en UI; aquí se convierte a "1"/"0")
      viveSolo: _bool01(a['viveSoloM']),
      // 27 contacto (multiChoice)
      idContactoFamiliares: _bool01(a['idContactoFamiliaresM']),
      contactoPadres:
          _s(a['idContactoFamiliaresM']) == '1' &&
              _has(a['contactoFamiliaresM'], '1')
          ? '1'
          : '0',
      contactoHijo:
          _s(a['idContactoFamiliaresM']) == '1' &&
              _has(a['contactoFamiliaresM'], '4')
          ? '1'
          : '0',
      contactoHermano:
          _s(a['idContactoFamiliaresM']) == '1' &&
              _has(a['contactoFamiliaresM'], '5')
          ? '1'
          : '0',
      contactoNieto:
          _s(a['idContactoFamiliaresM']) == '1' &&
              _has(a['contactoFamiliaresM'], '6')
          ? '1'
          : '0',
      contactoOtrosFamiliares:
          _s(a['idContactoFamiliaresM']) == '1' &&
              _has(a['contactoFamiliaresM'], '7')
          ? '1'
          : '0',
      contactoOtrosNoFamiliares:
          _s(a['idContactoFamiliaresM']) == '1' &&
              _has(a['contactoFamiliaresM'], '8')
          ? '1'
          : '0',
      //Otro no familiar cualContactoFamiliaresM
      idFrecuenciaActividadesRecre: _s(a['idFrecuenciaActividadesRecreM']),
      // 31 dónde (multiChoice) – tu visibleIf está mal en Fake (ver nota), pero mapeo correcto:
      recreacionDomicilio: _has(a['dondeFrecuenciaActividadesRecreM'], '1')
          ? '1'
          : '0',
      recreacionCasaAmigos: _has(a['dondeFrecuenciaActividadesRecreM'], '2')
          ? '1'
          : '0',
      recreacionParque: _has(a['dondeFrecuenciaActividadesRecreM'], '3')
          ? '1'
          : '0',
      recreacionFinca: _has(a['dondeFrecuenciaActividadesRecreM'], '4')
          ? '1'
          : '0',
      recreacionPlaya: _has(a['dondeFrecuenciaActividadesRecreM'], '5')
          ? '1'
          : '0',
      recreacionMontania: _has(a['dondeFrecuenciaActividadesRecreM'], '6')
          ? '1'
          : '0',
      idComunicaEntorno: _s(a['idComunicaEntornoM']),
      comunicaEntornoOtros: _s(a['comunicaEntornoOtrosM']),

      idIEss: _has(a['usuarioSeguro'], '1') ? '1' : '0',
      idISsfa: _has(a['usuarioSeguro'], '2') ? '1' : '0',
      idISspol: _has(a['usuarioSeguro'], '3') ? '1' : '0',
      idPrivado: _has(a['usuarioSeguro'], '4') ? '1' : '0',
      idIEssCampesino: _has(a['usuarioSeguro'], '5') ? '1' : '0',
      idNinguno: _has(a['usuarioSeguro'], '6') ? '1' : '0',

      idServMies: _has(a['servicioAtencion'], '1') ? '1' : '0',
      idServGad: _has(a['servicioAtencion'], '2') ? '1' : '0',
      idServIglesia: _has(a['servicioAtencion'], '3') ? '1' : '0',
      idServFundacion: _has(a['servicioAtencion'], '4') ? '1' : '0',
      idServPrivado: _has(a['servicioAtencion'], '5') ? '1' : '0',
      idServOtro: _has(a['servicioAtencion'], '6') ? '1' : '0',
      idServNinguno: _has(a['servicioAtencion'], '7') ? '1' : '0',
      servOtroCual: _has(a['servicioAtencion'], '6')
          ? _s(a['servOtroCualM'])
          : null,

      idNoTiempo: _has(a['noAsisteServPorQue'], '1') ? '1' : '0',
      idDistante: _has(a['noAsisteServPorQue'], '2') ? '1' : '0',
      idNoDinero: _has(a['noAsisteServPorQue'], '3') ? '1' : '0',
      idMalasReferencias: _has(a['noAsisteServPorQue'], '4') ? '1' : '0',
      idOtroNoAsiste: _has(a['noAsisteServPorQue'], '5') ? '1' : '0',
      otroNoAsisteCual: _has(a['noAsisteServPorQue'], '5')
          ? _s(a['otroNoAsisteCualM'])
          : null,

      idDondeDormir: _has(a['porqueAsistiria'], '1') ? '1' : '0',
      idNecesitoAlimentacion: _has(a['porqueAsistiria'], '2') ? '1' : '0',
      idProteccionViolenciaIntra: _has(a['porqueAsistiria'], '3') ? '1' : '0',
      idDesarrolloHabilidades: _has(a['porqueAsistiria'], '4') ? '1' : '0',
      idNecesitaOtro: _has(a['porqueAsistiria'], '5') ? '1' : '0',
      otroNecesitaCual: _has(a['porqueAsistiria'], '5')
          ? _s(a['otroNecesitaCualM'])
          : null,
    );

    // =========================
    // VulnerabilidadViviendaDiscDb
    // =========================
    final viv = VulnerabilidadViviendaDiscDb(
      idVulViviendaDisc: const Uuid().v4(),
      cuen: _s(a['cuenM']),

      idDeslizamientoTierra: _has(a['viviendaRiesgo'], '1') ? '1' : null,
      idInundaciones: _has(a['viviendaRiesgo'], '2') ? '1' : null,
      idSequia: _has(a['viviendaRiesgo'], '3') ? '1' : null,
      idMareTerremotoTsunami: _has(a['viviendaRiesgo'], '4') ? '1' : null,
      idActVolcanicas: _has(a['viviendaRiesgo'], '5') ? '1' : null,
      idIncendiosForestales: _has(a['viviendaRiesgo'], '6') ? '1' : null,
      idContIndusMinerPetroleo: _has(a['viviendaRiesgo'], '7') ? '1' : null,
      idExplosionGasGasolina: _has(a['viviendaRiesgo'], '8') ? '1' : null,

      idBares: _has(a['viviendaZonasTolerancia'], '1') ? '1' : null,
      idDiscotecas: _has(a['viviendaZonasTolerancia'], '2') ? '1' : null,
      idCantinas: _has(a['viviendaZonasTolerancia'], '3') ? '1' : null,
      idBurdeles: _has(a['viviendaZonasTolerancia'], '4') ? '1' : null,

      // 70 lugar donde permanece (multiChoice)
      idViveCueva: _has(a['viviendaHabPermanece'], '1') ? '1' : null,
      idViveCalle: _has(a['viviendaHabPermanece'], '2') ? '1' : null,
      idViveAlbergue: _has(a['viviendaHabPermanece'], '3') ? '1' : null,
      idViveHosHotMotel: _has(a['viviendaHabPermanece'], '4') ? '1' : null,
      idViveCovacha: _has(a['viviendaHabPermanece'], '5') ? '1' : null,
      idViveChoza: _has(a['viviendaHabPermanece'], '6') ? '1' : null,
      idViveMediagua: _has(a['viviendaHabPermanece'], '7') ? '1' : null,
      idViveCuartos: _has(a['viviendaHabPermanece'], '8') ? '1' : null,
      idViveOtrosLugarPerma: _has(a['viviendaHabPermanece'], '9') ? '1' : null,
      viveOtrosLugarPermaCual: _has(a['viviendaHabPermanece'], '9')
          ? _s(a['viveOtrosLugarPermaCualM'])
          : null,

      idViveMasSeisMeses: _s(a['idViveMasSeisMesesM']) == '2'
          ? '1'
          : (_s(a['idViveMasSeisMesesM']) == '1' ? '0' : null),

      idNumCuartos: _s(a['idNumCuartosM']),
      idCuartoExclDormir: _s(a['idCuartoExclDormirM']),
      idNumCuartorDormir: _s(a['idNumCuartorDormirM']),

      idLugarDuerme: _s(a['idLugarDuermeM']),

      idEnergiaElectrica: _has(a['ViviendaServBasicos'], '1') ? '1' : null,
      idAguaPotable: _has(a['ViviendaServBasicos'], '2') ? '1' : null,
      idAlcantarillado: _has(a['ViviendaServBasicos'], '3') ? '1' : null,
      idRecoleccionBasura: _has(a['ViviendaServBasicos'], '4') ? '1' : null,
      idInternet: _has(a['ViviendaServBasicos'], '5') ? '1' : null,

      idTiempoLlegarServMies: _s(a['idTiempoLlegarServMiesM']),
      idTransporteLlegada: _s(a['idTransporteLlegadaM']),
    );

    // =========================
    // FamiliasFactoresRiesgoDb
    // =========================
    final fam = FamiliasFactoresRiesgoDb(
      idFamFactoresRiesgos: const Uuid().v4(),

      idJefatura: _s(a['idJefaturaM']),
      //Falta otra Jefatura cual,
      idNnaSeparado: _bool01(a['idNnaSeparadoM']),
      idNecesidadPedirDinero: _s(a['idNecesidadPedirDineroM']),

      idFrecuenciaAlcohol: _s(a['idFrecuenciaAlcoholM']),
      idFrecuenciaTabaco: _s(a['idFrecuenciaTabacoM']),
      idFrecuenciaDrogasIlegales: _s(a['idFrecuenciaDrogasIlegalesM']),

      idFamPrivLibertad: _bool01('idFamPrivLibertadM'),
      idFamRelaPrivLib: _s(a['idFamRelaPrivLibM']),
      idFamTipoPrivLib: _s(a['idFamTipoPrivLibM']),
      idTieneSentencia: _bool01('idTieneSentenciaM'),

      idFamDesa: _bool01(a['idFamDesaM']),
      famDesaParentesco: _bool01(a['idFamDesaM']) == '1'
          ? _s(a['famDesaParentescoM'])
          : null,
      famDesaTiempo: _bool01(a['idFamDesaM']) == '1'
          ? _s(a['famDesaTiempoM'])
          : null,

      idTrabaFuera: _bool01(a['idTrabaFueraM']),
      trabaFueraDonde: _bool01(a['idTrabaFueraM']) == '1'
          ? _s(a['trabaFueraDondeM'])
          : null,
      //FALTA
      idFamEsOtroPais: _bool01(a['idFamEsOtroPaisM']),
      idTiempoIngreso: _bool01(a['idFamEsOtroPaisM']) == '1'
          ? _s(a['idTiempoIngresoM'])
          : null,
      famEsOtroPaisDonde: _bool01(a['idFamEsOtroPaisM']) == '1'
          ? _s(a['famEsOtroPaisDondeM'])
          : null,
      idTieneVisadoEcuat: _bool01(a['idFamEsOtroPaisM']) == '1'
          ? _bool01(a['idTieneVisadoEcuatM'])
          : null,
      numVisadoEcuat: _bool01(a['idTieneVisadoEcuatM']) == '1'
          ? _s(a['numVisadoEcuatM'])
          : null,

      // AMA (90..98)
      idAma: '1',
      idAmaPregUno: _bool01(a['idAmaPregUnoM']),
      idAmaPregDos: _bool01(a['idAmaPregDosM']),
      idAmaPregTres: _bool01(a['idAmaPregTresM']),
      idAmaPregCuatro: _bool01(a['idAmaPregCuatroM']),
      idAmaPregCinco: _bool01(a['idAmaPregCincoM']),
      idAmaPregSeis: _bool01(a['idAmaPregSeisM']),
      idAmaPregSiete: _bool01(a['idAmaPregSieteM']),
      idAmaPregOcho: _bool01(a['idAmaPregOchoM']),
      idAmaPregNueve: _bool01(a['idAmaPregNueveM']),
    );

    // =========================
    // IngresosGastosDiscDb
    // =========================
    final ing = IngGastosDiscDb(
      idIngGastosDisc: const Uuid().v4(),
      fuenteTrabajoDependencia: _has(a['ingresoFamiliarM'], '1') ? '1' : '0',
      fuenteTrabajoPropio: _has(a['ingresoFamiliarM'], '2') ? '1' : '0',
      pensionJubilacion: _has(a['ingresoFamiliarM'], '3') ? '1' : '0',
      remesasNacInt: _has(a['ingresoFamiliarM'], '4') ? '1' : '0',
      pensionAlimenticia: _has(a['ingresoFamiliarM'], '5') ? '1' : '0',
      fuenteMontepio: _has(a['ingresoFamiliarM'], '6') ? '1' : '0',
      truequePartir: _has(a['ingresoFamiliarM'], '7') ? '1' : '0',
      fuenteOtros: _has(a['ingresoFamiliarM'], '8') ? '1' : '0',
      especifOtroTipoIngreso: _has(a['ingresoFamiliarM'], '8')
          ? _s(a['especifOtroTipoIngresoM'])
          : null,
      ingresos: _s(a['ingresosM']),
      apoyoEconomico: _bool01(a['apoyoEconomicoM']),
      bonoJoaquinGL: _has(a['tipoApoyoEconomicoM'], '1') ? '1' : '0',
      bonoVariable: _has(a['tipoApoyoEconomicoM'], '2') ? '1' : '0',
      bonoMejoresAnios: _has(a['tipoApoyoEconomicoM'], '3') ? '1' : '0',
      bonoDesaHumano: _has(a['tipoApoyoEconomicoM'], '4') ? '1' : '0',
      pensionAm: _has(a['tipoApoyoEconomicoM'], '5') ? '1' : '0',
      pensionPcd: _has(a['tipoApoyoEconomicoM'], '6') ? '1' : '0',
      pensionTodaVida: _has(a['tipoApoyoEconomicoM'], '7') ? '1' : '0',
      coberturaContin: _has(a['tipoApoyoEconomicoM'], '8') ? '1' : '0',
      bonoOrfandad: _has(a['tipoApoyoEconomicoM'], '9') ? '1' : '0',
      idBonoOtro: _has(a['tipoApoyoEconomicoM'], '10') ? '1' : '0',
      bonoOtro: _has(a['tipoApoyoEconomicoM'], '10')
          ? _s(a['bonoOtroM'])
          : null,
    );

    // =========================
    // SaludDiscDb
    // =========================
    final sal = SaludDiscDb(
      idSaludDisc: const Uuid().v4(),

      idAyudaOrgPriv: _bool01(a['idAyudaOrgPrivM']),
      cualOrgPriv: _bool01(a['idAyudaOrgPrivM']) == '1'
          ? _s(a['cualOrgPrivM'])
          : null,
      idNnDesnutricion: _bool01(a['idNnDesnutricionM']),
      idFamHospitalizado: _bool01(a['idFamHospitalizadoM']),
      idFrecuenciaAtencion: _s(a['idFrecuenciaAtencionM']),
      //idUtilizaAyudasTecnicas: validar que se llena uno de los campos para poner 1 o 0
      idOxigenoUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '1') ? '1' : null,
      idSillaRuedasUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '2')
          ? '1'
          : null,
      idAndadorUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '3') ? '1' : null,
      //idLentesBajaVisionUtiliza
      idMuletasUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '5') ? '1' : null,
      idBastonUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '6') ? '1' : null,
      idFerulasPiesUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '7')
          ? '1'
          : null,
      idProtesisUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '8') ? '1' : null,
      idAudifonosUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '9') ? '1' : null,
      idOtrosAyudaTecUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '10')
          ? '1'
          : null,
      especifOtraAyudaTecUtiliza: _has(a['idUtilizaAyudasTecnicasM'], '10')
          ? _s(a['especifOtraAyudaTecUtilizaM'])
          : null,
    );

    // =========================
    // FichaPamDb
    // =========================
    final pam = FichaPamDb(
      idFichaPam: const Uuid().v4(),

      fechaNacimiento: _date(a['fecha_nacimiento']),
      idCedConDiscapacidad: _bool01(a['id_ced_con_discapacidad']),
      numeroCedula: _s(a['numero_cedula']),
      porcentajeDiscapacidad: _s(a['porcentaje_discapacidad']),

      idEtnia: _s(a['id_etnia']),
      idEtniaIndigena: _s(a['id_etnia_indigena']),
      idIdioma: _s(a['id_idioma']),
      idLenguaNativa: _s(a['id_lengua_nativa']),
      idInstruccion: _s(a['id_instruccion']),
      idGrado: _s(a['id_grado']),

      idTrabaja: _bool01(a['id_trabaja']),
      idOcupacionLaboral: _s(a['id_ocupacion_laboral']),
      otroOcupacionLaboral: _s(a['otro_ocupacion_laboral']),
      diasTrabajaSemana: _s(a['dias_trabaja_semana']),
      horasTrabajaDia: _s(a['horas_trabaja_dia']),
      idRazonTrabaja: _s(a['id_razon_trabaja']),
      otroRazonTrabaja: _s(a['otro_razon_trabaja']),

      idGastoVestimentaPam: _bool01(a['id_gasto_vestimenta_pam']),
      valorVestimentaPam: _s(a['valor_vestimenta_pam']),
      idGastoSaludPam: _bool01(a['id_gasto_salud_pam']),
      valorGastoSaludPam: _s(a['valor_gasto_salud_pam']),
      idAlimentacionPam: _bool01(a['id_alimentacion_pam']),
      valorAlimentacionPam: _s(a['valor_alimentacion_pam']),
      idGastoAyudasTecnicasPam: _bool01(a['id_gasto_ayudas_tecnicas_pam']),
      valorAyudaTecnicasPam: _s(a['valor_ayuda_tecnicas_pam']),

      idRequiereCuidados: _bool01(a['id_requiere_cuidados']),
      idCuentaPersonaCuide: _bool01(a['id_cuenta_persona_cuide']),
      idQuienCuidadosDomicilio: _s(a['id_quien_cuidados_domicilio']),
      otrosQuienCuidadosDom: _s(a['otros_quien_cuidados_dom']),

      idAyudaFamDinero: _has(a['tipo_ayuda_familiar'], '1') ? '1' : '0',
      idAyudaFamComida: _has(a['tipo_ayuda_familiar'], '2') ? '1' : '0',
      idAyudaFamRopa: _has(a['tipo_ayuda_familiar'], '3') ? '1' : '0',
      idAyudaFamQuehaceres: _has(a['tipo_ayuda_familiar'], '4') ? '1' : '0',
      idAyudaFamCuidadoPersonal: _has(a['tipo_ayuda_familiar'], '5')
          ? '1'
          : '0',
      idAyudaFamTransporte: _has(a['tipo_ayuda_familiar'], '6') ? '1' : '0',
      idAyudaFamEntretenimiento: _has(a['tipo_ayuda_familiar'], '7')
          ? '1'
          : '0',
      idAyudaFamCompania: _has(a['tipo_ayuda_familiar'], '8') ? '1' : '0',
      idAyudaFamNinguna: _has(a['tipo_ayuda_familiar'], '9') ? '1' : '0',
      idAyudaFamOtro: _has(a['tipo_ayuda_familiar'], '10') ? '1' : '0',
      cualAyudaFamOtro: _has(a['tipo_ayuda_familiar'], '10')
          ? _s(a['cual_ayuda_fam_otro'])
          : null,

      idFrecuenciaAyudaFam: _s(a['id_frecuencia_ayuda_fam']),

      idPamCuidaPersonas: _bool01(a['id_pam_cuida_personas']),
      cuantosNnPamCuida: _s(a['cuantos_nn_pam_cuida']),
      cuantosAdolescentesPamCuida: _s(a['cuantos_adolescentes_pam_cuida']),
      cuantosPcdPamCuida: _s(a['cuantos_pcd_pam_cuida']),
      cuantosPamCuida: _s(a['cuantos_pam_cuida']),
      cuantosOtrosPamCuida: _s(a['cuantos_otros_pam_cuida']),
      cualesOtrosPamCuida: _s(a['cuales_otros_pam_cuida']),

      cuantosMedicamentosUtilizaPam: _s(a['cuantos_medicamentos_utiliza_pam']),
      cuantasVecesCaidoPamSeisMeses: _s(
        a['cuantas_veces_caido_pam_seis_meses'],
      ),
      idProblemasDientesPamDoceMeses: _s(
        a['id_problemas_dientes_pam_doce_meses'],
      ),
      idComeTresComidasDiarias: _bool01(a['id_come_tres_comidas_diarias']),
      idSindromeGolondrina: _bool01(a['id_sindrome_golondrina']),
      numDomiciliosRota: _s(a['num_domicilios_rota']),
      tiempoPasaCadaDomicilio: _s(a['tiempo_pasa_cada_domicilio']),

      idEnfermedadNeurodegenerativa: _bool01(
        a['id_enfermedad_neurodegenerativa'],
      ),
      cualEnfermedadNeurodegenerativa: _s(
        a['cual_enfermedad_neurodegenerativa'],
      ),
      otrosCualEnfermedadNeurodegenerativa: _s(
        a['otros_cual_enfermedad_neurodegenerativa'],
      ),

      idViviendaAccesibilidad: _bool01(a['id_vivienda_accesibilidad']),
      accesRampas: _has(a['accesibilidad_vivienda'], '1') ? '1' : '0',
      accesPasamanos: _has(a['accesibilidad_vivienda'], '2') ? '1' : '0',
      accesManija: _has(a['accesibilidad_vivienda'], '3') ? '1' : '0',
      accesAgarradera: _has(a['accesibilidad_vivienda'], '4') ? '1' : '0',
      accesVentilacion: _has(a['accesibilidad_vivienda'], '5') ? '1' : '0',
      accesIluminacion: _has(a['accesibilidad_vivienda'], '6') ? '1' : '0',
      accesTrasladoFacil: _has(a['accesibilidad_vivienda'], '7') ? '1' : '0',
    );

    return FichaAdultoMayorDiscDb(
      vulnerabilidadPerDiscapacidad: per,
      familiasFactoresRiesgo: fam,
      vulnerabilidadViviendaDisc: viv,
      ingGastosDisc: ing,
      saludDisc: sal,
      fichaPam: pam,
      indiceBarthel: _mapIndiceBarthel(a),
      lawtonBrody: _mapLawtonBrody(a),
      minimentalPam: _mapMiniMental(a),
      yesavagePam: _mapYesavage(a),
      fichaPcd: _mapFichaPcd(a),
      baremo: _mapBaremo(a),
      cargaCuidadorDisc: _mapCargaCuidadorDisc(a),
    );
  }

  IndiceBarthelDiscDb _mapIndiceBarthel(Map<String, dynamic> a) {
    return IndiceBarthelDiscDb(
      idIndiceBarthelDisc: const Uuid().v4(),
      idComer: _s(a['id_comer']),
      idTrasladoSillaCama: _s(a['id_traslado_silla_cama']),
      idAseoPersonal: _s(a['id_aseo_personal']),
      idUsoRetrete: _s(a['id_uso_retrete']),
      idBaniarse: _s(a['id_baniarse']),
      idDesplazarse: _s(a['id_desplazarse']),
      idSubirBajarEscaleras: _s(a['id_subir_bajar_escaleras']),
      idVestirseDesvestirse: _s(a['id_vestirse_desvestirse']),
      idControlHeces: _s(a['id_control_heces']),
      idControlOrina: _s(a['id_control_orina']),
    );
  }

  LawtonBrodyDb _mapLawtonBrody(Map<String, dynamic> a) {
    return LawtonBrodyDb(
      idLawtonBrody: const Uuid().v4(),
      idCapacidadTelefono: _s(a['id_capacidad_telefono']),
      idHacerCompras: _s(a['id_hacer_compras']),
      idPrepararComida: _s(a['id_preparar_comida']),
      idCuidadoCasa: _s(a['id_cuidado_casa']),
      idLavadoRopa: _s(a['id_lavado_ropa']),
      idTransporte: _s(a['id_transporte']),
      idMedicacion: _s(a['id_medicacion']),
      idUtilizarDinero: _s(a['id_utilizar_dinero']),
    );
  }

  MiniMentalPamDb _mapMiniMental(Map<String, dynamic> a) {
    return MiniMentalPamDb(
      idMinimentalPam: const Uuid().v4(),
      idTiempoUno: _s(a['id_tiempo_uno']),
      idTiempoDos: _s(a['id_tiempo_dos']),
      idTiempoTres: _s(a['id_tiempo_tres']),
      idTiempoCuatro: _s(a['id_tiempo_cuatro']),
      idTiempoCinco: _s(a['id_tiempo_cinco']),
      idEspacioUno: _s(a['id_espacio_uno']),
      idEspacioDos: _s(a['id_espacio_dos']),
      idEspacioTres: _s(a['id_espacio_tres']),
      idEspacioCuatro: _s(a['id_espacio_cuatro']),
      idEspacioCinco: _s(a['id_espacio_cinco']),
      idMemoriaUno: _s(a['id_memoria_uno']),
      idMemoriaDos: _s(a['id_memoria_dos']),
      idMemoriaTres: _s(a['id_memoria_tres']),
      idCalculoUno: _s(a['id_calculo_uno']),
      idCalculoDos: _s(a['id_calculo_dos']),
      idCalculoTres: _s(a['id_calculo_tres']),
      idCalculoCuatro: _s(a['id_calculo_cuatro']),
      idCalculoCinco: _s(a['id_calculo_cinco']),
      idMemoriaDifUno: _s(a['id_memoria_dif_uno']),
      idMemoriaDifDos: _s(a['id_memoria_dif_dos']),
      idMemoriaDifTres: _s(a['id_memoria_dif_tres']),
      idDenominacionUno: _s(a['id_denominacion_uno']),
      idDenominacionDos: _s(a['id_denominacion_dos']),
      idRepeticionUno: _s(a['id_repeticion_uno']),
      idComprensionUno: _s(a['id_comprension_uno']),
      idComprensionDos: _s(a['id_comprension_dos']),
      idComprensionTres: _s(a['id_comprension_tres']),
      idLecturaUno: _s(a['id_lectura_uno']),
      idEscrituraUno: _s(a['id_escritura_uno']),
      idCopiaUno: _s(a['id_copia_uno']),
    );
  }

  YesavagePamDb _mapYesavage(Map<String, dynamic> a) {
    return YesavagePamDb(
      idYesavagePam: const Uuid().v4(),
      idYesavageUno: _bool01(a['id_yesavage_uno']),
      idYesavageDos: _bool01(a['id_yesavage_dos']),
      idYesavageTres: _bool01(a['id_yesavage_tres']),
      idYesavageCuatro: _bool01(a['id_yesavage_cuatro']),
      idYesavageCinco: _bool01(a['id_yesavage_cinco']),
      idYesavageSeis: _bool01(a['id_yesavage_seis']),
      idYesavageSiete: _bool01(a['id_yesavage_siete']),
      idYesavageOcho: _bool01(a['id_yesavage_ocho']),
      idYesavageNueve: _bool01(a['id_yesavage_nueve']),
      idYesavageDiez: _bool01(a['id_yesavage_diez']),
      idYesavageOnce: _bool01(a['id_yesavage_once']),
      idYesavageDoce: _bool01(a['id_yesavage_doce']),
      idYesavageTrece: _bool01(a['id_yesavage_trece']),
      idYesavageCatorce: _bool01(a['id_yesavage_catorce']),
      idYesavageQuince: _bool01(a['id_yesavage_quince']),
    );
  }

  FichaPcdDb _mapFichaPcd(Map<String, dynamic> a) {
    return FichaPcdDb(
        idFichapcd: const Uuid().v4(),
      idAtenMed: _s(a['idAtenMedD']),
      idRecursosSuf: _s(a['idRecursosSufD']),
      idApoyoEmoc: _s(a['idApoyoEmocD']),
      idRedApoyo: _s(a['idRedApoyoD']),
      idOportFormProf: _s(a['idOportFormProfD']),
      idDecisVida: _s(a['idDecisVidaD']),
      idOportunEmpleo: _s(a['idOportunEmpleoD']),
      idAccesInfoDere: _s(a['idAccesInfoDereD']),
      idNoVolDecis: _s(a['idNoVolDecisD']),
      idParticipaEntor: _s(a['idParticipaEntorD']),
      idSinApoyo: _s(a['idSinApoyoD']),
      idAccederObst: _s(a['idAccederObstD']),
      idExpresarOpin: _s(a['idExpresarOpinD']),
      idApoyoDesaHabil: _s(a['idApoyoDesaHabilD']),
      idDiscrimViolencia: _s(a['idDiscrimViolenciaD']),
      idIntitutoAprender: _s(a['idIntitutoAprenderD']),
      idCondicMinimSeg: _s(a['idCondicMinimSegD']),
      idEnseUtiliMat: _s(a['idEnseUtiliMatD']),
      idApoyoDecisVida: _s(a['idApoyoDecisVidaD']),
      idValOpiniones: _s(a['idValOpinionesD']),
      idEnseFormaAcces: _s(a['idEnseFormaAccesD']),
      idSegComuni: _s(a['idSegComuniD']),
      idAyudaTecnic: _s(a['idAyudaTecnicD']),
      idApoyoDialog: _s(a['idApoyoDialogD']),
      idAudifAyuTec: _s(a['idAudifAyuTecD']),
      idMantAyuTec: _s(a['idMantAyuTecD']),
      idAyuTecBuenEst: _s(a['idAyuTecBuenEstD']),
      idAyuTecMovMas: _s(a['idAyuTecMovMasD']),
      idMedDifMov: _s(a['idMedDifMovD']),
      idApoyoPsico: _s(a['idApoyoPsicoD']),
      idNoAsisteTrat: _s(a['idNoAsisteTratD']),
      idAccesContrMental: _s(a['idAccesContrMentalD']),
      idEntornoAdaptado: _s(a['idEntornoAdaptadoD']),
      idBienestarSenia: _s(a['idBienestarSeniaD']),
      idExprDeciPref: _s(a['idExprDeciPrefD']),
      idAccesTerapias: _s(a['idAccesTerapiasD']),
      idExclAct: _s(a['idExclActD']),
      idAyuTecCom: _s(a['idAyuTecComD']),
    );
  }

  BaremoDb _mapBaremo(Map<String, dynamic> a) {
    return BaremoDb(
      idBaremo: const Uuid().v4(),
      idConfinadoCama: _s(a['idConfinadoCamaD']),
      idConfinadoSillaRuedas: _s(a['idConfinadoSillaRuedasD']),
      idUsuarioSillaRuedas: _s(a['idUsuarioSillaRuedasD']),
      idAndaNoPonersePie: _s(a['idAndaNoPonersePieD']),
      idAndaNecesitaGuia: _s(a['idAndaNecesitaGuiaD']),
      idAcostarse: _s(a['idAcostarseD']),
      idLevantarse: _s(a['idLevantarseD']),
      idCambiosPostulares: _s(a['idCambiosPostularesD']),
      idRopaCama: _s(a['idRopaCamaD']),
      idPrendasSuperiorCuerpo: _s(a['idPrendasSuperiorCuerpoD']),
      idPrendasInferiorCuerpo: _s(a['idPrendasInferiorCuerpoD']),
      idPrendasCalzado: _s(a['idPrendasCalzadoD']),
      idAbrotarBotonesCremalleras: _s(a['idAbrotarBotonesCremallerasD']),
      idDucharse: _s(a['idDucharseD']),
      idUsoRetrete: _s(a['idUsoRetreteD']),
      idLavarseManosPeinarse: _s(a['idLavarseManosPeinarseD']),
      idLavarsePiesHigMenstrual: _s(a['idLavarsePiesHigMenstrualD']),
      idOtrasActHigienePersonal: _s(a['idOtrasActHigienePersonalD']),
      idSujetarCubiertos: _s(a['idSujetarCubiertosD']),
      idSujetarJarras: _s(a['idSujetarJarrasD']),
      idServirseCortarCarne: _s(a['idServirseCortarCarneD']),
      idAyudaUrg: _s(a['idAyudaUrgD']),
      idLlamadasPuerta: _s(a['idLlamadasPuertaD']),
      idUsarTelefono: _s(a['idUsarTelefonoD']),
      idSeguridadAcceso: _s(a['idSeguridadAccesoD']),
      idUsoDispositivosDomesticos: _s(a['idUsoDispositivosDomesticosD']),
      idUsoRadiosLibros: _s(a['idUsoRadiosLibrosD']),
      idAparatosEspeciales: _s(a['idAparatosEspecialesD']),
      idPrecaucionesEspeciales: _s(a['idPrecaucionesEspecialesD']),
      idDependenciaPersona: _s(a['idDependenciaPersonaD']),
      idIncapacidadTotal: _s(a['idIncapacidadTotalD']),
      idConductasAgresivas: _s(a['idConductasAgresivasD']),
      idConductasInadaptadas: _s(a['idConductasInadaptadasD']),
      idProteccionAbsoluta: _s(a['idProteccionAbsolutaD']),
      idDisponibilidadContinua: _s(a['idDisponibilidadContinuaD']),
      idNormasHabitualesConvivencia: _s(a['idNormasHabitualesConvivenciaD']),
      idConocimientoNormas: _s(a['idConocimientoNormasD']),
      idNormasEspeciales: _s(a['idNormasEspecialesD']),
      idRutinaCotidiana: _s(a['idRutinaCotidianaD']),
      idProblemasHabituales: _s(a['idProblemasHabitualesD']),
    );
  }

  CargaCuidadorDiscDb _mapCargaCuidadorDisc(Map<String, dynamic> a) {
    return CargaCuidadorDiscDb(
      idCargaCuidadorDiscDisc: const Uuid().v4(),
      idPersonaCuidadora: _s(a['idPersonaCuidadoraD']),
      idCuidadoOtrasPersonas: _s(a['idCuidadoOtrasPersonasD']),
      idCuidadoraDisc: _s(a['idCuidadoraDiscD']),
      idMiembroHogarSustituto: _s(a['idMiembroHogarSustitutoD']),
      idSustitutoTrabaja: _s(a['idSustitutoTrabajaD']),
      idDiscCuidaPersonasHogar: _s(a['idDiscCuidaPersonasHogarD']),
      idAyudaFamilia: _s(a['idAyudaFamiliaD']),
      idSuficienteTiempo: _s(a['idSuficienteTiempoD']),
      idAgobiadoCompatibilizar: _s(a['idAgobiadoCompatibilizarD']),
      idVerguenzaConductaFam: _s(a['idVerguenzaConductaFamD']),
      idEnfadadoCercaFam: _s(a['idEnfadadoCercaFamD']),
      idCuidarFamAfectaNeg: _s(a['idCuidarFamAfectaNegD']),
      idMiedoFuturoFam: _s(a['idMiedoFuturoFamD']),
      idFamDependeUsted: _s(a['idFamDependeUstedD']),
      idTensoCercaFam: _s(a['idTensoCercaFamD']),
      idSaludEmpeorado: _s(a['idSaludEmpeoradoD']),
      idMpTieneIntimidad: _s(a['idMpTieneIntimidadD']),
      idVidaSocialAfectada: _s(a['idVidaSocialAfectadaD']),
      idIncomodoDistanciarse: _s(a['idIncomodoDistanciarseD']),
      idFamiliarUnicaPersCuidar: _s(a['idFamiliarUnicaPersCuidarD']),
      idNoTieneSuficientesIngre: _s(a['idNoTieneSuficientesIngreD']),
      idNoCapazCuidarFam: _s(a['idNoCapazCuidarFamD']),
      idPerdidoControl: _s(a['idPerdidoControlD']),
      idDejarCuidadoFamiliar: _s(a['idDejarCuidadoFamiliarD']),
      idIndeciso: _s(a['idIndecisoD']),
      idDeberiaHacerMasFam: _s(a['idDeberiaHacerMasFamD']),
      idGradoCargaExperimenta: _s(a['idGradoCargaExperimentaD']),

    );
  }



  // ===== Helpers =====

  String? _s(dynamic v) {
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }

  String? _date(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v.toIso8601String().split('T').first;
    return v.toString(); // "YYYY-MM-DD"
  }

  String _joinNames(String? nombres, String? apellidos) {
    final n = (nombres ?? '').trim();
    final a = (apellidos ?? '').trim();
    return ('$n $a').trim();
  }

  String? _bool01(dynamic v) {
    if (v == null) return null;
    if (v is bool) return v ? '1' : '0';
    final s = v.toString().trim().toLowerCase();
    if (s == '1' || s == 'true' || s == 'si' || s == 'sí') return '1';
    if (s == '0' || s == 'false' || s == 'no') return '0';
    return null;
  }

  bool _has(dynamic v, String optionId) {
    if (v == null) return false;
    if (v is List) return v.map((e) => e.toString()).contains(optionId);
    return v.toString().split(',').map((e) => e.trim()).contains(optionId);
  }
}
