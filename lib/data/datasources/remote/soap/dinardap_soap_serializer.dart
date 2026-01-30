class DinardapSoapSerializer {
  static String buildEnvelope({required String cedula}) {
    return '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:ns1="https://siimiesalpha.desarrollohumano.inclusion.gob.ec/encuestaMovil/">
  <soapenv:Header/>
  <soapenv:Body>
    <ns1:cedula>$cedula</ns1:cedula>
  </soapenv:Body>
</soapenv:Envelope>
''';
  }
}
