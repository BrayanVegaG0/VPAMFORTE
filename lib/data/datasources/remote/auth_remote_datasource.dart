import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });

  Future<void> logout();
}

class AuthRemoteDataSourceSoap implements AuthRemoteDataSource {
  final http.Client client;

  static const String endpoint =
      'https://capacitacionalpha.desarrollohumano.gob.ec/actben-ws/logmob-service';

  // Namespace EXACTO del request/response que me enviaste:
  static const String nsImpl = 'http://impl.service.siimies.web.login.mobile/';

  AuthRemoteDataSourceSoap({required this.client});

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final envelope = _buildSoapEnvelope(username: username, password: password);

    final resp = await client.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'Accept': 'text/xml',
        // En tu WSDL se ve soapAction="", normalmente sirve así:
        'SOAPAction': '""',
      },
      body: utf8.encode(envelope),
    );

    if (resp.statusCode != 200) {
      throw AuthException('HTTP ${resp.statusCode}: ${resp.body}');
    }

    return _parseAutenticacionResponse(resp.body);
  }

  @override
  Future<void> logout() async {
    // SOAP no expone logout en lo que compartiste.
    // Aquí normalmente solo limpias sesión local (si la guardas).
  }

  String _buildSoapEnvelope({
    required String username,
    required String password,
  }) {
    // Envelope EXACTO según tu ejemplo (impl namespace).
    return '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:impl="$nsImpl">
  <soapenv:Header/>
  <soapenv:Body>
    <impl:autenticacion>
      <username>${_xmlEscape(username)}</username>
      <password>${_xmlEscape(password)}</password>
    </impl:autenticacion>
  </soapenv:Body>
</soapenv:Envelope>
''';
  }

  UserModel _parseAutenticacionResponse(String xmlStr) {
    final doc = XmlDocument.parse(xmlStr);

    final body = doc.findAllElements('Body').firstOrNull ??
        doc.findAllElements('soap:Body').firstOrNull;

    if (body == null) {
      throw AuthException('Respuesta SOAP inválida: no existe Body');
    }

    // SOAP Fault (por si acaso)
    final fault = body.findAllElements('Fault').firstOrNull;
    if (fault != null) {
      final faultString = fault.findAllElements('faultstring').firstOrNull?.innerText ??
          'SOAP Fault';
      throw AuthException(faultString);
    }

    // Tu respuesta: <ns2:autenticacionResponse> <acceso>...</acceso>
    final acceso = body.findAllElements('acceso').firstOrNull;
    if (acceso == null) {
      throw AuthException('Respuesta SOAP inválida: no existe nodo <acceso>');
    }

    final cod = acceso.findAllElements('cod').firstOrNull?.innerText.trim() ?? '';
    final mensaje = acceso.findAllElements('mensaje').firstOrNull?.innerText.trim() ?? '';

    // Error funcional: E002 CREDENCIALES INCORRECTAS
    if (cod.isEmpty) {
      throw AuthException('Respuesta inválida: <cod> vacío');
    }

    if (cod != 'E000') {
      // Mantén mensaje del servidor
      throw AuthException('$cod: $mensaje');
    }

    // OK: E000
    final idUser = acceso.findAllElements('iduser').firstOrNull?.innerText.trim();
    final nombreUser = acceso.findAllElements('nombreuser').firstOrNull?.innerText.trim();
    final token = acceso.findAllElements('token').firstOrNull?.innerText.trim();

    if (idUser == null || idUser.isEmpty) {
      throw AuthException('Respuesta inválida: falta <iduser>');
    }
    if (nombreUser == null || nombreUser.isEmpty) {
      throw AuthException('Respuesta inválida: falta <nombreuser>');
    }
    if (token == null || token.isEmpty) {
      throw AuthException('Respuesta inválida: falta <token>');
    }

    // roles_list -> rol (pueden venir varios)
    final roles = acceso
        .findAllElements('rol')
        .map((e) => e.innerText.trim())
        .where((r) => r.isNotEmpty)
        .toList();

    return UserModel(
      idUser: idUser,
      nombre: nombreUser,
      token: token,
      roles: roles,
    );
  }

  String _xmlEscape(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
