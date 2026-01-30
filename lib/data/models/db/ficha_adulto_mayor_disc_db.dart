import 'ing_gastos_disc_db.dart';
import 'ficha_pam_db.dart';
import 'indice_barthel_disc_db.dart'; // Import nuevo
import 'lawton_brody_db.dart'; // Import nuevo
import 'minimental_pam_db.dart';
import 'yesavage_pam_db.dart';

import 'familias_factores_riesgo_db.dart';
import 'vulnerabilidad_per_discapacidad_db.dart';
import 'vulnerabilidad_vivienda_disc_db.dart';
import 'salud_disc_db.dart';

class FichaAdultoMayorDiscDb {
  final VulnerabilidadPerDiscapacidadDb vulnerabilidadPerDiscapacidad;
  final FamiliasFactoresRiesgoDb familiasFactoresRiesgo;
  final VulnerabilidadViviendaDiscDb vulnerabilidadViviendaDisc;
  final IngGastosDiscDb ingGastosDisc;
  final SaludDiscDb saludDisc;
  final FichaPamDb fichaPam;
  final IndiceBarthelDiscDb indiceBarthel; // Nuevo campo
  final LawtonBrodyDb lawtonBrody; // Nuevo campo
  final MiniMentalPamDb minimentalPam;
  final YesavagePamDb yesavagePam;

  FichaAdultoMayorDiscDb({
    required this.vulnerabilidadPerDiscapacidad,
    required this.familiasFactoresRiesgo,
    required this.vulnerabilidadViviendaDisc,
    required this.ingGastosDisc,
    required this.saludDisc,
    required this.fichaPam,
    required this.indiceBarthel,
    required this.lawtonBrody,
    required this.minimentalPam,
    required this.yesavagePam,
  });

  Map<String, dynamic> toJson() => {
    'vulnerabilidadPerDiscapacidad': vulnerabilidadPerDiscapacidad.toJson(),
    'familiasFactoresRiesgo': familiasFactoresRiesgo.toJson(),
    'vulnerabilidadViviendaDisc': vulnerabilidadViviendaDisc.toJson(),
    'ingGastosDisc': ingGastosDisc.toJson(),
    'saludDisc': saludDisc.toJson(),
    'fichaPam': fichaPam.toJson(),
    'indiceBarthel': indiceBarthel.toJson(),
    'lawtonBrody': lawtonBrody.toJson(),
    'minimentalPam': minimentalPam.toJson(),
    'yesavagePam': yesavagePam.toJson(),
  };

  static FichaAdultoMayorDiscDb fromJson(Map<String, dynamic> json) {
    return FichaAdultoMayorDiscDb(
      vulnerabilidadPerDiscapacidad: VulnerabilidadPerDiscapacidadDb.fromJson(
        json['vulnerabilidadPerDiscapacidad'] as Map<String, dynamic>,
      ),
      familiasFactoresRiesgo: FamiliasFactoresRiesgoDb.fromJson(
        json['familiasFactoresRiesgo'] as Map<String, dynamic>,
      ),
      vulnerabilidadViviendaDisc: VulnerabilidadViviendaDiscDb.fromJson(
        json['vulnerabilidadViviendaDisc'] as Map<String, dynamic>,
      ),
      ingGastosDisc: IngGastosDiscDb.fromJson(
        json['ingGastosDisc'] as Map<String, dynamic>,
      ),
      saludDisc: SaludDiscDb.fromJson(
        json['saludDisc'] as Map<String, dynamic>,
      ),
      fichaPam: FichaPamDb.fromJson(json['fichaPam'] as Map<String, dynamic>),
      indiceBarthel: IndiceBarthelDiscDb.fromJson(
        json['indiceBarthel'] as Map<String, dynamic>,
      ),
      lawtonBrody: LawtonBrodyDb.fromJson(
        json['lawtonBrody'] as Map<String, dynamic>,
      ),
      minimentalPam: MiniMentalPamDb.fromJson(
        json['minimentalPam'] as Map<String, dynamic>,
      ),
      yesavagePam: YesavagePamDb.fromJson(
        json['yesavagePam'] as Map<String, dynamic>,
      ),
    );
  }
}
