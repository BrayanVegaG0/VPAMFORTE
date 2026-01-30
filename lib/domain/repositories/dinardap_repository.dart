import '../entities/dinardap_person.dart';

abstract class DinardapRepository {
  Future<DinardapPerson> consultarPorCedula(String cedula);
}
