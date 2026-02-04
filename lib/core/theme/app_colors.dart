import 'package:flutter/material.dart';

/// Paleta de colores de la aplicación Infancia EC
class AppColors {
  AppColors._(); // Constructor privado para evitar instanciación

  // ========================================
  // COLORES PRINCIPALES
  // ========================================

  /// Azul principal - Usado para encabezados, AppBar, botones primarios
  static const Color primary = Color(0xFF2D2D96);

  /// Rojo - Usado para errores, alertas, acciones destructivas
  /// Rojo - Usado para errores, alertas, acciones destructivas
  static const Color error = Color(0xFFD32F2F);

  /// Amarillo - Usado para acentos, highlights, elementos decorativos
  static const Color accent = Color(0xFFFFC003);

  /// Gris claro - Usado para fondos de la aplicación
  static const Color background = Color(0xFFEEEEEE);

  /// Blanco - Usado para cards, contenedores, superficies
  static const Color surface = Colors.white;

  // ========================================
  // VARIACIONES DE COLORES
  // ========================================

  /// Azul claro - Para botones secundarios o estados hover
  static const Color primaryLight = Color(0xFF4A4AB8);

  /// Azul oscuro - Para estados pressed o sombras
  static const Color primaryDark = Color(0xFF1F1F6B);

  /// Rojo claro - Para fondos de error
  static const Color errorLight = Color(0xFFFFEBEE);

  /// Amarillo claro - Para fondos de advertencia
  static const Color accentLight = Color(0xFFFFF9E6);

  // ========================================
  // COLORES DE TEXTO
  // ========================================

  /// Texto principal - Negro o gris muy oscuro
  static const Color textPrimary = Color(0xFF212121);

  /// Texto secundario - Gris medio
  static const Color textSecondary = Color(0xFF757575);

  /// Texto sobre color primario (azul)
  static const Color textOnPrimary = Colors.white;

  /// Texto sobre color de error (rojo)
  static const Color textOnError = Colors.white;

  /// Texto sobre color de acento (amarillo)
  static const Color textOnAccent = Color(0xFF212121);

  // ========================================
  // COLORES ADICIONALES
  // ========================================

  /// Divisores y bordes
  static const Color divider = Color(0xFFE0E0E0);

  /// Gris para elementos deshabilitados
  static const Color disabled = Color(0xFFBDBDBD);

  /// Sombras
  static const Color shadow = Color(0x1A000000);
}
