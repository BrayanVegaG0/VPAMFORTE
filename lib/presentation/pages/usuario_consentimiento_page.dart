import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioConsentimientoPage extends StatelessWidget {
  static const routeName = '/usuario_consentimiento';

  // Keys en SharedPreferences (simple y auditable)
  static const _kAccepted = 'consentimiento_accepted';
  static const _kAcceptedAt = 'consentimiento_accepted_at_iso';

  const UsuarioConsentimientoPage({super.key});

  Future<void> _saveConsent(bool accepted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kAccepted, accepted);
    await prefs.setString(_kAcceptedAt, DateTime.now().toIso8601String());
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  void _goSurvey(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/surveys');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consentimiento informado'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _goHome(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const _ConsentHeader(),
              const SizedBox(height: 12),
              const Expanded(child: _ConsentBody()),
              const SizedBox(height: 12),
              _ConsentActions(
                onAccept: () async {
                  await _saveConsent(true);
                  if (!context.mounted) return;
                  _goSurvey(context);
                },
                onReject: () async {
                  await _saveConsent(false);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Debe aceptar el tratamiento de datos personales para continuar con la encuesta.',
                      ),
                    ),
                  );
                  _goHome(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConsentHeader extends StatelessWidget {
  const _ConsentHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.verified_user_outlined, size: 28),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'UsuarioConsentimiento',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _ConsentBody extends StatelessWidget {
  const _ConsentBody();

  @override
  Widget build(BuildContext context) {
    // Texto técnico y claro (sin “romantizar” ni ambiguo)
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Información sobre el tratamiento de datos personales',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            'En cumplimiento de la Ley Orgánica de Protección de Datos Personales (LDPDP) y normativa aplicable, '
                'se le informa que los datos personales que usted proporcione y/o se consulten durante esta encuesta '
                'serán tratados bajo principios de licitud, lealtad, transparencia, minimización, finalidad, '
                'proporcionalidad, seguridad, confidencialidad y responsabilidad proactiva.',
          ),
          SizedBox(height: 10),

          Text('Finalidad del tratamiento', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'Los datos se utilizarán exclusivamente para: (i) registro de información de la encuesta, '
                '(ii) validación y verificación de identidad (cuando aplique), (iii) análisis y gestión de resultados '
                'para atención social, y (iv) generación de reportes institucionales. No se utilizarán para fines '
                'distintos a los descritos sin una base de legitimación correspondiente.',
          ),
          SizedBox(height: 10),

          Text('Categorías de datos', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'Podrían incluir datos identificativos (p. ej. número de documento, nombres), datos de contacto, '
                'ubicación administrativa (provincia/cantón/parroquia) y datos socioeconómicos. '
                'El sistema aplica mecanismos de minimización y solo solicita lo estrictamente necesario.',
          ),
          SizedBox(height: 10),

          Text('Base de legitimación', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'El tratamiento se fundamenta en su consentimiento informado y, cuando corresponda, '
                'en el cumplimiento de obligaciones legales y/o el interés público conforme a la normativa aplicable.',
          ),
          SizedBox(height: 10),

          Text('Conservación', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'Los datos se conservarán únicamente durante el tiempo necesario para cumplir la finalidad y '
                'las obligaciones legales de archivo, auditoría y control, y luego serán eliminados o anonimizados '
                'según corresponda.',
          ),
          SizedBox(height: 10),

          Text('Seguridad y confidencialidad', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'Se aplican controles técnicos y organizativos razonables para proteger los datos contra acceso '
                'no autorizado, pérdida, alteración o divulgación. El acceso está restringido a personal autorizado.',
          ),
          SizedBox(height: 10),

          Text('Derechos del titular', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'Usted puede ejercer los derechos de acceso, rectificación y actualización, eliminación, oposición, '
                'portabilidad, limitación del tratamiento, y revocatoria del consentimiento, conforme a la LDPDP. '
                'La revocatoria no afecta la licitud del tratamiento previo.',
          ),
          SizedBox(height: 12),

          Text(
            '¿Acepta el tratamiento de sus datos personales bajo los términos descritos?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _ConsentActions extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _ConsentActions({
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onAccept,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Acepto'),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onReject,
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('No acepto'),
          ),
        ),
      ],
    );
  }
}
