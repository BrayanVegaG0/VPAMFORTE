import 'package:uuid/uuid.dart';

class FichaPamDb {
  final String idFichaPam;
  final String? fechaNacimiento;
  final String? idCedConDiscapacidad;
  final String? numeroCedula;
  final String? porcentajeDiscapacidad;
  final String? idEtnia;
  final String? idEtniaIndigena;
  final String? idIdioma;
  final String? idLenguaNativa;
  final String? idInstruccion;
  final String? idGrado;
  final String? idTrabaja;
  final String? idOcupacionLaboral;
  final String? otroOcupacionLaboral;
  final String? diasTrabajaSemana;
  final String? horasTrabajaDia;
  final String? idRazonTrabaja;
  final String? otroRazonTrabaja;
  final String? idGastoVestimentaPam;
  final String? valorVestimentaPam;
  final String? idGastoSaludPam;
  final String? valorGastoSaludPam;
  final String? idAlimentacionPam;
  final String? valorAlimentacionPam;
  final String? idGastoAyudasTecnicasPam;
  final String? valorAyudaTecnicasPam;
  final String? idRequiereCuidados;
  final String? idCuentaPersonaCuide;
  final String? idQuienCuidadosDomicilio;
  final String? otrosQuienCuidadosDom;
  final String? idAyudaFamDinero;
  final String? idAyudaFamComida;
  final String? idAyudaFamRopa;
  final String? idAyudaFamQuehaceres;
  final String? idAyudaFamCuidadoPersonal;
  final String? idAyudaFamTransporte;
  final String? idAyudaFamEntretenimiento;
  final String? idAyudaFamCompania;
  final String? idAyudaFamNinguna;
  final String? idAyudaFamOtro;
  final String? cualAyudaFamOtro;
  final String? idFrecuenciaAyudaFam;
  final String? idPamCuidaPersonas;
  final String? cuantosNnPamCuida;
  final String? cuantosAdolescentesPamCuida;
  final String? cuantosPcdPamCuida;
  final String? cuantosPamCuida;
  final String? cuantosOtrosPamCuida;
  final String? cualesOtrosPamCuida;
  final String? cuantosMedicamentosUtilizaPam;
  final String? cuantasVecesCaidoPamSeisMeses;
  final String? idProblemasDientesPamDoceMeses;
  final String? idComeTresComidasDiarias;
  final String? idSindromeGolondrina;
  final String? numDomiciliosRota;
  final String? tiempoPasaCadaDomicilio;
  final String? idEnfermedadNeurodegenerativa;
  final String? cualEnfermedadNeurodegenerativa;
  final String? otrosCualEnfermedadNeurodegenerativa;
  final String? idViviendaAccesibilidad;
  final String? accesRampas;
  final String? accesPasamanos;
  final String? accesManija;
  final String? accesAgarradera;
  final String? accesVentilacion;
  final String? accesIluminacion;
  final String? accesTrasladoFacil;

  FichaPamDb({
    String? idFichaPam,
    this.fechaNacimiento,
    this.idCedConDiscapacidad,
    this.numeroCedula,
    this.porcentajeDiscapacidad,
    this.idEtnia,
    this.idEtniaIndigena,
    this.idIdioma,
    this.idLenguaNativa,
    this.idInstruccion,
    this.idGrado,
    this.idTrabaja,
    this.idOcupacionLaboral,
    this.otroOcupacionLaboral,
    this.diasTrabajaSemana,
    this.horasTrabajaDia,
    this.idRazonTrabaja,
    this.otroRazonTrabaja,
    this.idGastoVestimentaPam,
    this.valorVestimentaPam,
    this.idGastoSaludPam,
    this.valorGastoSaludPam,
    this.idAlimentacionPam,
    this.valorAlimentacionPam,
    this.idGastoAyudasTecnicasPam,
    this.valorAyudaTecnicasPam,
    this.idRequiereCuidados,
    this.idCuentaPersonaCuide,
    this.idQuienCuidadosDomicilio,
    this.otrosQuienCuidadosDom,
    this.idAyudaFamDinero,
    this.idAyudaFamComida,
    this.idAyudaFamRopa,
    this.idAyudaFamQuehaceres,
    this.idAyudaFamCuidadoPersonal,
    this.idAyudaFamTransporte,
    this.idAyudaFamEntretenimiento,
    this.idAyudaFamCompania,
    this.idAyudaFamNinguna,
    this.idAyudaFamOtro,
    this.cualAyudaFamOtro,
    this.idFrecuenciaAyudaFam,
    this.idPamCuidaPersonas,
    this.cuantosNnPamCuida,
    this.cuantosAdolescentesPamCuida,
    this.cuantosPcdPamCuida,
    this.cuantosPamCuida,
    this.cuantosOtrosPamCuida,
    this.cualesOtrosPamCuida,
    this.cuantosMedicamentosUtilizaPam,
    this.cuantasVecesCaidoPamSeisMeses,
    this.idProblemasDientesPamDoceMeses,
    this.idComeTresComidasDiarias,
    this.idSindromeGolondrina,
    this.numDomiciliosRota,
    this.tiempoPasaCadaDomicilio,
    this.idEnfermedadNeurodegenerativa,
    this.cualEnfermedadNeurodegenerativa,
    this.otrosCualEnfermedadNeurodegenerativa,
    this.idViviendaAccesibilidad,
    this.accesRampas,
    this.accesPasamanos,
    this.accesManija,
    this.accesAgarradera,
    this.accesVentilacion,
    this.accesIluminacion,
    this.accesTrasladoFacil,
  }) : idFichaPam = idFichaPam ?? const Uuid().v4();

  FichaPamDb copyWith({
    String? fechaNacimiento,
    String? idCedConDiscapacidad,
    String? numeroCedula,
    String? porcentajeDiscapacidad,
    String? idEtnia,
    String? idEtniaIndigena,
    String? idIdioma,
    String? idLenguaNativa,
    String? idInstruccion,
    String? idGrado,
    String? idTrabaja,
    String? idOcupacionLaboral,
    String? otroOcupacionLaboral,
    String? diasTrabajaSemana,
    String? horasTrabajaDia,
    String? idRazonTrabaja,
    String? otroRazonTrabaja,
    String? idGastoVestimentaPam,
    String? valorVestimentaPam,
    String? idGastoSaludPam,
    String? valorGastoSaludPam,
    String? idAlimentacionPam,
    String? valorAlimentacionPam,
    String? idGastoAyudasTecnicasPam,
    String? valorAyudaTecnicasPam,
    String? idRequiereCuidados,
    String? idCuentaPersonaCuide,
    String? idQuienCuidadosDomicilio,
    String? otrosQuienCuidadosDom,
    String? idAyudaFamDinero,
    String? idAyudaFamComida,
    String? idAyudaFamRopa,
    String? idAyudaFamQuehaceres,
    String? idAyudaFamCuidadoPersonal,
    String? idAyudaFamTransporte,
    String? idAyudaFamEntretenimiento,
    String? idAyudaFamCompania,
    String? idAyudaFamNinguna,
    String? idAyudaFamOtro,
    String? cualAyudaFamOtro,
    String? idFrecuenciaAyudaFam,
    String? idPamCuidaPersonas,
    String? cuantosNnPamCuida,
    String? cuantosAdolescentesPamCuida,
    String? cuantosPcdPamCuida,
    String? cuantosPamCuida,
    String? cuantosOtrosPamCuida,
    String? cualesOtrosPamCuida,
    String? cuantosMedicamentosUtilizaPam,
    String? cuantasVecesCaidoPamSeisMeses,
    String? idProblemasDientesPamDoceMeses,
    String? idComeTresComidasDiarias,
    String? idSindromeGolondrina,
    String? numDomiciliosRota,
    String? tiempoPasaCadaDomicilio,
    String? idEnfermedadNeurodegenerativa,
    String? cualEnfermedadNeurodegenerativa,
    String? otrosCualEnfermedadNeurodegenerativa,
    String? idViviendaAccesibilidad,
    String? accesRampas,
    String? accesPasamanos,
    String? accesManija,
    String? accesAgarradera,
    String? accesVentilacion,
    String? accesIluminacion,
    String? accesTrasladoFacil,
  }) {
    return FichaPamDb(
      idFichaPam: idFichaPam,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      idCedConDiscapacidad: idCedConDiscapacidad ?? this.idCedConDiscapacidad,
      numeroCedula: numeroCedula ?? this.numeroCedula,
      porcentajeDiscapacidad:
          porcentajeDiscapacidad ?? this.porcentajeDiscapacidad,
      idEtnia: idEtnia ?? this.idEtnia,
      idEtniaIndigena: idEtniaIndigena ?? this.idEtniaIndigena,
      idIdioma: idIdioma ?? this.idIdioma,
      idLenguaNativa: idLenguaNativa ?? this.idLenguaNativa,
      idInstruccion: idInstruccion ?? this.idInstruccion,
      idGrado: idGrado ?? this.idGrado,
      idTrabaja: idTrabaja ?? this.idTrabaja,
      idOcupacionLaboral: idOcupacionLaboral ?? this.idOcupacionLaboral,
      otroOcupacionLaboral: otroOcupacionLaboral ?? this.otroOcupacionLaboral,
      diasTrabajaSemana: diasTrabajaSemana ?? this.diasTrabajaSemana,
      horasTrabajaDia: horasTrabajaDia ?? this.horasTrabajaDia,
      idRazonTrabaja: idRazonTrabaja ?? this.idRazonTrabaja,
      otroRazonTrabaja: otroRazonTrabaja ?? this.otroRazonTrabaja,
      idGastoVestimentaPam: idGastoVestimentaPam ?? this.idGastoVestimentaPam,
      valorVestimentaPam: valorVestimentaPam ?? this.valorVestimentaPam,
      idGastoSaludPam: idGastoSaludPam ?? this.idGastoSaludPam,
      valorGastoSaludPam: valorGastoSaludPam ?? this.valorGastoSaludPam,
      idAlimentacionPam: idAlimentacionPam ?? this.idAlimentacionPam,
      valorAlimentacionPam: valorAlimentacionPam ?? this.valorAlimentacionPam,
      idGastoAyudasTecnicasPam:
          idGastoAyudasTecnicasPam ?? this.idGastoAyudasTecnicasPam,
      valorAyudaTecnicasPam:
          valorAyudaTecnicasPam ?? this.valorAyudaTecnicasPam,
      idRequiereCuidados: idRequiereCuidados ?? this.idRequiereCuidados,
      idCuentaPersonaCuide: idCuentaPersonaCuide ?? this.idCuentaPersonaCuide,
      idQuienCuidadosDomicilio:
          idQuienCuidadosDomicilio ?? this.idQuienCuidadosDomicilio,
      otrosQuienCuidadosDom:
          otrosQuienCuidadosDom ?? this.otrosQuienCuidadosDom,
      idAyudaFamDinero: idAyudaFamDinero ?? this.idAyudaFamDinero,
      idAyudaFamComida: idAyudaFamComida ?? this.idAyudaFamComida,
      idAyudaFamRopa: idAyudaFamRopa ?? this.idAyudaFamRopa,
      idAyudaFamQuehaceres: idAyudaFamQuehaceres ?? this.idAyudaFamQuehaceres,
      idAyudaFamCuidadoPersonal:
          idAyudaFamCuidadoPersonal ?? this.idAyudaFamCuidadoPersonal,
      idAyudaFamTransporte: idAyudaFamTransporte ?? this.idAyudaFamTransporte,
      idAyudaFamEntretenimiento:
          idAyudaFamEntretenimiento ?? this.idAyudaFamEntretenimiento,
      idAyudaFamCompania: idAyudaFamCompania ?? this.idAyudaFamCompania,
      idAyudaFamNinguna: idAyudaFamNinguna ?? this.idAyudaFamNinguna,
      idAyudaFamOtro: idAyudaFamOtro ?? this.idAyudaFamOtro,
      cualAyudaFamOtro: cualAyudaFamOtro ?? this.cualAyudaFamOtro,
      idFrecuenciaAyudaFam: idFrecuenciaAyudaFam ?? this.idFrecuenciaAyudaFam,
      idPamCuidaPersonas: idPamCuidaPersonas ?? this.idPamCuidaPersonas,
      cuantosNnPamCuida: cuantosNnPamCuida ?? this.cuantosNnPamCuida,
      cuantosAdolescentesPamCuida:
          cuantosAdolescentesPamCuida ?? this.cuantosAdolescentesPamCuida,
      cuantosPcdPamCuida: cuantosPcdPamCuida ?? this.cuantosPcdPamCuida,
      cuantosPamCuida: cuantosPamCuida ?? this.cuantosPamCuida,
      cuantosOtrosPamCuida: cuantosOtrosPamCuida ?? this.cuantosOtrosPamCuida,
      cualesOtrosPamCuida: cualesOtrosPamCuida ?? this.cualesOtrosPamCuida,
      cuantosMedicamentosUtilizaPam:
          cuantosMedicamentosUtilizaPam ?? this.cuantosMedicamentosUtilizaPam,
      cuantasVecesCaidoPamSeisMeses:
          cuantasVecesCaidoPamSeisMeses ?? this.cuantasVecesCaidoPamSeisMeses,
      idProblemasDientesPamDoceMeses:
          idProblemasDientesPamDoceMeses ?? this.idProblemasDientesPamDoceMeses,
      idComeTresComidasDiarias:
          idComeTresComidasDiarias ?? this.idComeTresComidasDiarias,
      idSindromeGolondrina: idSindromeGolondrina ?? this.idSindromeGolondrina,
      numDomiciliosRota: numDomiciliosRota ?? this.numDomiciliosRota,
      tiempoPasaCadaDomicilio:
          tiempoPasaCadaDomicilio ?? this.tiempoPasaCadaDomicilio,
      idEnfermedadNeurodegenerativa:
          idEnfermedadNeurodegenerativa ?? this.idEnfermedadNeurodegenerativa,
      cualEnfermedadNeurodegenerativa:
          cualEnfermedadNeurodegenerativa ??
          this.cualEnfermedadNeurodegenerativa,
      otrosCualEnfermedadNeurodegenerativa:
          otrosCualEnfermedadNeurodegenerativa ??
          this.otrosCualEnfermedadNeurodegenerativa,
      idViviendaAccesibilidad:
          idViviendaAccesibilidad ?? this.idViviendaAccesibilidad,
      accesRampas: accesRampas ?? this.accesRampas,
      accesPasamanos: accesPasamanos ?? this.accesPasamanos,
      accesManija: accesManija ?? this.accesManija,
      accesAgarradera: accesAgarradera ?? this.accesAgarradera,
      accesVentilacion: accesVentilacion ?? this.accesVentilacion,
      accesIluminacion: accesIluminacion ?? this.accesIluminacion,
      accesTrasladoFacil: accesTrasladoFacil ?? this.accesTrasladoFacil,
    );
  }

  Map<String, dynamic> toJson() => {
    'idFichaPam': idFichaPam,
    'fechaNacimiento': fechaNacimiento,
    'idCedConDiscapacidad': idCedConDiscapacidad,
    'numeroCedula': numeroCedula,
    'porcentajeDiscapacidad': porcentajeDiscapacidad,
    'idEtnia': idEtnia,
    'idEtniaIndigena': idEtniaIndigena,
    'idIdioma': idIdioma,
    'idLenguaNativa': idLenguaNativa,
    'idInstruccion': idInstruccion,
    'idGrado': idGrado,
    'idTrabaja': idTrabaja,
    'idOcupacionLaboral': idOcupacionLaboral,
    'otroOcupacionLaboral': otroOcupacionLaboral,
    'diasTrabajaSemana': diasTrabajaSemana,
    'horasTrabajaDia': horasTrabajaDia,
    'idRazonTrabaja': idRazonTrabaja,
    'otroRazonTrabaja': otroRazonTrabaja,
    'idGastoVestimentaPam': idGastoVestimentaPam,
    'valorVestimentaPam': valorVestimentaPam,
    'idGastoSaludPam': idGastoSaludPam,
    'valorGastoSaludPam': valorGastoSaludPam,
    'idAlimentacionPam': idAlimentacionPam,
    'valorAlimentacionPam': valorAlimentacionPam,
    'idGastoAyudasTecnicasPam': idGastoAyudasTecnicasPam,
    'valorAyudaTecnicasPam': valorAyudaTecnicasPam,
    'idRequiereCuidados': idRequiereCuidados,
    'idCuentaPersonaCuide': idCuentaPersonaCuide,
    'idQuienCuidadosDomicilio': idQuienCuidadosDomicilio,
    'otrosQuienCuidadosDom': otrosQuienCuidadosDom,
    'idAyudaFamDinero': idAyudaFamDinero,
    'idAyudaFamComida': idAyudaFamComida,
    'idAyudaFamRopa': idAyudaFamRopa,
    'idAyudaFamQuehaceres': idAyudaFamQuehaceres,
    'idAyudaFamCuidadoPersonal': idAyudaFamCuidadoPersonal,
    'idAyudaFamTransporte': idAyudaFamTransporte,
    'idAyudaFamEntretenimiento': idAyudaFamEntretenimiento,
    'idAyudaFamCompania': idAyudaFamCompania,
    'idAyudaFamNinguna': idAyudaFamNinguna,
    'idAyudaFamOtro': idAyudaFamOtro,
    'cualAyudaFamOtro': cualAyudaFamOtro,
    'idFrecuenciaAyudaFam': idFrecuenciaAyudaFam,
    'idPamCuidaPersonas': idPamCuidaPersonas,
    'cuantosNnPamCuida': cuantosNnPamCuida,
    'cuantosAdolescentesPamCuida': cuantosAdolescentesPamCuida,
    'cuantosPcdPamCuida': cuantosPcdPamCuida,
    'cuantosPamCuida': cuantosPamCuida,
    'cuantosOtrosPamCuida': cuantosOtrosPamCuida,
    'cualesOtrosPamCuida': cualesOtrosPamCuida,
    'cuantosMedicamentosUtilizaPam': cuantosMedicamentosUtilizaPam,
    'cuantasVecesCaidoPamSeisMeses': cuantasVecesCaidoPamSeisMeses,
    'idProblemasDientesPamDoceMeses': idProblemasDientesPamDoceMeses,
    'idComeTresComidasDiarias': idComeTresComidasDiarias,
    'idSindromeGolondrina': idSindromeGolondrina,
    'numDomiciliosRota': numDomiciliosRota,
    'tiempoPasaCadaDomicilio': tiempoPasaCadaDomicilio,
    'idEnfermedadNeurodegenerativa': idEnfermedadNeurodegenerativa,
    'cualEnfermedadNeurodegenerativa': cualEnfermedadNeurodegenerativa,
    'otrosCualEnfermedadNeurodegenerativa':
        otrosCualEnfermedadNeurodegenerativa,
    'idViviendaAccesibilidad': idViviendaAccesibilidad,
    'accesRampas': accesRampas,
    'accesPasamanos': accesPasamanos,
    'accesManija': accesManija,
    'accesAgarradera': accesAgarradera,
    'accesVentilacion': accesVentilacion,
    'accesIluminacion': accesIluminacion,
    'accesTrasladoFacil': accesTrasladoFacil,
  };

  static FichaPamDb fromJson(Map<String, dynamic> json) {
    return FichaPamDb(
      idFichaPam: (json['idFichaPam'] as String?) ?? const Uuid().v4(),
      fechaNacimiento: json['fechaNacimiento'] as String?,
      idCedConDiscapacidad: json['idCedConDiscapacidad'] as String?,
      numeroCedula: json['numeroCedula'] as String?,
      porcentajeDiscapacidad: json['porcentajeDiscapacidad'] as String?,
      idEtnia: json['idEtnia'] as String?,
      idEtniaIndigena: json['idEtniaIndigena'] as String?,
      idIdioma: json['idIdioma'] as String?,
      idLenguaNativa: json['idLenguaNativa'] as String?,
      idInstruccion: json['idInstruccion'] as String?,
      idGrado: json['idGrado'] as String?,
      idTrabaja: json['idTrabaja'] as String?,
      idOcupacionLaboral: json['idOcupacionLaboral'] as String?,
      otroOcupacionLaboral: json['otroOcupacionLaboral'] as String?,
      diasTrabajaSemana: json['diasTrabajaSemana'] as String?,
      horasTrabajaDia: json['horasTrabajaDia'] as String?,
      idRazonTrabaja: json['idRazonTrabaja'] as String?,
      otroRazonTrabaja: json['otroRazonTrabaja'] as String?,
      idGastoVestimentaPam: json['idGastoVestimentaPam'] as String?,
      valorVestimentaPam: json['valorVestimentaPam'] as String?,
      idGastoSaludPam: json['idGastoSaludPam'] as String?,
      valorGastoSaludPam: json['valorGastoSaludPam'] as String?,
      idAlimentacionPam: json['idAlimentacionPam'] as String?,
      valorAlimentacionPam: json['valorAlimentacionPam'] as String?,
      idGastoAyudasTecnicasPam: json['idGastoAyudasTecnicasPam'] as String?,
      valorAyudaTecnicasPam: json['valorAyudaTecnicasPam'] as String?,
      idRequiereCuidados: json['idRequiereCuidados'] as String?,
      idCuentaPersonaCuide: json['idCuentaPersonaCuide'] as String?,
      idQuienCuidadosDomicilio: json['idQuienCuidadosDomicilio'] as String?,
      otrosQuienCuidadosDom: json['otrosQuienCuidadosDom'] as String?,
      idAyudaFamDinero: json['idAyudaFamDinero'] as String?,
      idAyudaFamComida: json['idAyudaFamComida'] as String?,
      idAyudaFamRopa: json['idAyudaFamRopa'] as String?,
      idAyudaFamQuehaceres: json['idAyudaFamQuehaceres'] as String?,
      idAyudaFamCuidadoPersonal: json['idAyudaFamCuidadoPersonal'] as String?,
      idAyudaFamTransporte: json['idAyudaFamTransporte'] as String?,
      idAyudaFamEntretenimiento: json['idAyudaFamEntretenimiento'] as String?,
      idAyudaFamCompania: json['idAyudaFamCompania'] as String?,
      idAyudaFamNinguna: json['idAyudaFamNinguna'] as String?,
      idAyudaFamOtro: json['idAyudaFamOtro'] as String?,
      cualAyudaFamOtro: json['cualAyudaFamOtro'] as String?,
      idFrecuenciaAyudaFam: json['idFrecuenciaAyudaFam'] as String?,
      idPamCuidaPersonas: json['idPamCuidaPersonas'] as String?,
      cuantosNnPamCuida: json['cuantosNnPamCuida'] as String?,
      cuantosAdolescentesPamCuida:
          json['cuantosAdolescentesPamCuida'] as String?,
      cuantosPcdPamCuida: json['cuantosPcdPamCuida'] as String?,
      cuantosPamCuida: json['cuantosPamCuida'] as String?,
      cuantosOtrosPamCuida: json['cuantosOtrosPamCuida'] as String?,
      cualesOtrosPamCuida: json['cualesOtrosPamCuida'] as String?,
      cuantosMedicamentosUtilizaPam:
          json['cuantosMedicamentosUtilizaPam'] as String?,
      cuantasVecesCaidoPamSeisMeses:
          json['cuantasVecesCaidoPamSeisMeses'] as String?,
      idProblemasDientesPamDoceMeses:
          json['idProblemasDientesPamDoceMeses'] as String?,
      idComeTresComidasDiarias: json['idComeTresComidasDiarias'] as String?,
      idSindromeGolondrina: json['idSindromeGolondrina'] as String?,
      numDomiciliosRota: json['numDomiciliosRota'] as String?,
      tiempoPasaCadaDomicilio: json['tiempoPasaCadaDomicilio'] as String?,
      idEnfermedadNeurodegenerativa:
          json['idEnfermedadNeurodegenerativa'] as String?,
      cualEnfermedadNeurodegenerativa:
          json['cualEnfermedadNeurodegenerativa'] as String?,
      otrosCualEnfermedadNeurodegenerativa:
          json['otrosCualEnfermedadNeurodegenerativa'] as String?,
      idViviendaAccesibilidad: json['idViviendaAccesibilidad'] as String?,
      accesRampas: json['accesRampas'] as String?,
      accesPasamanos: json['accesPasamanos'] as String?,
      accesManija: json['accesManija'] as String?,
      accesAgarradera: json['accesAgarradera'] as String?,
      accesVentilacion: json['accesVentilacion'] as String?,
      accesIluminacion: json['accesIluminacion'] as String?,
      accesTrasladoFacil: json['accesTrasladoFacil'] as String?,
    );
  }
}
