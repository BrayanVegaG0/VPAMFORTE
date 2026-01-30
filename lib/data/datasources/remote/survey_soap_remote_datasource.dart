import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class SoapCredentials {
  final String username;
  final String password;
  const SoapCredentials({required this.username, required this.password});
}

class SoapResultMsg {
  final String code;
  final String message;
  const SoapResultMsg({required this.code, required this.message});

  bool get isOk => code.trim().toUpperCase() == 'E103';
}

abstract class SurveySoapRemoteDataSource {
  Future<SoapResultMsg> insertFichaAdultoMayorDiscXml({
    required SoapCredentials credentials,
    required String envelopeXml,
  });
}

class SurveySoapRemoteDataSourceHttp implements SurveySoapRemoteDataSource {
  static const String _endpoint =
      'https://capacitacionalpha.desarrollohumano.gob.ec/vulnerabilidadam-ws/logusrenc-service';
  //'http://192.168.61.240:8080/vulnerabilidadam-ws/logusrenc-service';

  final http.Client client;
  SurveySoapRemoteDataSourceHttp({required this.client});

  @override
  Future<SoapResultMsg> insertFichaAdultoMayorDiscXml({
    required SoapCredentials credentials,
    required String envelopeXml,
  }) async {
    final auth = base64Encode(
      utf8.encode('${credentials.username}:${credentials.password}'),
    );

    final res = await client.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'Accept': 'text/xml',
        'Authorization': 'Basic $auth',
        'SOAPAction': '',
      },
      body: envelopeXml,
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw SoapHttpException(statusCode: res.statusCode, body: res.body);
    }

    return _parseResultMsg(res.body);
  }

  SoapResultMsg _parseResultMsg(String xml) {
    final doc = XmlDocument.parse(xml);

    final resultMsg = doc.descendants.whereType<XmlElement>().firstWhere(
      (e) => e.name.local == 'resultMsg',
      orElse: () {
        throw SoapParseException('No se encontró <resultMsg> en la respuesta');
      },
    );

    String pick(String name) {
      final el = resultMsg
          .findElements(name)
          .firstWhere(
            (_) => true,
            orElse: () => throw SoapParseException(
              'No se encontró <$name> en <resultMsg>',
            ),
          );
      return el.text.trim();
    }

    return SoapResultMsg(code: pick('cod'), message: pick('mensaje'));
  }
}

class SoapHttpException implements Exception {
  final int statusCode;
  final String body;
  SoapHttpException({required this.statusCode, required this.body});

  @override
  String toString() =>
      'SoapHttpException(statusCode: $statusCode, body: $body)';
}

class SoapParseException implements Exception {
  final String message;
  SoapParseException(this.message);
  @override
  String toString() => 'SoapParseException($message)';
}
