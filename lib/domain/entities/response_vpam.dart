class ResponseVPAM {
  final int idFicha;
  final Summary summary;
  final Map<String, dynamic> indexScores;
  final Map<String, dynamic> blockScores;
  final PcaOls? pcaOls;
  final String? tsUtc;

  ResponseVPAM({
    required this.idFicha,
    required this.summary,
    required this.indexScores,
    required this.blockScores,
    this.pcaOls,
    this.tsUtc,
  });

  factory ResponseVPAM.fromJson(Map<String, dynamic> json) {
    return ResponseVPAM(
      idFicha: json['id_ficha'],
      summary: Summary.fromJson(json['summary']),
      indexScores: Map<String, dynamic>.from(json['index_scores']),
      blockScores: Map<String, dynamic>.from(json['block_scores']),
      pcaOls: json['pca_ols'] != null ? PcaOls.fromJson(json['pca_ols']) : null,
      tsUtc: json['_ts_utc'],
    );
  }
}

class Summary {
  final double vulnerabilidadGlobalNormalizada;
  final String nivelVulnerabilidad;
  final double carenciasNormalizadas;
  final double riesgoFuturoNormalizado;
  final double riesgoDependenciaNormalizado;
  final List<Alerta> alertas;

  Summary({
    required this.vulnerabilidadGlobalNormalizada,
    required this.nivelVulnerabilidad,
    required this.carenciasNormalizadas,
    required this.riesgoFuturoNormalizado,
    required this.riesgoDependenciaNormalizado,
    required this.alertas,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      vulnerabilidadGlobalNormalizada: json['vulnerabilidad_global_normalizada']
          .toDouble(),
      nivelVulnerabilidad: json['nivel_vulnerabilidad'],
      carenciasNormalizadas: json['carencias_normalizadas'].toDouble(),
      riesgoFuturoNormalizado: json['riesgo_futuro_normalizado'].toDouble(),
      riesgoDependenciaNormalizado: json['riesgo_dependencia_normalizado']
          .toDouble(),
      alertas: (json['alertas'] as List)
          .map((a) => Alerta.fromJson(a))
          .toList(),
    );
  }
}

class Alerta {
  final String id;
  final String tipo;
  final String mensaje;
  final String severidad;

  Alerta({
    required this.id,
    required this.tipo,
    required this.mensaje,
    required this.severidad,
  });

  factory Alerta.fromJson(Map<String, dynamic> json) {
    return Alerta(
      id: json['id'],
      tipo: json['tipo'],
      mensaje: json['mensaje'],
      severidad: json['severidad'],
    );
  }
}

class PcaOls {
  final String nivel;
  final double score0_100;

  PcaOls({required this.nivel, required this.score0_100});

  factory PcaOls.fromJson(Map<String, dynamic> json) {
    return PcaOls(
      nivel: json['nivel'],
      score0_100: json['score_0_100'].toDouble(),
    );
  }
}
