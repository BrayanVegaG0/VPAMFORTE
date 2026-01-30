class YesavagePamDb {
  final String idYesavagePam;
  final String? idYesavageUno;
  final String? idYesavageDos;
  final String? idYesavageTres;
  final String? idYesavageCuatro;
  final String? idYesavageCinco;
  final String? idYesavageSeis;
  final String? idYesavageSiete;
  final String? idYesavageOcho;
  final String? idYesavageNueve;
  final String? idYesavageDiez;
  final String? idYesavageOnce;
  final String? idYesavageDoce;
  final String? idYesavageTrece;
  final String? idYesavageCatorce;
  final String? idYesavageQuince;

  const YesavagePamDb({
    required this.idYesavagePam,
    this.idYesavageUno,
    this.idYesavageDos,
    this.idYesavageTres,
    this.idYesavageCuatro,
    this.idYesavageCinco,
    this.idYesavageSeis,
    this.idYesavageSiete,
    this.idYesavageOcho,
    this.idYesavageNueve,
    this.idYesavageDiez,
    this.idYesavageOnce,
    this.idYesavageDoce,
    this.idYesavageTrece,
    this.idYesavageCatorce,
    this.idYesavageQuince,
  });

  Map<String, dynamic> toJson() => {
    'idYesavagePam': idYesavagePam,
    'idYesavageUno': idYesavageUno,
    'idYesavageDos': idYesavageDos,
    'idYesavageTres': idYesavageTres,
    'idYesavageCuatro': idYesavageCuatro,
    'idYesavageCinco': idYesavageCinco,
    'idYesavageSeis': idYesavageSeis,
    'idYesavageSiete': idYesavageSiete,
    'idYesavageOcho': idYesavageOcho,
    'idYesavageNueve': idYesavageNueve,
    'idYesavageDiez': idYesavageDiez,
    'idYesavageOnce': idYesavageOnce,
    'idYesavageDoce': idYesavageDoce,
    'idYesavageTrece': idYesavageTrece,
    'idYesavageCatorce': idYesavageCatorce,
    'idYesavageQuince': idYesavageQuince,
  };

  static YesavagePamDb fromJson(Map<String, dynamic> json) {
    return YesavagePamDb(
      idYesavagePam: json['idYesavagePam'] as String,
      idYesavageUno: json['idYesavageUno'] as String?,
      idYesavageDos: json['idYesavageDos'] as String?,
      idYesavageTres: json['idYesavageTres'] as String?,
      idYesavageCuatro: json['idYesavageCuatro'] as String?,
      idYesavageCinco: json['idYesavageCinco'] as String?,
      idYesavageSeis: json['idYesavageSeis'] as String?,
      idYesavageSiete: json['idYesavageSiete'] as String?,
      idYesavageOcho: json['idYesavageOcho'] as String?,
      idYesavageNueve: json['idYesavageNueve'] as String?,
      idYesavageDiez: json['idYesavageDiez'] as String?,
      idYesavageOnce: json['idYesavageOnce'] as String?,
      idYesavageDoce: json['idYesavageDoce'] as String?,
      idYesavageTrece: json['idYesavageTrece'] as String?,
      idYesavageCatorce: json['idYesavageCatorce'] as String?,
      idYesavageQuince: json['idYesavageQuince'] as String?,
    );
  }
}
