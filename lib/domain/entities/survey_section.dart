import 'package:ficha_vulnerabilidad/domain/entities/survey.dart';

enum SurveySection {
  datosGenerales,
  situacionSocioEconomica,
  saludNutricion,
  vulnerabilidadVivienda,
  serviciosAtencionCuidado,
  cuestionarioAMA,
  fichaPam,
  fichaPcd,
  indiceBarthel,
  lawtonBrody,
  minimentalPam,
  yesavagePam,
  baremo,
  cargaCuidador,
}

extension SurveySectionX on SurveySection {
  String get title {
    switch (this) {
      case SurveySection.datosGenerales:
        return 'Datos Generales';
      case SurveySection.situacionSocioEconomica:
        return 'Situación Socioeconómica';
      case SurveySection.saludNutricion:
        return 'Salud y Nutrición';
      case SurveySection.vulnerabilidadVivienda:
        return 'Vulnerabilidad Vivienda';
      case SurveySection.serviciosAtencionCuidado:
        return 'Servicios Atención y Cuidado';
      case SurveySection.cuestionarioAMA:
        return 'Cuestionario AMA';
      case SurveySection.fichaPam:
        return 'Ficha Adulto Mayor';
      case SurveySection.fichaPcd:
        return 'Ficha de Personas con Discapacidad';
      case SurveySection.indiceBarthel:
        return 'Índice Barthel';
      case SurveySection.lawtonBrody:
        return 'Escala Lawton y Brody';
      case SurveySection.minimentalPam:
        return 'Mini Examen Mental';
      case SurveySection.yesavagePam:
        return 'Escala Yesavage';
      case SurveySection.baremo:
        return 'Baremo';
      case SurveySection.cargaCuidador:
        return 'Carga del Cuidador';
    }
  }
}

const List<SurveySection> surveySectionsOrder = [
  SurveySection.datosGenerales,
  SurveySection.situacionSocioEconomica,
  SurveySection.saludNutricion,
  SurveySection.vulnerabilidadVivienda,
  SurveySection.serviciosAtencionCuidado,
  SurveySection.cuestionarioAMA,
  SurveySection.fichaPam,
  SurveySection.fichaPcd,
  SurveySection.indiceBarthel,
  SurveySection.lawtonBrody,
  SurveySection.minimentalPam,
  SurveySection.yesavagePam,
  SurveySection.baremo,
  SurveySection.cargaCuidador,
];
