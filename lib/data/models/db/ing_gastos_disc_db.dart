import 'package:uuid/uuid.dart';

class IngGastosDiscDb {
  final String idIngGastosDisc;

  final String? ingresos;
  final String? fuenteTrabajoDependencia;
  final String? fuenteTrabajoPropio;
  final String? pensionJubilacion;
  final String? remesasNacInt;
  final String? pensionAlimenticia;
  final String? truequePartir;
  final String? fuenteMontepio;
  final String? fuenteOtros;
  final String? especifOtroTipoIngreso;
  final String? idPersonaGeneraIngreso;
  final String? apoyoEconomico;

  final String? bonoJoaquinGL;
  final String? bonoVariable;
  final String? bonoMejoresAnios;
  final String? bonoDesaHumano;
  final String? pensionAm;
  final String? pensionPcd;
  final String? pensionTodaVida;
  final String? coberturaContin;
  final String? bonoOrfandad;
  final String? idBonoOtro;
  final String? bonoOtro;

  IngGastosDiscDb({
    String? idIngGastosDisc,
    this.ingresos,
    this.fuenteTrabajoDependencia,
    this.fuenteTrabajoPropio,
    this.pensionJubilacion,
    this.remesasNacInt,
    this.pensionAlimenticia,
    this.truequePartir,
    this.fuenteMontepio,
    this.fuenteOtros,
    this.especifOtroTipoIngreso,
    this.idPersonaGeneraIngreso,
    this.apoyoEconomico,
    this.bonoJoaquinGL,
    this.bonoVariable,
    this.bonoMejoresAnios,
    this.bonoDesaHumano,
    this.pensionAm,
    this.pensionPcd,
    this.pensionTodaVida,
    this.coberturaContin,
    this.bonoOrfandad,
    this.idBonoOtro,
    this.bonoOtro,
  }) : idIngGastosDisc = idIngGastosDisc ?? const Uuid().v4();

  static IngGastosDiscDb empty() => IngGastosDiscDb();

  IngGastosDiscDb copyWith({
    String? ingresos,
    String? fuenteTrabajoDependencia,
    String? fuenteTrabajoPropio,
    String? pensionJubilacion,
    String? remesasNacInt,
    String? pensionAlimenticia,
    String? truequePartir,
    String? fuenteMontepio,
    String? fuenteOtros,
    String? especifOtroTipoIngreso,
    String? idPersonaGeneraIngreso,
    String? apoyoEconomico,
    String? bonoJoaquinGL,
    String? bonoVariable,
    String? bonoMejoresAnios,
    String? bonoDesaHumano,
    String? pensionAm,
    String? pensionPcd,
    String? pensionTodaVida,
    String? coberturaContin,
    String? bonoOrfandad,
    String? idBonoOtro,
    String? bonoOtro,
  }) {
    return IngGastosDiscDb(
      idIngGastosDisc: idIngGastosDisc,
      ingresos: ingresos ?? this.ingresos,
      fuenteTrabajoDependencia: fuenteTrabajoDependencia ?? this.fuenteTrabajoDependencia,
      fuenteTrabajoPropio: fuenteTrabajoPropio ?? this.fuenteTrabajoPropio,
      pensionJubilacion: pensionJubilacion ?? this.pensionJubilacion,
      remesasNacInt: remesasNacInt ?? this.remesasNacInt,
      pensionAlimenticia: pensionAlimenticia ?? this.pensionAlimenticia,
      truequePartir: truequePartir ?? this.truequePartir,
      fuenteMontepio: fuenteMontepio ?? this.fuenteMontepio,
      fuenteOtros: fuenteOtros ?? this.fuenteOtros,
      especifOtroTipoIngreso: especifOtroTipoIngreso ?? this.especifOtroTipoIngreso,
      idPersonaGeneraIngreso: idPersonaGeneraIngreso ?? this.idPersonaGeneraIngreso,
      apoyoEconomico: apoyoEconomico ?? this.apoyoEconomico,
      bonoJoaquinGL: bonoJoaquinGL ?? this.bonoJoaquinGL,
      bonoVariable: bonoVariable ?? this.bonoVariable,
      bonoMejoresAnios: bonoMejoresAnios ?? this.bonoMejoresAnios,
      bonoDesaHumano: bonoDesaHumano ?? this.bonoDesaHumano,
      pensionAm: pensionAm ?? this.pensionAm,
      pensionPcd: pensionPcd ?? this.pensionPcd,
      pensionTodaVida: pensionTodaVida ?? this.pensionTodaVida,
      coberturaContin: coberturaContin ?? this.coberturaContin,
      bonoOrfandad: bonoOrfandad ?? this.bonoOrfandad,
      idBonoOtro: idBonoOtro ?? this.idBonoOtro,
      bonoOtro: bonoOtro ?? this.bonoOtro,
    );
  }

  Map<String, dynamic> toJson() => {
    // contrato/base:
    'id_ing_gastos_disc': idIngGastosDisc,
    'ingresos': ingresos,
    'fuente_trabajo_ dependencia': fuenteTrabajoDependencia, // ojo: conserva el nombre EXACTO que enviaste
    'fuente_trabajo_propio': fuenteTrabajoPropio,
    'pension_jubilacion': pensionJubilacion,
    'remesas_nac_int': remesasNacInt,
    'pension_alimenticia': pensionAlimenticia,
    'trueque_partir': truequePartir,
    'fuente_montepio': fuenteMontepio,
    'fuente_otros': fuenteOtros,
    'especif_otro_tipo_ingreso': especifOtroTipoIngreso,
    'id_persona_genera_ingreso': idPersonaGeneraIngreso,
    'apoyo_economico': apoyoEconomico,
    'bono_joaquinGL': bonoJoaquinGL,
    'bono_variable': bonoVariable,
    'bono_mejores_anios': bonoMejoresAnios,
    'bono_desa_humano': bonoDesaHumano,
    'pension_am': pensionAm,
    'pension_pcd': pensionPcd,
    'pension_toda_vida': pensionTodaVida,
    'cobertura_contin': coberturaContin,
    'bono_orfandad': bonoOrfandad,
    'id_bono_otro': idBonoOtro,
    'bono_otro': bonoOtro,
  };

  static IngGastosDiscDb fromJson(Map<String, dynamic> json) {
    return IngGastosDiscDb(
      idIngGastosDisc: (json['id_ing_gastos_disc'] as String?) ?? const Uuid().v4(),
      ingresos: json['ingresos'] as String?,
      fuenteTrabajoDependencia: json['fuente_trabajo_ dependencia'] as String?,
      fuenteTrabajoPropio: json['fuente_trabajo_propio'] as String?,
      pensionJubilacion: json['pension_jubilacion'] as String?,
      remesasNacInt: json['remesas_nac_int'] as String?,
      pensionAlimenticia: json['pension_alimenticia'] as String?,
      truequePartir: json['trueque_partir'] as String?,
      fuenteMontepio: json['fuente_montepio'] as String?,
      fuenteOtros: json['fuente_otros'] as String?,
      especifOtroTipoIngreso: json['especif_otro_tipo_ingreso'] as String?,
      idPersonaGeneraIngreso: json['id_persona_genera_ingreso'] as String?,
      apoyoEconomico: json['apoyo_economico'] as String?,
      bonoJoaquinGL: json['bono_joaquinGL'] as String?,
      bonoVariable: json['bono_variable'] as String?,
      bonoMejoresAnios: json['bono_mejores_anios'] as String?,
      bonoDesaHumano: json['bono_desa_humano'] as String?,
      pensionAm: json['pension_am'] as String?,
      pensionPcd: json['pension_pcd'] as String?,
      pensionTodaVida: json['pension_toda_vida'] as String?,
      coberturaContin: json['cobertura_contin'] as String?,
      bonoOrfandad: json['bono_orfandad'] as String?,
      idBonoOtro: json['id_bono_otro'] as String?,
      bonoOtro: json['bono_otro'] as String?,
    );
  }
}
