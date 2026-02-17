import 'package:flutter/material.dart';

/// Paleta de colores - Prototipo Tesis
/// Diseño basado en tonos azul verdoso y beige
class AppColors {
  AppColors._(); // Constructor privado para evitar instanciación

  // ========================================
  // COLORES PRINCIPALES
  // ========================================

  /// Primary - Azul verdoso oscuro (#0F6E73)
  /// Usado para headers, AppBar, botones primarios, iconos principales
  static const Color primary = Color(0xFF0F6E73);

  /// Secondary - Beige claro (#F3E3C7)
  /// Usado para fondos de cards, contenedores secundarios
  static const Color secondary = Color(0xFFF3E3C7);

  /// Accent - Beige/dorado (#E6C99A)
  /// Usado para botones circulares, acentos decorativos, highlights
  static const Color accent = Color(0xFFE6C99A);

  /// Background - Beige muy claro (#FAF7F2)
  /// Usado para fondo general de la aplicación
  static const Color background = Color(0xFFFAF7F2);

  /// Error - Rojo para errores y alertas
  static const Color error = Color(0xFFD32F2F);

  /// Surface - Blanco para superficies elevadas
  static const Color surface = Colors.white;

  // ========================================
  // VARIACIONES DE COLORES
  // ========================================

  /// Primary Light - Azul verdoso más claro
  static const Color primaryLight = Color(0xFF1A9BA3);

  /// Primary Dark - Azul verdoso más oscuro
  static const Color primaryDark = Color(0xFF0A4E52);

  /// Secondary Light - Beige aún más claro
  static const Color secondaryLight = Color(0xFFF8EFE0);

  /// Accent Light - Dorado muy claro
  static const Color accentLight = Color(0xFFF2E5D5);

  /// Error Light - Fondo de error
  static const Color errorLight = Color(0xFFFFEBEE);

  // ========================================
  // COLORES DE TEXTO
  // ========================================

  /// Text Main - Texto principal (#3A3A3A) - Gris oscuro
  static const Color textMain = Color(0xFF3A3A3A);

  /// Text Soft - Texto secundario/ayuda (#6F6F6F) - Gris medio
  static const Color textSoft = Color(0xFF6F6F6F);

  /// Texto sobre color primario (azul verdoso)
  static const Color textOnPrimary = Colors.white;

  /// Texto sobre color secondary (beige)
  static const Color textOnSecondary = Color(0xFF3A3A3A);

  /// Texto sobre color de acento (dorado)
  static const Color textOnAccent = Color(0xFF3A3A3A);

  /// Texto sobre color de error (rojo)
  static const Color textOnError = Colors.white;

  // ========================================
  // COMPATIBILIDAD CON NOMBRES ANTERIORES
  // ========================================

  /// Alias para textMain (compatibilidad)
  static const Color textPrimary = textMain;

  /// Alias para textSoft (compatibilidad)
  static const Color textSecondary = textSoft;

  // ========================================
  // COLORES ADICIONALES
  // ========================================

  /// Divisores y bordes - Gris muy claro
  static const Color divider = Color(0xFFE0E0E0);

  /// Gris para elementos deshabilitados
  static const Color disabled = Color(0xFFBDBDBD);

  /// Sombras sutiles
  static const Color shadow = Color(0x1A000000);
}
