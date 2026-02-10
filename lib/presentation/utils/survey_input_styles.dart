import 'package:flutter/material.dart';

/// Centralized styles for survey input fields.
class SurveyInputStyles {
  SurveyInputStyles._(); // Private constructor

  /// Background color for input fields (white).
  static const Color inputFillColor = Colors.white;

  /// Border color for input fields (dark grey).
  static const Color inputBorderColor = Color(0xFF424242);

  /// Standard InputDecoration for all survey fields.
  static InputDecoration decoration({
    String? hintText,
    String? labelText,
    String? errorText,
    Widget? suffixIcon,
    bool isDense = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: inputFillColor,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      suffixIcon: suffixIcon,
      isDense: isDense,
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: inputBorderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: inputBorderColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: inputBorderColor, width: 2.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }
}
