import 'package:ficha_vulnerabilidad/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

void main() {
  test('login OK (E000) retorna UserModel con token y roles', () async {
    const okResponse = '''
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns2:autenticacionResponse xmlns:ns2="http://impl.service.siimies.web.login.mobile/">
      <acceso>
        <cod>E000</cod>
        <iduser>242814</iduser>
        <mensaje>OK</mensaje>
        <nombreuser>KEVIN IVAN</nombreuser>
        <roles_list><rol>VULNERABILIDAD</rol></roles_list>
        <token>abc123</token>
      </acceso>
    </ns2:autenticacionResponse>
  </soap:Body>
</soap:Envelope>
''';

    final client = MockClient((req) async {
      expect(req.method, 'POST');
      expect(req.url.toString(),
          'https://capacitacionalpha.desarrollohumano.gob.ec/actben-ws/logmob-service');
      // Confirmar headers SOAP base
      expect(req.headers['content-type']?.contains('text/xml'), true);
      return http.Response(okResponse, 200);
    });

    final ds = AuthRemoteDataSourceSoap(client: client);
    final user = await ds.login(username: '1754438636', password: '1754438636');

    expect(user.idUser, '242814');
    expect(user.nombre, 'KEVIN IVAN');
    expect(user.token, 'abc123');
    expect(user.roles, ['VULNERABILIDAD']);
  });

  test('login error funcional (E002) lanza AuthException con mensaje', () async {
    const errorResponse = '''
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns2:autenticacionResponse xmlns:ns2="http://impl.service.siimies.web.login.mobile/">
      <acceso>
        <cod>E002</cod>
        <mensaje>CREDENCIALES INCORRECTAS</mensaje>
      </acceso>
    </ns2:autenticacionResponse>
  </soap:Body>
</soap:Envelope>
''';

    final client = MockClient((req) async => http.Response(errorResponse, 200));
    final ds = AuthRemoteDataSourceSoap(client: client);

    expect(
          () => ds.login(username: 'x', password: 'y'),
      throwsA(
        predicate((e) => e.toString().contains('E002: CREDENCIALES INCORRECTAS')),
      ),
    );
  });
}
