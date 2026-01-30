import '../../domain/entities/dinardap_person.dart';
import '../../domain/repositories/dinardap_repository.dart';
import '../datasources/remote/dinardap_soap_remote_datasource.dart';

class DinardapRepositoryImpl implements DinardapRepository {
  final DinardapSoapRemoteDataSourceHttp remote;

  DinardapRepositoryImpl({required this.remote});

  @override
  Future<DinardapPerson> consultarPorCedula(String cedula) async {
    final f = await remote.consultarPorCedula(cedula);
    return DinardapPerson(
      nombresCompletos: f['nombres'],
      fechaNacimientoDdMmYyyy: f['fechaNacimiento'],
      nacionalidad: f['nacionalidad'],
      sexo: f['sexo'],
    );
  }
}
