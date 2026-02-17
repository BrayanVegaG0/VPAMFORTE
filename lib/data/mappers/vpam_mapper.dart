import 'package:ficha_vulnerabilidad/domain/entities/ficha_vpam.dart';

class VpamMapper {
  static FichaVPAM fromAnswers(Map<String, dynamic> answers) {
    // Nota: El backend espera tipos específicos (int, double, String, List, Map)
    // Extraemos los valores de las respuestas de la encuesta (SurveySubmission.answers)

    return FichaVPAM(
      idFicha: _toInt(answers['id_ficha']) ?? 0,
      ingresoTotalMensual: _toDouble(answers['ingresosM']) ?? 0.0,
      miembrosHogar: _toInt(answers['miembros_hogar']) ?? 1,
      origenIngresoFamiliar: _toList(answers['ingresoFamiliarM']),
      apoyoEconomicoEstado: ApoyoEconomicoEstado(
        respuestaPrincipal: _toSiNo(answers['apoyoEconomicoM']),
        detalleBeneficios: _toList(answers['tipoApoyoEconomicoM']),
      ),
      gastoSalud: _toDouble(answers['valorGastoSaludPam']) ?? 0.0,
      gastoAlimentacion: _toDouble(answers['valorAlimentacionPam']) ?? 0.0,
      gastoVestimenta: _toDouble(answers['valorVestimentaPam']) ?? 0.0,
      gastoAyudasTecnicas: _toDouble(answers['valorAyudaTecnicasPam']) ?? 0.0,
      pisoVivienda: _toString(answers['P1_piso_vivienda']) ?? 'CEMENTO',
      paredVivienda: _toString(answers['P2_pared_vivienda']) ?? 'BLOQUE',
      techoVivienda: _toString(answers['P3_techo_vivienda']) ?? 'ZINC',
      serviciosAgua: _toInt(answers['idAguaPotable']) ?? 1,
      serviciosBasicos: ServiciosBasicos(
        luz: _has(answers['ViviendaServBasicos'], '1'),
        agua: _has(answers['ViviendaServBasicos'], '2'),
        alcantarillado: _has(answers['ViviendaServBasicos'], '3'),
        telefono: answers['telefonoM'] != null,
        internet: _has(answers['ViviendaServBasicos'], '5'),
      ),
      diagnosticoNeurodegenerativo: _toBoolInt(
        answers['id_enfermedad_neurodegenerativa'],
      ),
      ayudasTecnicas: _toAyudasTecnicasMap(answers['idUtilizaAyudasTecnicasM']),
      atencionMedicaFrecuencia: _toAtencionFrecuencia(
        answers['idFrecuenciaAtencionM'],
      ),
      lugarAtencionMedica: [_toLugarAtencion(answers['58'])],
      consumoSustancias: _toConsumoSustanciasMap(answers),
      serviciosAtencion: _toList(answers['servicioAtencion']),
      ocupacionLaboral: _toString(answers['idOcupacionLaboral']) ?? 'NINGUNO',
    );
  }

  // ===== Helpers =====

  static Map<String, bool> _toAyudasTecnicasMap(dynamic v) {
    final list = _toList(v);
    // Mapeo de IDs de la encuesta a nombres esperados por el backend (según process_data.py)
    return {
      'BASTON': list.contains('1'),
      'LENTES': list.contains('2'),
      'AUDIFONOS': list.contains('3'),
      'SILLA_RUEDAS': list.contains('4'),
      'ANDADOR': list.contains('5'),
      'PROTESIS': list.contains('6'),
    };
  }

  static Map<String, String> _toConsumoSustanciasMap(Map<String, dynamic> a) {
    return {
      'ALCOHOL': _toFreq(a['AlcoholYesNo'], a['AlcoholFrecuencia']),
      'TABACO': _toFreq(a['TabacoYesNo'], a['TabacoFrecuencia']),
      'DROGAS': _toFreq(a['DrogasYesNo'], a['DrogasFrecuencia']),
    };
  }

  static String _toFreq(dynamic yesNo, dynamic freq) {
    if (_toBoolInt(yesNo) == 0) return 'NO';
    final f = freq?.toString();
    switch (f) {
      case '1':
        return 'RARA_VEZ';
      case '2':
        return 'MES';
      case '3':
        return 'SEMANA';
      case '4':
        return 'DIARIO';
      default:
        return 'RARA_VEZ';
    }
  }

  static int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }

  static double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString());
  }

  static String? _toString(dynamic v) {
    return v?.toString();
  }

  static List<String> _toList(dynamic v) {
    if (v == null) return [];
    if (v is List) return v.map((e) => e.toString()).toList();
    if (v is String) return v.split(',').map((e) => e.trim()).toList();
    return [v.toString()];
  }

  static String _toSiNo(dynamic v) {
    if (v == null) return 'NO';
    final s = v.toString().toLowerCase();
    if (s == '1' || s == 'true' || s == 'si' || s == 'sí') return 'SI';
    return 'NO';
  }

  static int _toBoolInt(dynamic v) {
    if (v == null) return 0;
    if (v is bool) return v ? 1 : 0;
    final s = v.toString().toLowerCase();
    if (s == '1' || s == 'true' || s == 'si' || s == 'sí') return 1;
    return 0;
  }

  static bool _has(dynamic v, String optionId) {
    if (v == null) return false;
    if (v is List) return v.map((e) => e.toString()).contains(optionId);
    return v.toString().split(',').map((e) => e.trim()).contains(optionId);
  }

  static String _toAtencionFrecuencia(dynamic v) {
    final s = v?.toString();
    switch (s) {
      case '1':
        return 'MENSUAL';
      case '2':
        return 'BIMENSUAL';
      case '3':
        return 'TRIMESTRAL';
      case '4':
        return 'ANUAL';
      default:
        return 'NO_REGISTRA';
    }
  }

  static String _toLugarAtencion(dynamic v) {
    final s = v?.toString();
    switch (s) {
      case '1':
        return 'CENTRO_SALUD'; // Público
      case '2':
        return 'PRIVADO';
      default:
        return 'NINGUNO';
    }
  }
}
