import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/app_drawer.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_event.dart';
import '../state/auth/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;
        final bool isAuthed = state is AuthAuthenticated;

        return Stack(
          children: [
            Scaffold(
              drawer: const AppDrawer(),
              appBar: AppBar(
                title: const Text('Principal'),
                actions: [
                  // Logout solo si hay sesión (si no, se oculta)
                  if (isAuthed)
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(const AuthLogoutRequested()),
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
                              Navigator.pushNamed(context, '/usuario_consentimiento');
                            },
                          ),
                          _HomeImageButton(
                            imagePath: 'assets/images/ic_survey_list_mdh.png',
                            onTap: () {
                              // Si quieres restringir: solo con sesión
/*                              if (!isAuthed) {
                                _showMustLogin(context);
                                return;
                              }*/
                              Navigator.pushNamed(context, '/registered_surveys');
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

                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Image.asset(
                          'assets/images/flat_ecuador.png',
                          width: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Overlay de carga (no rompe UI)
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
    );
  }
}

void _showMustLogin(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Debes iniciar sesión para ver encuestas registradas.'),
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
      child: Image.asset(
        imagePath,
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }
}
