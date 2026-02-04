import '../../domain/entities/dinardap_person.dart';
import '../models/dinardap_person_model.dart';

class DinardapPersonMapper {
  // Convierte "dd/MM/yyyy" -> "dd/MM/yyyy" (lo dejamos igual) o puedes normalizar si quieres.
  // En tu flujo actual, el Bloc convierte a ISO con _toIsoDateFromDdMmYyyy.
  static String? _cleanDdMmYyyy(String? s) {
    if (s == null) return null;
    final v = s.trim();
    if (v.isEmpty) return null;
    // Validación ligera
    final parts = v.split('/');
    if (parts.length != 3) return null;
    return v; // se mantiene como dd/MM/yyyy
  }

  static DinardapPerson toEntity(DinardapPersonModel m) {
    return DinardapPerson(
      nombresCompletos: m.nombresCompletos,
      fechaNacimientoDdMmYyyy: _cleanDdMmYyyy(m.fechaNacimiento),
      nacionalidad: m.nacionalidad,
      sexo: m.sexo,
      estadoCivil: m.estadoCivil,
    );
  }
}
