import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioConsentimientoPage extends StatefulWidget {
  static const routeName = '/usuario_consentimiento';

  const UsuarioConsentimientoPage({super.key});

  @override
  State<UsuarioConsentimientoPage> createState() =>
      _UsuarioConsentimientoPageState();
}

class _UsuarioConsentimientoPageState extends State<UsuarioConsentimientoPage>
    with WidgetsBindingObserver {
  // Keys en SharedPreferences (simple y auditable)
  static const _kAccepted = 'consentimiento_accepted';
  static const _kAcceptedAt = 'consentimiento_accepted_at_iso';

  bool _isChecking = true;
  bool _locationEnabled = false;
  bool _permissionGranted = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Verificamos apenas se construye
    _checkLocationRequirements();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Si el usuario vuelve de la configuración (resumed), verificamos de nuevo automágicamente
    if (state == AppLifecycleState.resumed) {
      _checkLocationRequirements();
    }
  }

  Future<void> _checkLocationRequirements() async {
    if (!mounted) return;
    setState(() {
      _isChecking = true;
      _errorMessage = null;
    });

    try {
      // 1. Verificar servicio de ubicación (GPS prendido)
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            _locationEnabled = false;
            _permissionGranted = false;
            _isChecking = false;
            _errorMessage =
                'La ubicación está desactivada. Por favor, actívela para continuar.';
          });
        }
        return;
      }
      _locationEnabled = true;

      // 2. Verificar permisos
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            setState(() {
              _permissionGranted = false;
              _isChecking = false;
              _errorMessage =
                  'El permiso de ubicación fue denegado. Es necesario para continuar.';
            });
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            _permissionGranted = false;
            _isChecking = false;
            _errorMessage =
                'El permiso de ubicación está bloqueado permanentemente. Habilítelo desde la configuración del dispositivo.';
          });
        }
        return;
      }

      // Todo OK
      if (mounted) {
        setState(() {
          _permissionGranted = true;
          _isChecking = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isChecking = false;
          _errorMessage = 'Error verificando ubicación: $e';
        });
      }
    }
  }

  Future<void> _openSettings() async {
    if (!_locationEnabled) {
      // Abre configuración de ubicación (GPS)
      await Geolocator.openLocationSettings();
    } else {
      // Abre configuración de la app (Permisos)
      await Geolocator.openAppSettings();
    }
  }

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
    // 🔒 BLOQUEO: Si estamos verificando o hay error, mostramos pantalla de bloqueo
    if (_isChecking || !_locationEnabled || !_permissionGranted) {
      return Scaffold(
        appBar: AppBar(title: const Text('Verificando requisitos...')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isChecking
                      ? Icons.location_searching
                      : Icons.location_disabled,
                  size: 64,
                  color: _isChecking ? Colors.blue : Colors.red,
                ),
                const SizedBox(height: 24),
                if (_isChecking) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text('Verificando servicios de ubicación...'),
                ] else ...[
                  Text(
                    'Ubicación requerida',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage ?? 'Es necesario activar la ubicación.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _openSettings,
                      icon: const Icon(Icons.settings),
                      label: const Text('Abrir Configuración'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _checkLocationRequirements,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Intentar de nuevo'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _goHome(context),
                    child: const Text('Cancelar y Salir'),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    // ✅ SI PASA: Mostramos el contenido normal de consentimiento
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
                  if (!mounted) return;
                  _goSurvey(context);
                },
                onReject: () async {
                  await _saveConsent(false);
                  if (!mounted) return;
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

          Text(
            'Finalidad del tratamiento',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Los datos se utilizarán exclusivamente para: (i) registro de información de la encuesta, '
            '(ii) validación y verificación de identidad (cuando aplique), (iii) análisis y gestión de resultados '
            'para atención social, y (iv) generación de reportes institucionales. No se utilizarán para fines '
            'distintos a los descritos sin una base de legitimación correspondiente.',
          ),
          SizedBox(height: 10),

          Text(
            'Categorías de datos',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Podrían incluir datos identificativos (p. ej. número de documento, nombres), datos de contacto, '
            'ubicación administrativa (provincia/cantón/parroquia) y datos socioeconómicos. '
            'El sistema aplica mecanismos de minimización y solo solicita lo estrictamente necesario.',
          ),
          SizedBox(height: 10),

          Text(
            'Base de legitimación',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
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

          Text(
            'Seguridad y confidencialidad',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Se aplican controles técnicos y organizativos razonables para proteger los datos contra acceso '
            'no autorizado, pérdida, alteración o divulgación. El acceso está restringido a personal autorizado.',
          ),
          SizedBox(height: 10),

          Text(
            'Derechos del titular',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
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

  const _ConsentActions({required this.onAccept, required this.onReject});

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
