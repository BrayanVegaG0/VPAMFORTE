import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/app_drawer.dart';
import '../../core/theme/app_colors.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_event.dart';
import '../state/auth/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;

  @override
  void initState() {
    super.initState();
    _serviceStatusStreamSubscription = Geolocator.getServiceStatusStream().listen((
      status,
    ) {
      if (status == ServiceStatus.disabled) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.primary,
            content: Text(
              'Se quitó la ubicación. Por favor, actívela para el correcto funcionamiento.',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _serviceStatusStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, current) =>
          prev is AuthAuthenticated && current is AuthUnauthenticated,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.primary,
            content: Text(
              'Sesión cerrada, está como invitado.',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bool isLoading = state is AuthLoading;
          final bool isAuthed = state is AuthAuthenticated;

          return Stack(
            children: [
              Scaffold(
                drawer: const AppDrawer(),
                appBar: AppBar(
                  title: const Text('Principal'),
                  centerTitle: true,
                  actions: [
                    if (isAuthed)
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () => context.read<AuthBloc>().add(
                          const AuthLogoutRequested(),
                        ),
                      ),
                  ],
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
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        Image.asset(
                          'assets/images/ic_banner_mdh.png',
                          width: 220,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _HomeImageButton(
                              imagePath: 'assets/images/ic_new_survey_mdh.png',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/usuario_consentimiento',
                                );
                              },
                            ),
                            _HomeImageButton(
                              imagePath: 'assets/images/ic_survey_list_mdh.png',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/registered_surveys',
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/about_of');
                          },
                          child: Image.asset(
                            'assets/images/ic_about_mdh.png',
                            width: 280,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Spacer(),
                        // FOOTER MODERNO
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Infancia EC v1.3.4',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '© 2026 Ministerio de Desarrollo Humano',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading)
                const Positioned.fill(
                  child: IgnorePointer(
                    ignoring: false,
                    child: ColoredBox(
                      color: Color(0x55FFFFFF),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

void _showMustLogin(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: AppColors.primary,
      content: Text(
        'Debes iniciar sesión para ver encuestas registradas.',
        style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class _HomeImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final double width;

  const _HomeImageButton({
    required this.imagePath,
    required this.onTap,
    this.width = 140,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imagePath, width: width, fit: BoxFit.contain),
    );
  }
}
