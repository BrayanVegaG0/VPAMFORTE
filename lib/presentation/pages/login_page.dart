import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_event.dart';
import '../state/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      AuthLoginRequested(
        username: _userCtrl.text.trim(),
        password: _passCtrl.text,
      ),
    );
  }

  void _loginAsGuest() {
    // TODO: Implementar lógica de login como invitado
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Bienvenido: ${state.user.nombre}'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, '/');
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón de ayuda en la esquina superior derecha
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.help_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // TODO: Mostrar ayuda
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ayuda - Próximamente'),
                              ),
                            );
                          },
                          tooltip: 'Ayuda',
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Logo "Infancia EC" con línea amarilla
                    Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Infancia',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'ec',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // Card con el formulario
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Título "Bienvenido"
                              const Text(
                                'Bienvenido',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Ingresa con tu cédula y contraseña para continuar.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),

                              // Campo de cédula con icono
                              TextFormField(
                                controller: _userCtrl,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Cédula',
                                  hintText: 'Ingresa tu cédula',
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColors.primary,
                                  ),
                                ),
                                validator: (v) {
                                  final value = (v ?? '').trim();
                                  if (value.isEmpty) return 'Ingresa tu cédula';
                                  if (value.length < 8)
                                    return 'Cédula inválida';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Campo de contraseña con icono y toggle
                              TextFormField(
                                controller: _passCtrl,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  hintText: 'Ingresa tu contraseña',
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: AppColors.primary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (v) {
                                  final value = v ?? '';
                                  if (value.isEmpty)
                                    return 'Ingresa tu contraseña';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),

                              // Link "¿Olvidaste tu contraseña?"
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // TODO: Implementar recuperación de contraseña
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Recuperación de contraseña - Próximamente',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    '¿Olvidaste tu contraseña?',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Botón "Ingresar"
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  final loading = state is AuthLoading;
                                  return SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: loading ? null : _submit,
                                      child: loading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('Ingresar'),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),

                              // Divisor con "o"
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(color: AppColors.divider),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      'o',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(color: AppColors.divider),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Botón "Ingresar como invitado"
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _loginAsGuest,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryLight,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Ingresar como invitado'),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Texto de política de privacidad
                              const Text(
                                'Al crear una cuenta usted está de acuerdo con nuestra Política de Privacidad.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
