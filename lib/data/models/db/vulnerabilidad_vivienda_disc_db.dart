// lib/data/models/db/vulnerabilidad_vivienda_disc_db.dart
//
// Modelo DB (modelo “tabla”) alineado a los campos de tu contrato/base.
// - NO incluye XML/SOAP.
// - Incluye: constructor, empty(), copyWith, toJson/fromJson.
// - idVulViviendaDisc se autogenera si no se pasa.
// - Nota: en Java tenías alias XML:
//     @Element(name="numCuartosDisponeVivienda") private String idNumCuartos;
//     @Element(name="numCuartorDormir") private String idNumCuartorDormir;
//   En DB lo guardamos con nombres claros, y el serializer SOAP emitirá los tags exactos.

import 'package:uuid/uuid.dart';

class VulnerabilidadViviendaDiscDb {
  final String idVulViviendaDisc;

  final String? latitud;
  final String? longitud;
  final String? cuen;

  final String? idAccesoVivienda;
  final String? idHabitabilidad;
  final String? idAccesibilidad;
  final String? idUbicacionRiesgo;
  final String? idUbicacionTolerancia;

  final String? idTipoVivienda;
  final String? otroTipoVivienda;

  final String? idPropiedadVivienda;
  final String? otraPropiedad;

  /// En SOAP se envía como <numCuartosDisponeVivienda>
  final String? idNumCuartos;

  /// En SOAP se envía como <numCuartorDormir>
  final String? idNumCuartorDormir;

  final String? idCuartoExclDormir;

  final String? idEnergiaElectrica;
  final String? idAguaPotable;
  final String? idAlcantarillado;
  final String? idRecoleccionBasura;
  final String? idTelefono;
  final String? idInternet;

  final String? idProvieneAgua;
  final String? idDistanciaCentroSalud;
  final String? idDistanciaCentroEducacion;

  final String? idAfiliacion;
  final String? idConoceServPubl;
  final String? idAsisteServPubl;

  final String? idServicioPertenece;
  final String? especifiqueOtroServicio;

  final String? idAsisteServicioDisc;
  final String? idTiempoLlegarServMies;
  final String? idMiesOfreceServicio;

  final String? idPorqueSiServicio;
  final String? especifPorqueSiServ;
  final String? idPorqueNoServicio;
  final String? especifPorqueNoServ;

  final String? idViviendaPropia;

  final String? idBares;
  final String? idDiscotecas;
  final String? idCantinas;
  final String? idBurdeles;

  // Eventos de riesgo
  final String? idDeslizamientoTierra;
  final String? idInundaciones;
  final String? idSequia;
  final String? idMareTerremotoTsunami;
  final String? idActVolcanicas;
  final String? idIncendiosForestales;
  final String? idContIndusMinerPetroleo;
  final String? idExplosionGasGasolina;

  // Lugar donde permanece
  final String? idViveCueva;
  final String? idViveCalle;
  final String? idViveAlbergue;
  final String? idViveHosHotMotel;
  final String? idViveCovacha;
  final String? idViveChoza;
  final String? idViveMediagua;
  final String? idViveCuartos;
  final String? idViveOtrosLugarPerma;
  final String? viveOtrosLugarPermaCual;
  final String? idViveMasSeisMeses;

  final String? idLugarDuerme;
  final String? idTransporteLlegada;

  VulnerabilidadViviendaDiscDb({
    String? idVulViviendaDisc,
    this.latitud,
    this.longitud,
    this.cuen,
    this.idAccesoVivienda,
    this.idHabitabilidad,
    this.idAccesibilidad,
    this.idUbicacionRiesgo,
    this.idUbicacionTolerancia,
    this.idTipoVivienda,
    this.otroTipoVivienda,
    this.idPropiedadVivienda,
    this.otraPropiedad,
    this.idNumCuartos,
    this.idNumCuartorDormir,
    this.idCuartoExclDormir,
    this.idEnergiaElectrica,
    this.idAguaPotable,
    this.idAlcantarillado,
    this.idRecoleccionBasura,
    this.idTelefono,
    this.idInternet,
    this.idProvieneAgua,
    this.idDistanciaCentroSalud,
    this.idDistanciaCentroEducacion,
    this.idAfiliacion,
    this.idConoceServPubl,
    this.idAsisteServPubl,
    this.idServicioPertenece,
    this.especifiqueOtroServicio,
    this.idAsisteServicioDisc,
    this.idTiempoLlegarServMies,
    this.idMiesOfreceServicio,
    this.idPorqueSiServicio,
    this.especifPorqueSiServ,
    this.idPorqueNoServicio,
    this.especifPorqueNoServ,
    this.idViviendaPropia,
    this.idBares,
    this.idDiscotecas,
    this.idCantinas,
    this.idBurdeles,
    this.idDeslizamientoTierra,
    this.idInundaciones,
    this.idSequia,
    this.idMareTerremotoTsunami,
    this.idActVolcanicas,
    this.idIncendiosForestales,
    this.idContIndusMinerPetroleo,
    this.idExplosionGasGasolina,
    this.idViveCueva,
    this.idViveCalle,
    this.idViveAlbergue,
    this.idViveHosHotMotel,
    this.idViveCovacha,
    this.idViveChoza,
    this.idViveMediagua,
    this.idViveCuartos,
    this.idViveOtrosLugarPerma,
    this.viveOtrosLugarPermaCual,
    this.idViveMasSeisMeses,
    this.idLugarDuerme,
    this.idTransporteLlegada,
  }) : idVulViviendaDisc = idVulViviendaDisc ?? const Uuid().v4();

  static VulnerabilidadViviendaDiscDb empty() => VulnerabilidadViviendaDiscDb();

  VulnerabilidadViviendaDiscDb copyWith({
    String? latitud,
    String? longitud,
    String? cuen,
    String? idAccesoVivienda,
    String? idHabitabilidad,
    String? idAccesibilidad,
    String? idUbicacionRiesgo,
    String? idUbicacionTolerancia,
    String? idTipoVivienda,
    String? otroTipoVivienda,
    String? idPropiedadVivienda,
    String? otraPropiedad,
    String? idNumCuartos,
    String? idNumCuartorDormir,
    String? idCuartoExclDormir,
    String? idEnergiaElectrica,
    String? idAguaPotable,
    String? idAlcantarillado,
    String? idRecoleccionBasura,
    String? idTelefono,
    String? idInternet,
    String? idProvieneAgua,
    String? idDistanciaCentroSalud,
    String? idDistanciaCentroEducacion,
    String? idAfiliacion,
    String? idConoceServPubl,
    String? idAsisteServPubl,
    String? idServicioPertenece,
    String? especifiqueOtroServicio,
    String? idAsisteServicioDisc,
    String? idTiempoLlegarServMies,
    String? idMiesOfreceServicio,
    String? idPorqueSiServicio,
    String? especifPorqueSiServ,
    String? idPorqueNoServicio,
    String? especifPorqueNoServ,
    String? idViviendaPropia,
    String? idBares,
    String? idDiscotecas,
    String? idCantinas,
    String? idBurdeles,
    String? idDeslizamientoTierra,
    String? idInundaciones,
    String? idSequia,
    String? idMareTerremotoTsunami,
    String? idActVolcanicas,
    String? idIncendiosForestales,
    String? idContIndusMinerPetroleo,
    String? idExplosionGasGasolina,
    String? idViveCueva,
    String? idViveCalle,
    String? idViveAlbergue,
    String? idViveHosHotMotel,
    String? idViveCovacha,
    String? idViveChoza,
    String? idViveMediagua,
    String? idViveCuartos,
    String? idViveOtrosLugarPerma,
    String? viveOtrosLugarPermaCual,
    String? idViveMasSeisMeses,
    String? idLugarDuerme,
    String? idTransporteLlegada,
  }) {
    return VulnerabilidadViviendaDiscDb(
      idVulViviendaDisc: idVulViviendaDisc,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      cuen: cuen ?? this.cuen,
      idAccesoVivienda: idAccesoVivienda ?? this.idAccesoVivienda,
      idHabitabilidad: idHabitabilidad ?? this.idHabitabilidad,
      idAccesibilidad: idAccesibilidad ?? this.idAccesibilidad,
      idUbicacionRiesgo: idUbicacionRiesgo ?? this.idUbicacionRiesgo,
      idUbicacionTolerancia: idUbicacionTolerancia ?? this.idUbicacionTolerancia,
      idTipoVivienda: idTipoVivienda ?? this.idTipoVivienda,
      otroTipoVivienda: otroTipoVivienda ?? this.otroTipoVivienda,
      idPropiedadVivienda: idPropiedadVivienda ?? this.idPropiedadVivienda,
      otraPropiedad: otraPropiedad ?? this.otraPropiedad,
      idNumCuartos: idNumCuartos ?? this.idNumCuartos,
      idNumCuartorDormir: idNumCuartorDormir ?? this.idNumCuartorDormir,
      idCuartoExclDormir: idCuartoExclDormir ?? this.idCuartoExclDormir,
      idEnergiaElectrica: idEnergiaElectrica ?? this.idEnergiaElectrica,
      idAguaPotable: idAguaPotable ?? this.idAguaPotable,
      idAlcantarillado: idAlcantarillado ?? this.idAlcantarillado,
      idRecoleccionBasura: idRecoleccionBasura ?? this.idRecoleccionBasura,
      idTelefono: idTelefono ?? this.idTelefono,
      idInternet: idInternet ?? this.idInternet,
      idProvieneAgua: idProvieneAgua ?? this.idProvieneAgua,
      idDistanciaCentroSalud: idDistanciaCentroSalud ?? this.idDistanciaCentroSalud,
      idDistanciaCentroEducacion: idDistanciaCentroEducacion ?? this.idDistanciaCentroEducacion,
      idAfiliacion: idAfiliacion ?? this.idAfiliacion,
      idConoceServPubl: idConoceServPubl ?? this.idConoceServPubl,
      idAsisteServPubl: idAsisteServPubl ?? this.idAsisteServPubl,
      idServicioPertenece: idServicioPertenece ?? this.idServicioPertenece,
      especifiqueOtroServicio: especifiqueOtroServicio ?? this.especifiqueOtroServicio,
      idAsisteServicioDisc: idAsisteServicioDisc ?? this.idAsisteServicioDisc,
      idTiempoLlegarServMies: idTiempoLlegarServMies ?? this.idTiempoLlegarServMies,
      idMiesOfreceServicio: idMiesOfreceServicio ?? this.idMiesOfreceServicio,
      idPorqueSiServicio: idPorqueSiServicio ?? this.idPorqueSiServicio,
      especifPorqueSiServ: especifPorqueSiServ ?? this.especifPorqueSiServ,
      idPorqueNoServicio: idPorqueNoServicio ?? this.idPorqueNoServicio,
      especifPorqueNoServ: especifPorqueNoServ ?? this.especifPorqueNoServ,
      idViviendaPropia: idViviendaPropia ?? this.idViviendaPropia,
      idBares: idBares ?? this.idBares,
      idDiscotecas: idDiscotecas ?? this.idDiscotecas,
      idCantinas: idCantinas ?? this.idCantinas,
      idBurdeles: idBurdeles ?? this.idBurdeles,
      idDeslizamientoTierra: idDeslizamientoTierra ?? this.idDeslizamientoTierra,
      idInundaciones: idInundaciones ?? this.idInundaciones,
      idSequia: idSequia ?? this.idSequia,
      idMareTerremotoTsunami: idMareTerremotoTsunami ?? this.idMareTerremotoTsunami,
      idActVolcanicas: idActVolcanicas ?? this.idActVolcanicas,
      idIncendiosForestales: idIncendiosForestales ?? this.idIncendiosForestales,
      idContIndusMinerPetroleo: idContIndusMinerPetroleo ?? this.idContIndusMinerPetroleo,
      idExplosionGasGasolina: idExplosionGasGasolina ?? this.idExplosionGasGasolina,
      idViveCueva: idViveCueva ?? this.idViveCueva,
      idViveCalle: idViveCalle ?? this.idViveCalle,
      idViveAlbergue: idViveAlbergue ?? this.idViveAlbergue,
      idViveHosHotMotel: idViveHosHotMotel ?? this.idViveHosHotMotel,
      idViveCovacha: idViveCovacha ?? this.idViveCovacha,
      idViveChoza: idViveChoza ?? this.idViveChoza,
      idViveMediagua: idViveMediagua ?? this.idViveMediagua,
      idViveCuartos: idViveCuartos ?? this.idViveCuartos,
      idViveOtrosLugarPerma: idViveOtrosLugarPerma ?? this.idViveOtrosLugarPerma,
      viveOtrosLugarPermaCual: viveOtrosLugarPermaCual ?? this.viveOtrosLugarPermaCual,
      idViveMasSeisMeses: idViveMasSeisMeses ?? this.idViveMasSeisMeses,
      idLugarDuerme: idLugarDuerme ?? this.idLugarDuerme,
      idTransporteLlegada: idTransporteLlegada ?? this.idTransporteLlegada,
    );
  }

  Map<String, dynamic> toJson() => {
    'idVulViviendaDisc': idVulViviendaDisc,
    'latitud': latitud,
    'longitud': longitud,
    'cuen': cuen,
    'idAccesoVivienda': idAccesoVivienda,
    'idHabitabilidad': idHabitabilidad,
    'idAccesibilidad': idAccesibilidad,
    'idUbicacionRiesgo': idUbicacionRiesgo,
    'idUbicacionTolerancia': idUbicacionTolerancia,
    'idTipoVivienda': idTipoVivienda,
    'otroTipoVivienda': otroTipoVivienda,
    'idPropiedadVivienda': idPropiedadVivienda,
    'otraPropiedad': otraPropiedad,
    'idNumCuartos': idNumCuartos,
    'idNumCuartorDormir': idNumCuartorDormir,
    'idCuartoExclDormir': idCuartoExclDormir,
    'idEnergiaElectrica': idEnergiaElectrica,
    'idAguaPotable': idAguaPotable,
    'idAlcantarillado': idAlcantarillado,
    'idRecoleccionBasura': idRecoleccionBasura,
    'idTelefono': idTelefono,
    'idInternet': idInternet,
    'idProvieneAgua': idProvieneAgua,
    'idDistanciaCentroSalud': idDistanciaCentroSalud,
    'idDistanciaCentroEducacion': idDistanciaCentroEducacion,
    'idAfiliacion': idAfiliacion,
    'idConoceServPubl': idConoceServPubl,
    'idAsisteServPubl': idAsisteServPubl,
    'idServicioPertenece': idServicioPertenece,
    'especifiqueOtroServicio': especifiqueOtroServicio,
    'idAsisteServicioDisc': idAsisteServicioDisc,
    'idTiempoLlegarServMies': idTiempoLlegarServMies,
    'idMiesOfreceServicio': idMiesOfreceServicio,
    'idPorqueSiServicio': idPorqueSiServicio,
    'especifPorqueSiServ': especifPorqueSiServ,
    'idPorqueNoServicio': idPorqueNoServicio,
    'especifPorqueNoServ': especifPorqueNoServ,
    'idViviendaPropia': idViviendaPropia,
    'idBares': idBares,
    'idDiscotecas': idDiscotecas,
    'idCantinas': idCantinas,
    'idBurdeles': idBurdeles,
    'idDeslizamientoTierra': idDeslizamientoTierra,
    'idInundaciones': idInundaciones,
    'idSequia': idSequia,
    'idMareTerremotoTsunami': idMareTerremotoTsunami,
    'idActVolcanicas': idActVolcanicas,
    'idIncendiosForestales': idIncendiosForestales,
    'idContIndusMinerPetroleo': idContIndusMinerPetroleo,
    'idExplosionGasGasolina': idExplosionGasGasolina,
    'idViveCueva': idViveCueva,
    'idViveCalle': idViveCalle,
    'idViveAlbergue': idViveAlbergue,
    'idViveHosHotMotel': idViveHosHotMotel,
    'idViveCovacha': idViveCovacha,
    'idViveChoza': idViveChoza,
    'idViveMediagua': idViveMediagua,
    'idViveCuartos': idViveCuartos,
    'idViveOtrosLugarPerma': idViveOtrosLugarPerma,
    'viveOtrosLugarPermaCual': viveOtrosLugarPermaCual,
    'idViveMasSeisMeses': idViveMasSeisMeses,
    'idLugarDuerme': idLugarDuerme,
    'idTransporteLlegada': idTransporteLlegada,
  };

  static VulnerabilidadViviendaDiscDb fromJson(Map<String, dynamic> json) {
    return VulnerabilidadViviendaDiscDb(
      idVulViviendaDisc: (json['idVulViviendaDisc'] as String?) ?? const Uuid().v4(),
      latitud: json['latitud'] as String?,
      longitud: json['longitud'] as String?,
      cuen: json['cuen'] as String?,
      idAccesoVivienda: json['idAccesoVivienda'] as String?,
      idHabitabilidad: json['idHabitabilidad'] as String?,
      idAccesibilidad: json['idAccesibilidad'] as String?,
      idUbicacionRiesgo: json['idUbicacionRiesgo'] as String?,
      idUbicacionTolerancia: json['idUbicacionTolerancia'] as String?,
      idTipoVivienda: json['idTipoVivienda'] as String?,
      otroTipoVivienda: json['otroTipoVivienda'] as String?,
      idPropiedadVivienda: json['idPropiedadVivienda'] as String?,
      otraPropiedad: json['otraPropiedad'] as String?,
      idNumCuartos: json['idNumCuartos'] as String?,
      idNumCuartorDormir: json['idNumCuartorDormir'] as String?,
      idCuartoExclDormir: json['idCuartoExclDormir'] as String?,
      idEnergiaElectrica: json['idEnergiaElectrica'] as String?,
      idAguaPotable: json['idAguaPotable'] as String?,
      idAlcantarillado: json['idAlcantarillado'] as String?,
      idRecoleccionBasura: json['idRecoleccionBasura'] as String?,
      idTelefono: json['idTelefono'] as String?,
      idInternet: json['idInternet'] as String?,
      idProvieneAgua: json['idProvieneAgua'] as String?,
      idDistanciaCentroSalud: json['idDistanciaCentroSalud'] as String?,
      idDistanciaCentroEducacion: json['idDistanciaCentroEducacion'] as String?,
      idAfiliacion: json['idAfiliacion'] as String?,
      idConoceServPubl: json['idConoceServPubl'] as String?,
      idAsisteServPubl: json['idAsisteServPubl'] as String?,
      idServicioPertenece: json['idServicioPertenece'] as String?,
      especifiqueOtroServicio: json['especifiqueOtroServicio'] as String?,
      idAsisteServicioDisc: json['idAsisteServicioDisc'] as String?,
      idTiempoLlegarServMies: json['idTiempoLlegarServMies'] as String?,
      idMiesOfreceServicio: json['idMiesOfreceServicio'] as String?,
      idPorqueSiServicio: json['idPorqueSiServicio'] as String?,
      especifPorqueSiServ: json['especifPorqueSiServ'] as String?,
      idPorqueNoServicio: json['idPorqueNoServicio'] as String?,
      especifPorqueNoServ: json['especifPorqueNoServ'] as String?,
      idViviendaPropia: json['idViviendaPropia'] as String?,
      idBares: json['idBares'] as String?,
      idDiscotecas: json['idDiscotecas'] as String?,
      idCantinas: json['idCantinas'] as String?,
      idBurdeles: json['idBurdeles'] as String?,
      idDeslizamientoTierra: json['idDeslizamientoTierra'] as String?,
      idInundaciones: json['idInundaciones'] as String?,
      idSequia: json['idSequia'] as String?,
      idMareTerremotoTsunami: json['idMareTerremotoTsunami'] as String?,
      idActVolcanicas: json['idActVolcanicas'] as String?,
      idIncendiosForestales: json['idIncendiosForestales'] as String?,
      idContIndusMinerPetroleo: json['idContIndusMinerPetroleo'] as String?,
      idExplosionGasGasolina: json['idExplosionGasGasolina'] as String?,
      idViveCueva: json['idViveCueva'] as String?,
      idViveCalle: json['idViveCalle'] as String?,
      idViveAlbergue: json['idViveAlbergue'] as String?,
      idViveHosHotMotel: json['idViveHosHotMotel'] as String?,
      idViveCovacha: json['idViveCovacha'] as String?,
      idViveChoza: json['idViveChoza'] as String?,
      idViveMediagua: json['idViveMediagua'] as String?,
      idViveCuartos: json['idViveCuartos'] as String?,
      idViveOtrosLugarPerma: json['idViveOtrosLugarPerma'] as String?,
      viveOtrosLugarPermaCual: json['viveOtrosLugarPermaCual'] as String?,
      idViveMasSeisMeses: json['idViveMasSeisMeses'] as String?,
      idLugarDuerme: json['idLugarDuerme'] as String?,
      idTransporteLlegada: json['idTransporteLlegada'] as String?,
    );
  }
}
