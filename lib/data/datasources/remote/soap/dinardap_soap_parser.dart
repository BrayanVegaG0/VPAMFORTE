import 'package:xml/xml.dart';

class DinardapSoapParser {
  static String? _textByLocal(XmlDocument doc, String localName) {
    final el = doc.descendants
        .whereType<XmlElement>()
        .cast<XmlElement?>()
        .firstWhere((e) => e?.name.local == localName, orElse: () => null);
    final txt = el?.innerText.trim();
    if (txt == null || txt.isEmpty) return null;
    return txt;
  }

  static Map<String, String?> parseFields(String xmlBody) {
    final doc = XmlDocument.parse(xmlBody);

    return {
      'nombres': _textByLocal(doc, 'nombres'),
      'fechaNacimiento': _textByLocal(doc, 'fechaNacimiento'),
      'nacionalidad': _textByLocal(doc, 'nacionalidad'),
      'sexo': _textByLocal(doc, 'sexo'),
      'estadoCivil': _textByLocal(doc, 'estadoCivil'),
      'domicilio': _textByLocal(doc, 'domicilio'), // ✅ extraído
    };
  }
}
