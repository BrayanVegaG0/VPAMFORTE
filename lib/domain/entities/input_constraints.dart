enum InputMode {
  text,
  integer,
  decimal,
}

class InputConstraints {
  final InputMode mode;

  // Longitud
  final int? minLength;
  final int? maxLength;

  // Rango numérico
  final num? minValue;
  final num? maxValue;

  // Regex (formato)
  final String? pattern;

  // Decimales permitidos (solo decimal)
  final int? decimalPlaces;

  const InputConstraints({
    this.mode = InputMode.text,
    this.minLength,
    this.maxLength,
    this.minValue,
    this.maxValue,
    this.pattern,
    this.decimalPlaces,
  });
}