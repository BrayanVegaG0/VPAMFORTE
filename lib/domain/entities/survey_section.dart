enum SurveySection {
  datosGenerales,
  situacionSocioEconomica,
  saludNutricion,
  vulnerabilidadVivienda,
  serviciosAtencionCuidado,
  cuestionarioAMA,
  fichaPam,
  indiceBarthel,
  lawtonBrody,
  minimentalPam,
  yesavagePam,
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
      case SurveySection.indiceBarthel:
        return 'Índice Barthel';
      case SurveySection.lawtonBrody:
        return 'Escala Lawton y Brody';
      case SurveySection.minimentalPam:
        return 'Mini Examen Mental';
      case SurveySection.yesavagePam:
        return 'Escala Yesavage';
    }
  }
}

/// ✅ ESTA CONSTANTE ES LA QUE TE FALTA
const List<SurveySection> surveySectionsOrder = [
  SurveySection.datosGenerales,
  SurveySection.situacionSocioEconomica,
  SurveySection.saludNutricion,
  SurveySection.vulnerabilidadVivienda,
  SurveySection.serviciosAtencionCuidado,
  SurveySection.cuestionarioAMA,
  SurveySection.fichaPam,
  SurveySection.indiceBarthel,
  SurveySection.lawtonBrody,
  SurveySection.minimentalPam,
  SurveySection.yesavagePam,
];
