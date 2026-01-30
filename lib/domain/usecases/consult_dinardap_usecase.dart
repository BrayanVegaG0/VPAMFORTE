import '../entities/dinardap_person.dart';
import '../repositories/dinardap_repository.dart';

class ConsultDinardapUseCase {
  final DinardapRepository repository;
  ConsultDinardapUseCase(this.repository);

  Future<DinardapPerson> call({required String cedula}) {
    return repository.consultarPorCedula(cedula);
  }
}
