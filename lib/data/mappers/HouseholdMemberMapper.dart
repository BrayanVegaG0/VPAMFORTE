import '../../domain/entities/household_member.dart';
import '../models/db/estructura_familiar_disc_db.dart';

class HouseholdMemberMapper {
  static EstructuraFamiliarDiscDb toDb(HouseholdMember e) {
    return EstructuraFamiliarDiscDb(
      cedula: e.cedula,
      nombresApellidos: e.nombresApellidos,
      edad: e.edad,
      identidadGenero: e.identidadGenero,
      idTieneDiscapacidad: e.idTieneDiscapacidad,
      idTipoDiscapacidad: e.idTipoDiscapacidad,
      porcentajeDiscapacidad: e.porcentajeDiscapacidad,
      enfermedadCatastrofica: e.enfermedadCatastrofica,
      idEtapaGestacional: e.idEtapaGestacional,
      idMenorTrabaja: e.idMenorTrabaja,
      idParentesco: e.idParentesco,
      idGeneraIngresos: e.idGeneraIngresos,
      generaIngresosCuanto: e.generaIngresosCuanto,
    );
  }
}
