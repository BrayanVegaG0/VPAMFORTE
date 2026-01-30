import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutOfPage extends StatelessWidget {
  const AboutOfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo_mdh.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // TÍTULO
                    const Text(
                      'VULNEDIS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // LOGO CENTRAL
                    Image.asset(
                      'assets/images/ic_launcher.png',
                      width: 210,
                      height: 210,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 10),

                    // VERSIÓN
                    const Text(
                      'Versión 1.3.4',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // COPYRIGHT
                    const Text(
                      'Copyright 2025 Ministerio de Desarrollo Humano - ECUADOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // DESCRIPCIÓN
                    const Text(
                      'Esta aplicación fue desarrollada para agilizar la recolección '
                          'de información de personas con la finalidad de identificar '
                          'si son vulnerables.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
