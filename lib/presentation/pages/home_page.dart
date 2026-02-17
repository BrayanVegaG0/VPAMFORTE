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
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final w = c.maxWidth;

                      final double headerW = (w * 0.78).clamp(220, 320);
                      final double topBtnW = (w * 0.40).clamp(145, 175);
                      final double aboutW = (w * 0.86).clamp(260, 420);

                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                // HEADER
                                Center(
                                  child: Image.asset(
                                    'assets/images/prototipotesis.png',
                                    width: headerW,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 18),

                                // 2 BOTONES (SOLO IMAGEN COMO BOTÓN)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _ImageOnlyButton(
                                      imagePath:
                                          'assets/images/NuevaEncuesta.png',
                                      width: topBtnW,
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        '/usuario_consentimiento',
                                      ),
                                    ),
                                    _ImageOnlyButton(
                                      imagePath:
                                          'assets/images/EncuestasRegistradas.png',
                                      width: topBtnW,
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        '/registered_surveys',
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 14),

                                // ABOUT (SOLO IMAGEN COMO BOTÓN, MÁS GRANDE)
                                _ImageOnlyButton(
                                  imagePath: 'assets/images/AcercaDe.png',
                                  width: aboutW,
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/about_of'),
                                ),
                                const SizedBox(height: 12),
                              ]),
                            ),
                          ),

                          // FOOTER ABAJO
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'Infancia EC v1.3.4',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
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
                            ),
                          ),
                        ],
                      );
                    },
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

class _ImageOnlyButton extends StatelessWidget {
  final String imagePath;
  final double width;
  final VoidCallback onTap;

  const _ImageOnlyButton({
    required this.imagePath,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Image.asset(imagePath, width: width, fit: BoxFit.contain),
      ),
    );
  }
}
