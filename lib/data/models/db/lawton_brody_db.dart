class LawtonBrodyDb {
  final String idLawtonBrody;
  final String? idCapacidadTelefono;
  final String? idHacerCompras;
  final String? idPrepararComida;
  final String? idCuidadoCasa;
  final String? idLavadoRopa;
  final String? idTransporte;
  final String? idMedicacion;
  final String? idUtilizarDinero;

  const LawtonBrodyDb({
    required this.idLawtonBrody,
    this.idCapacidadTelefono,
    this.idHacerCompras,
    this.idPrepararComida,
    this.idCuidadoCasa,
    this.idLavadoRopa,
    this.idTransporte,
    this.idMedicacion,
    this.idUtilizarDinero,
  });

  LawtonBrodyDb copyWith({
    String? idLawtonBrody,
    String? idCapacidadTelefono,
    String? idHacerCompras,
    String? idPrepararComida,
    String? idCuidadoCasa,
    String? idLavadoRopa,
    String? idTransporte,
    String? idMedicacion,
    String? idUtilizarDinero,
  }) {
    return LawtonBrodyDb(
      idLawtonBrody: idLawtonBrody ?? this.idLawtonBrody,
      idCapacidadTelefono: idCapacidadTelefono ?? this.idCapacidadTelefono,
      idHacerCompras: idHacerCompras ?? this.idHacerCompras,
      idPrepararComida: idPrepararComida ?? this.idPrepararComida,
      idCuidadoCasa: idCuidadoCasa ?? this.idCuidadoCasa,
      idLavadoRopa: idLavadoRopa ?? this.idLavadoRopa,
      idTransporte: idTransporte ?? this.idTransporte,
      idMedicacion: idMedicacion ?? this.idMedicacion,
      idUtilizarDinero: idUtilizarDinero ?? this.idUtilizarDinero,
    );
  }

  Map<String, dynamic> toJson() => {
    'idLawtonBrody': idLawtonBrody,
    'idCapacidadTelefono': idCapacidadTelefono,
    'idHacerCompras': idHacerCompras,
    'idPrepararComida': idPrepararComida,
    'idCuidadoCasa': idCuidadoCasa,
    'idLavadoRopa': idLavadoRopa,
    'idTransporte': idTransporte,
    'idMedicacion': idMedicacion,
    'idUtilizarDinero': idUtilizarDinero,
  };

  static LawtonBrodyDb fromJson(Map<String, dynamic> json) {
    return LawtonBrodyDb(
      idLawtonBrody: json['idLawtonBrody'] as String,
      idCapacidadTelefono: json['idCapacidadTelefono'] as String?,
      idHacerCompras: json['idHacerCompras'] as String?,
      idPrepararComida: json['idPrepararComida'] as String?,
      idCuidadoCasa: json['idCuidadoCasa'] as String?,
      idLavadoRopa: json['idLavadoRopa'] as String?,
      idTransporte: json['idTransporte'] as String?,
      idMedicacion: json['idMedicacion'] as String?,
      idUtilizarDinero: json['idUtilizarDinero'] as String?,
    );
  }
}
