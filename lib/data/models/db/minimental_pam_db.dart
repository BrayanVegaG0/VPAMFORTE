class MiniMentalPamDb {
  final String idMinimentalPam;
  // Tiempo
  final String? idTiempoUno;
  final String? idTiempoDos;
  final String? idTiempoTres;
  final String? idTiempoCuatro;
  final String? idTiempoCinco;
  final String? totalTiempo;
  // Espacio
  final String? idEspacioUno;
  final String? idEspacioDos;
  final String? idEspacioTres;
  final String? idEspacioCuatro;
  final String? idEspacioCinco;
  final String? totalEspacio;
  // Memoria
  final String? idMemoriaUno;
  final String? idMemoriaDos;
  final String? idMemoriaTres;
  final String? totalMemoria;
  // Calculo
  final String? idCalculoUno;
  final String? idCalculoDos;
  final String? idCalculoTres;
  final String? idCalculoCuatro;
  final String? idCalculoCinco;
  final String? totalCalculo;
  // Memoria Diferida
  final String? idMemoriaDifUno;
  final String? idMemoriaDifDos;
  final String? idMemoriaDifTres;
  final String? totalMemoriaDif;
  // Denominacion
  final String? idDenominacionUno;
  final String? idDenominacionDos;
  final String? totalDenominacion;
  // Repeticion
  final String? idRepeticionUno;
  final String? totalRepeticion;
  // Comprension
  final String? idComprensionUno;
  final String? idComprensionDos;
  final String? idComprensionTres;
  final String? totalComprension;
  // Lectura
  final String? idLecturaUno;
  final String? totalLectura;
  // Escritura
  final String? idEscrituraUno;
  final String? totalEscritura;
  // Copia
  final String? idCopiaUno;
  final String? totalCopia;
  // Total
  final String? totalTest;

  const MiniMentalPamDb({
    required this.idMinimentalPam,
    this.idTiempoUno,
    this.idTiempoDos,
    this.idTiempoTres,
    this.idTiempoCuatro,
    this.idTiempoCinco,
    this.totalTiempo,
    this.idEspacioUno,
    this.idEspacioDos,
    this.idEspacioTres,
    this.idEspacioCuatro,
    this.idEspacioCinco,
    this.totalEspacio,
    this.idMemoriaUno,
    this.idMemoriaDos,
    this.idMemoriaTres,
    this.totalMemoria,
    this.idCalculoUno,
    this.idCalculoDos,
    this.idCalculoTres,
    this.idCalculoCuatro,
    this.idCalculoCinco,
    this.totalCalculo,
    this.idMemoriaDifUno,
    this.idMemoriaDifDos,
    this.idMemoriaDifTres,
    this.totalMemoriaDif,
    this.idDenominacionUno,
    this.idDenominacionDos,
    this.totalDenominacion,
    this.idRepeticionUno,
    this.totalRepeticion,
    this.idComprensionUno,
    this.idComprensionDos,
    this.idComprensionTres,
    this.totalComprension,
    this.idLecturaUno,
    this.totalLectura,
    this.idEscrituraUno,
    this.totalEscritura,
    this.idCopiaUno,
    this.totalCopia,
    this.totalTest,
  });

  Map<String, dynamic> toJson() => {
    'idMinimentalPam': idMinimentalPam,
    'idTiempoUno': idTiempoUno,
    'idTiempoDos': idTiempoDos,
    'idTiempoTres': idTiempoTres,
    'idTiempoCuatro': idTiempoCuatro,
    'idTiempoCinco': idTiempoCinco,
    'totalTiempo': totalTiempo,
    'idEspacioUno': idEspacioUno,
    'idEspacioDos': idEspacioDos,
    'idEspacioTres': idEspacioTres,
    'idEspacioCuatro': idEspacioCuatro,
    'idEspacioCinco': idEspacioCinco,
    'totalEspacio': totalEspacio,
    'idMemoriaUno': idMemoriaUno,
    'idMemoriaDos': idMemoriaDos,
    'idMemoriaTres': idMemoriaTres,
    'totalMemoria': totalMemoria,
    'idCalculoUno': idCalculoUno,
    'idCalculoDos': idCalculoDos,
    'idCalculoTres': idCalculoTres,
    'idCalculoCuatro': idCalculoCuatro,
    'idCalculoCinco': idCalculoCinco,
    'totalCalculo': totalCalculo,
    'idMemoriaDifUno': idMemoriaDifUno,
    'idMemoriaDifDos': idMemoriaDifDos,
    'idMemoriaDifTres': idMemoriaDifTres,
    'totalMemoriaDif': totalMemoriaDif,
    'idDenominacionUno': idDenominacionUno,
    'idDenominacionDos': idDenominacionDos,
    'totalDenominacion': totalDenominacion,
    'idRepeticionUno': idRepeticionUno,
    'totalRepeticion': totalRepeticion,
    'idComprensionUno': idComprensionUno,
    'idComprensionDos': idComprensionDos,
    'idComprensionTres': idComprensionTres,
    'totalComprension': totalComprension,
    'idLecturaUno': idLecturaUno,
    'totalLectura': totalLectura,
    'idEscrituraUno': idEscrituraUno,
    'totalEscritura': totalEscritura,
    'idCopiaUno': idCopiaUno,
    'totalCopia': totalCopia,
    'totalTest': totalTest,
  };

  static MiniMentalPamDb fromJson(Map<String, dynamic> json) {
    return MiniMentalPamDb(
      idMinimentalPam: json['idMinimentalPam'] as String,
      idTiempoUno: json['idTiempoUno'] as String?,
      idTiempoDos: json['idTiempoDos'] as String?,
      idTiempoTres: json['idTiempoTres'] as String?,
      idTiempoCuatro: json['idTiempoCuatro'] as String?,
      idTiempoCinco: json['idTiempoCinco'] as String?,
      totalTiempo: json['totalTiempo'] as String?,
      idEspacioUno: json['idEspacioUno'] as String?,
      idEspacioDos: json['idEspacioDos'] as String?,
      idEspacioTres: json['idEspacioTres'] as String?,
      idEspacioCuatro: json['idEspacioCuatro'] as String?,
      idEspacioCinco: json['idEspacioCinco'] as String?,
      totalEspacio: json['totalEspacio'] as String?,
      idMemoriaUno: json['idMemoriaUno'] as String?,
      idMemoriaDos: json['idMemoriaDos'] as String?,
      idMemoriaTres: json['idMemoriaTres'] as String?,
      totalMemoria: json['totalMemoria'] as String?,
      idCalculoUno: json['idCalculoUno'] as String?,
      idCalculoDos: json['idCalculoDos'] as String?,
      idCalculoTres: json['idCalculoTres'] as String?,
      idCalculoCuatro: json['idCalculoCuatro'] as String?,
      idCalculoCinco: json['idCalculoCinco'] as String?,
      totalCalculo: json['totalCalculo'] as String?,
      idMemoriaDifUno: json['idMemoriaDifUno'] as String?,
      idMemoriaDifDos: json['idMemoriaDifDos'] as String?,
      idMemoriaDifTres: json['idMemoriaDifTres'] as String?,
      totalMemoriaDif: json['totalMemoriaDif'] as String?,
      idDenominacionUno: json['idDenominacionUno'] as String?,
      idDenominacionDos: json['idDenominacionDos'] as String?,
      totalDenominacion: json['totalDenominacion'] as String?,
      idRepeticionUno: json['idRepeticionUno'] as String?,
      totalRepeticion: json['totalRepeticion'] as String?,
      idComprensionUno: json['idComprensionUno'] as String?,
      idComprensionDos: json['idComprensionDos'] as String?,
      idComprensionTres: json['idComprensionTres'] as String?,
      totalComprension: json['totalComprension'] as String?,
      idLecturaUno: json['idLecturaUno'] as String?,
      totalLectura: json['totalLectura'] as String?,
      idEscrituraUno: json['idEscrituraUno'] as String?,
      totalEscritura: json['totalEscritura'] as String?,
      idCopiaUno: json['idCopiaUno'] as String?,
      totalCopia: json['totalCopia'] as String?,
      totalTest: json['totalTest'] as String?,
    );
  }
}
