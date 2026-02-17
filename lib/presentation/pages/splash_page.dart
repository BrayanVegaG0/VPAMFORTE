import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Splash visual 1.5–2s y luego Home SIEMPRE
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: _SplashContent()));
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Si el asset falla, muestra ícono
        Image(
          image: AssetImage('assets/images/icono.png'),
          width: 180,
          semanticLabel: 'Logo de la aplicación VPAMFORTE',
          errorBuilder: (_, _, _) => Icon(Icons.account_balance, size: 120),
        ),
        SizedBox(height: 32),
        Semantics(
          label: 'Cargando aplicación',
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
