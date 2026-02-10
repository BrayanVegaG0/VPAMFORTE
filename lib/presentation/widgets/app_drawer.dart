import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_event.dart';
import '../state/auth/auth_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _goReplace(BuildContext context, String route) {
    final current = ModalRoute.of(context)?.settings.name;

    Navigator.pop(context); // cierra el drawer

    if (current == route) return;

    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;

    final bool isAuthed = state is AuthAuthenticated;
    final String userName = isAuthed
        ? state
              .user
              .nombre // Cast innecesario eliminado
        : 'INVITADO/A';

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _DrawerHeader(userName: userName),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerItem(
                    icon: Icons.home,
                    title: 'Principal',
                    subtitle: 'Pantalla principal',
                    onTap: () => _goReplace(context, '/'),
                  ),
                  _DrawerItem(
                    icon: Icons.edit_note,
                    title: 'LLenar encuesta',
                    subtitle: 'Persona vulnerable',
                    onTap: () => _goReplace(context, '/usuario_consentimiento'),
                  ),
                  _DrawerItem(
                    icon: Icons.assignment,
                    title: 'Encuestas registradas',
                    subtitle: 'Lista de encuestas',
                    onTap: () => _goReplace(context, '/registered_surveys'),
                  ),
                  _DrawerItem(
                    icon: Icons.history,
                    title: 'Historial de Envíos',
                    subtitle: 'Encuestas enviadas',
                    onTap: () => _goReplace(context, '/survey_history'),
                  ),
                  _DrawerItem(
                    icon: Icons.info,
                    title: 'Acerca de',
                    subtitle: 'Información aplicación',
                    onTap: () => _goReplace(context, '/about_of'),
                  ),
                  const Divider(height: 22),

                  // Si NO hay sesión, mostrar "Iniciar sesión"
                  if (!isAuthed)
                    _DrawerItem(
                      icon: Icons.login,
                      title: 'Iniciar sesión',
                      subtitle: 'Acceder al sistema',
                      onTap: () => _goReplace(context, '/login'),
                    ),

                  // Si hay sesión, mostrar "Cerrar sesión"
                  if (isAuthed)
                    _DrawerItem(
                      icon: Icons.logout,
                      title: 'Cerrar sesión',
                      subtitle: 'Finalizar sesión',
                      onTap: () {
                        // 1. Cerrar Drawer
                        Navigator.pop(context);

                        // 2. Despachar evento
                        context.read<AuthBloc>().add(
                          const AuthLogoutRequested(),
                        );

                        // 3. Navegar a Home SOLO si no estamos ahí
                        // Esto permite que el listener de HomePage muestre el SnackBar
                        final current = ModalRoute.of(context)?.settings.name;
                        if (current != '/') {
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                    ),
                ],
              ),
            ),
            // Footer del drawer (opcional)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'v1.3.4',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final String userName;

  const _DrawerHeader({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: AppColors.primary, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userName == 'INVITADO/A' ? 'Acceso limitado' : 'Bienvenid@',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Color(0xFF333333),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: onTap,
    );
  }
}
