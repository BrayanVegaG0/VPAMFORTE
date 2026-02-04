import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import '../local/auth_local_datasource.dart';
import 'soap/dinardap_soap_serializer.dart';
import 'soap/dinardap_soap_parser.dart';

class DinardapSoapRemoteDataSourceHttp {
  final http.Client client;
  final AuthLocalDataSource authLocal;

  DinardapSoapRemoteDataSourceHttp({
    required this.client,
    required this.authLocal,
  });

  static const String url =
      'https://capacitacionalpha.desarrollohumano.gob.ec/ws-puente-dinardap/encuesta-movil';

  Future<Map<String, String?>> consultarPorCedula(String cedula) async {
    final creds = await authLocal.getBasicAuthCredentials();
    if (creds == null) {
      throw Exception(
        'No hay credenciales BasicAuth guardadas. Inicie sesión nuevamente.',
      );
    }

    final basic =
        'Basic ${base64Encode(utf8.encode('${creds.username}:${creds.password}'))}';
    final envelope = DinardapSoapSerializer.buildEnvelope(cedula: cedula);

    final resp = await client
        .post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            'Authorization': basic,
            'SOAPAction':
                'https://siimiesalpha.desarrollohumano.inclusion.gob.ec/encuestaMovil/ConsultaInfRegCivil',
          },
          body: envelope,
        )
        .timeout(const Duration(seconds: 20));

    final bodyText = utf8.decode(resp.bodyBytes);

    print('=== DINARDAP RAW RESPONSE ===');
    print(bodyText);
    print('=============================');

    dev.log('DINARDAP REQUEST url=$url cedula=$cedula', name: 'DINARDAP');
    dev.log('DINARDAP REQUEST envelope:\n$envelope', name: 'DINARDAP');
    dev.log(
      'DINARDAP RESPONSE status=${resp.statusCode} reason=${resp.reasonPhrase}',
      name: 'DINARDAP',
    );
    dev.log('DINARDAP RESPONSE headers=${resp.headers}', name: 'DINARDAP');
    dev.log('DINARDAP RESPONSE body:\n$bodyText', name: 'DINARDAP');

    final upper = bodyText.toUpperCase();
    if (upper.contains('CEDULA INVALIDA') ||
        upper.contains('CÉDULA INVALIDA')) {
      throw Exception('CEDULA INVALIDA');
    }
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      final detail = _extractSoapFaultOrBody(bodyText);
      throw Exception('DINARDAP HTTP ${resp.statusCode}: $detail');
    }

    // SOAP Fault aunque haya 200 (a veces)
    if (bodyText.contains('<Fault') || bodyText.contains('soap:Fault')) {
      final detail = _extractSoapFaultOrBody(bodyText);
      throw Exception('DINARDAP SOAP Fault: $detail');
    }

    return DinardapSoapParser.parseFields(bodyText);
  }

  String _extractSoapFaultOrBody(String body) {
    // Extrae faultstring si existe; si no, devuelve el body truncado
    final faultString = RegExp(
      r'<faultstring>([\s\S]*?)</faultstring>',
      caseSensitive: false,
    ).firstMatch(body)?.group(1)?.trim();

    final detail = RegExp(
      r'<detail>([\s\S]*?)</detail>',
      caseSensitive: false,
    ).firstMatch(body)?.group(1)?.trim();

    if (faultString != null && faultString.isNotEmpty) {
      if (detail != null && detail.isNotEmpty) {
        return 'faultstring=$faultString | detail=$detail';
      }
      return 'faultstring=$faultString';
    }

    // Trunca para no reventar UI/logs (ajusta si quieres)
    final trimmed = body.trim();
    if (trimmed.length <= 2000) return trimmed;
    return '${trimmed.substring(0, 2000)}...[truncated]';
  }
}
