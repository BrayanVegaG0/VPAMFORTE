class IndiceBarthelDiscDb {
  final String idIndiceBarthelDisc;
  final String? idComer;
  final String? idTrasladoSillaCama;
  final String? idAseoPersonal;
  final String? idUsoRetrete;
  final String? idBaniarse;
  final String? idDesplazarse;
  final String? idSubirBajarEscaleras;
  final String? idVestirseDesvestirse;
  final String? idControlHeces;
  final String? idControlOrina;

  const IndiceBarthelDiscDb({
    required this.idIndiceBarthelDisc,
    this.idComer,
    this.idTrasladoSillaCama,
    this.idAseoPersonal,
    this.idUsoRetrete,
    this.idBaniarse,
    this.idDesplazarse,
    this.idSubirBajarEscaleras,
    this.idVestirseDesvestirse,
    this.idControlHeces,
    this.idControlOrina,
  });

  IndiceBarthelDiscDb copyWith({
    String? idIndiceBarthelDisc,
    String? idComer,
    String? idTrasladoSillaCama,
    String? idAseoPersonal,
    String? idUsoRetrete,
    String? idBaniarse,
    String? idDesplazarse,
    String? idSubirBajarEscaleras,
    String? idVestirseDesvestirse,
    String? idControlHeces,
    String? idControlOrina,
  }) {
    return IndiceBarthelDiscDb(
      idIndiceBarthelDisc: idIndiceBarthelDisc ?? this.idIndiceBarthelDisc,
      idComer: idComer ?? this.idComer,
      idTrasladoSillaCama: idTrasladoSillaCama ?? this.idTrasladoSillaCama,
      idAseoPersonal: idAseoPersonal ?? this.idAseoPersonal,
      idUsoRetrete: idUsoRetrete ?? this.idUsoRetrete,
      idBaniarse: idBaniarse ?? this.idBaniarse,
      idDesplazarse: idDesplazarse ?? this.idDesplazarse,
      idSubirBajarEscaleras:
          idSubirBajarEscaleras ?? this.idSubirBajarEscaleras,
      idVestirseDesvestirse:
          idVestirseDesvestirse ?? this.idVestirseDesvestirse,
      idControlHeces: idControlHeces ?? this.idControlHeces,
      idControlOrina: idControlOrina ?? this.idControlOrina,
    );
  }

  Map<String, dynamic> toJson() => {
    'idIndiceBarthelDisc': idIndiceBarthelDisc,
    'idComer': idComer,
    'idTrasladoSillaCama': idTrasladoSillaCama,
    'idAseoPersonal': idAseoPersonal,
    'idUsoRetrete': idUsoRetrete,
    'idBaniarse': idBaniarse,
    'idDesplazarse': idDesplazarse,
    'idSubirBajarEscaleras': idSubirBajarEscaleras,
    'idVestirseDesvestirse': idVestirseDesvestirse,
    'idControlHeces': idControlHeces,
    'idControlOrina': idControlOrina,
  };

  static IndiceBarthelDiscDb fromJson(Map<String, dynamic> json) {
    return IndiceBarthelDiscDb(
      idIndiceBarthelDisc: json['idIndiceBarthelDisc'] as String,
      idComer: json['idComer'] as String?,
      idTrasladoSillaCama: json['idTrasladoSillaCama'] as String?,
      idAseoPersonal: json['idAseoPersonal'] as String?,
      idUsoRetrete: json['idUsoRetrete'] as String?,
      idBaniarse: json['idBaniarse'] as String?,
      idDesplazarse: json['idDesplazarse'] as String?,
      idSubirBajarEscaleras: json['idSubirBajarEscaleras'] as String?,
      idVestirseDesvestirse: json['idVestirseDesvestirse'] as String?,
      idControlHeces: json['idControlHeces'] as String?,
      idControlOrina: json['idControlOrina'] as String?,
    );
  }
}
