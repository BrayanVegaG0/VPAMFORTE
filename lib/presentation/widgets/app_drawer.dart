import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ? (state as AuthAuthenticated).user.nombre
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
                    iconBg: const Color(0xFF1976D2),
                    title: 'Principal',
                    subtitle: 'Pantalla principal',
                    onTap: () => _goReplace(context, '/'),
                  ),
                  _DrawerItem(
                    icon: Icons.edit_note,
                    iconBg: const Color(0xFF455A64),
                    title: 'LLenar encuesta',
                    subtitle: 'Persona vulnerable',
                    onTap: () => _goReplace(context, '/usuario_consentimiento'),
                  ),
                  _DrawerItem(
                    icon: Icons.assignment,
                    iconBg: const Color(0xFF0288D1),
                    title: 'Encuestas registradas',
                    subtitle: 'Lista de encuestas',
                    onTap: () => _goReplace(context, '/registered_surveys'),
                  ),
                  _DrawerItem(
                    icon: Icons.info,
                    iconBg: const Color(0xFF0097A7),
                    title: 'Acerca de',
                    subtitle: 'Información aplicación',
                    onTap: () => _goReplace(context, '/about_of'),
                  ),
                  const Divider(height: 22),

                  // Si NO hay sesión, mostrar "Iniciar sesión"
                  if (!isAuthed)
                    _DrawerItem(
                      icon: Icons.login,
                      iconBg: const Color(0xFF43A047),
                      title: 'Iniciar sesión',
                      subtitle: 'Acceder al sistema',
                      onTap: () => _goReplace(context, '/login'),
                    ),

                  // Si hay sesión, mostrar "Cerrar sesión"
                  if (isAuthed)
                    _DrawerItem(
                      icon: Icons.logout,
                      iconBg: const Color(0xFFFBC02D),
                      title: 'Cerrar sesión',
                      subtitle: 'Finalizar sesión',
                      onTap: () {
                        Navigator.pop(context);
                        context.read<AuthBloc>().add(const AuthLogoutRequested());
                        // opcional: volver a Principal
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                ],
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
      color: const Color(0xFF2C2FA3), // similar al drawer objetivo
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Color(0xFF2C2FA3), size: 30),
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
          )
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: iconBg.withOpacity(0.15),
        child: Icon(icon, color: iconBg, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      onTap: onTap,
    );
  }
}
