import '../../domain/entities/survey_section.dart';

/// Helper para filtrar secciones basándose en la edad del encuestado
class SurveySectionFilterHelper {
  /// Secciones que SOLO se muestran si la persona tiene 65 años o más
  static const Set<SurveySection> _elderOnlySections = {
    SurveySection.fichaPam,
    SurveySection.indiceBarthel,
    SurveySection.lawtonBrody,
    SurveySection.minimentalPam,
    SurveySection.yesavagePam,
  };

  /// Calcula la edad en años desde una fecha de nacimiento ISO (YYYY-MM-DD)
  static int? calculateAge(String? fechaNacimiento) {
    if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty) {
      return null;
    }

    try {
      final birthDate = DateTime.parse(fechaNacimiento);
      final today = DateTime.now();
      int age = today.year - birthDate.year;

      // Ajustar si aún no ha cumplido años este año
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      return null;
    }
  }

  /// Determina si una sección debe mostrarse según la edad
  static bool shouldShowSection(
    SurveySection section,
    Map<String, dynamic> answers,
  ) {
    // Si no es una sección exclusiva de adultos mayores, siempre se muestra
    if (!_elderOnlySections.contains(section)) {
      return true;
    }

    // Para secciones de adultos mayores, verificar si el servicio seleccionado es '3' (Adulto Mayor)
    final serviceId = answers['idServMdh']?.toString();
    return serviceId == '3';
  }

  /// Filtra la lista de secciones según la edad del encuestado
  static List<SurveySection> getVisibleSections(
    List<SurveySection> allSections,
    Map<String, dynamic> answers,
  ) {
    return allSections
        .where((section) => shouldShowSection(section, answers))
        .toList();
  }

  /// Verifica si una persona es adulto mayor (≥65 años)
  static bool isElderAdult(Map<String, dynamic> answers) {
    final fechaNacimiento = answers['fechaNacimientoM']?.toString();
    final age = calculateAge(fechaNacimiento);
    return age != null && age >= 65;
  }
}
