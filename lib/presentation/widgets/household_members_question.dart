import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/household_member.dart';
import '../state/survey/survey_bloc.dart';
import '../state/survey/survey_event.dart';
import '../state/survey/survey_state.dart';

class HouseholdMembersQuestion extends StatelessWidget {
  final String questionId; // ej: 'personasHogarM'
  final bool markError;

  const HouseholdMembersQuestion({
    super.key,
    required this.questionId,
    required this.markError,
  });

  List<HouseholdMember> _decode(dynamic raw) {
    if (raw == null) return const [];
    try {
      if (raw is String) {
        final t = raw.trim();
        if (t.isEmpty) return const [];
        final decoded = jsonDecode(t);
        if (decoded is! List) return const [];
        return decoded
            .whereType<Map>()
            .map((m) => HouseholdMember.fromJson(Map<String, dynamic>.from(m)))
            .toList();
      }
      return const [];
    } catch (_) {
      return const [];
    }
  }

  void _save(BuildContext context, List<HouseholdMember> members) {
    final value = members.isEmpty
        ? '' // para que required falle correctamente
        : jsonEncode(members.map((e) => e.toJson()).toList());

    context.read<SurveyBloc>().add(
      SurveyAnswerChanged(questionId: questionId, value: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(
      buildWhen: (p, c) => p.answers != c.answers,
      builder: (context, state) {
        final members = _decode(state.answers[questionId]);
        final cedulas = members.map((e) => e.cedula).toList(growable: false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Agrega las personas que viven en el hogar',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final created = await showDialog<HouseholdMember>(
                      context: context,
                      builder: (_) => _MemberDialog(
                        existingCedulas: cedulas,
                        bloc: context.read<SurveyBloc>(),
                      ),
                    );
                    if (created == null) return;
                    _save(context, [...members, created]);
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Agregar'),
                ),
              ],
            ),

            if (markError) ...[
              const SizedBox(height: 8),
              const Text(
                'Debe agregar al menos una persona.',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],

            const SizedBox(height: 10),

            if (members.isEmpty)
              const Text('Sin registros.')
            else
              Column(
                children: [
                  for (int i = 0; i < members.length; i++)
                    Card(
                      child: ListTile(
                        title: Text(members[i].nombresApellidos),
                        subtitle: Text(
                          'Cédula: ${members[i].cedula}  •  Edad: ${members[i].edad}',
                        ),
                        trailing: Wrap(
                          spacing: 6,
                          children: [
                            IconButton(
                              tooltip: 'Ver',
                              icon: const Icon(Icons.visibility),
                              onPressed: () async {
                                await showDialog<void>(
                                  context: context,
                                  builder: (_) => _MemberDialog(
                                    initial: members[i],
                                    readOnly: true,
                                    existingCedulas: cedulas,
                                    editingIndex: i,
                                    bloc: context.read<SurveyBloc>(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              tooltip: 'Editar',
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final edited = await showDialog<HouseholdMember>(
                                  context: context,
                                  builder: (_) => _MemberDialog(
                                    initial: members[i],
                                    existingCedulas: cedulas,
                                    editingIndex:
                                        i, // permite misma cédula del registro
                                    bloc: context.read<SurveyBloc>(),
                                  ),
                                );
                                if (edited == null) return;
                                final next = [...members];
                                next[i] = edited;
                                _save(context, next);
                              },
                            ),
                            IconButton(
                              tooltip: 'Borrar',
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                final next = [...members]..removeAt(i);
                                _save(context, next);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}

// =========================
// Dialog (full fields + DINARDAP + condicionales)
// =========================

class _MemberDialog extends StatefulWidget {
  final HouseholdMember? initial;
  final bool readOnly;

  final List<String> existingCedulas;
  final int? editingIndex;

  final SurveyBloc bloc;

  const _MemberDialog({
    this.initial,
    this.readOnly = false,
    required this.existingCedulas,
    this.editingIndex,
    required this.bloc,
  });

  @override
  State<_MemberDialog> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<_MemberDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _cedula;
  late final TextEditingController _nombres;
  late final TextEditingController _edad;
  late final TextEditingController _porcentaje;
  late final TextEditingController _ingresoCuanto;

  // dropdowns / flags
  String? identidadGenero;
  String? tieneDiscapacidad;
  String? tipoDiscapacidad;
  String? enfermedadCatastrofica;
  String? etapaGestacional;
  String? menorTrabaja;
  String? parentesco;
  String? generaIngresos;

  bool _loadingDinardap = false;
  String? _dinardapError;

  // Campos poblados por DINARDAP (para hacerlos read-only)
  bool _nombreFromDinardap = false;
  bool _edadFromDinardap = false;

  bool get _ro => widget.readOnly;

  @override
  void initState() {
    super.initState();

    final i = widget.initial;
    _cedula = TextEditingController(text: i?.cedula ?? '');
    _nombres = TextEditingController(text: i?.nombresApellidos ?? '');
    _edad = TextEditingController(text: (i?.edad ?? '').toString());
    _porcentaje = TextEditingController(
      text: i?.porcentajeDiscapacidad?.toString() ?? '',
    );
    _ingresoCuanto = TextEditingController(
      text: i?.generaIngresosCuanto?.toString() ?? '',
    );

    identidadGenero = i?.identidadGenero;
    tieneDiscapacidad = i?.idTieneDiscapacidad;
    tipoDiscapacidad = i?.idTipoDiscapacidad;
    enfermedadCatastrofica = i?.enfermedadCatastrofica;
    etapaGestacional = i?.idEtapaGestacional;
    menorTrabaja = i?.idMenorTrabaja;
    parentesco = i?.idParentesco;
    generaIngresos = i?.idGeneraIngresos;
  }

  @override
  void dispose() {
    _cedula.dispose();
    _nombres.dispose();
    _edad.dispose();
    _porcentaje.dispose();
    _ingresoCuanto.dispose();
    super.dispose();
  }

  // ===== catálogos (puedes ajustar a tu catálogo real) =====
  static const _generos = <String, String>{
    '1': 'Hombre',
    '2': 'Mujer',
    '3': 'Otro / No binario',
    '4': 'Prefiere no decir',
  };

  static const _siNo = <String, String>{'1': 'Sí', '0': 'No'};

  static const _tipoDiscapacidad = <String, String>{
    '1': 'Física',
    '2': 'Intelectual',
    '3': 'Auditiva',
    '4': 'Visual',
    '5': 'Psicosocial',
    '6': 'Múltiple',
    '7': 'Otra',
  };

  static const _parentesco = <String, String>{
    '1': 'Padre',
    '2': 'Madre',
    '3': 'Hijo/a',
    '4': 'Cónyuge / Pareja',
    '5': 'Abuelo/a',
    '6': 'Nieto/a',
    '7': 'Hermano/a',
    '8': 'Tío/a',
    '9': 'Otro familiar',
    '10': 'No familiar',
  };

  bool get _isMujer => identidadGenero == '2';

  int? get _edadValue => int.tryParse(_edad.text.trim());

  bool get _isMenor => (_edadValue ?? 999) < 18;

  bool get _tieneDiscapacidadSi => tieneDiscapacidad == '1';

  bool get _generaIngresosSi => generaIngresos == '1';

  // ===== validaciones =====

  bool _isValidCedulaEc(String input) {
    final ced = input.replaceAll(RegExp(r'\D'), '');
    if (ced.length != 10) return false;

    final province = int.tryParse(ced.substring(0, 2)) ?? -1;
    if (province < 1 || province > 24) return false;

    final third = int.tryParse(ced.substring(2, 3)) ?? -1;
    if (third < 0 || third > 5) return false;

    final digits = ced.split('').map((e) => int.parse(e)).toList();
    final verifier = digits[9];

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      int v = digits[i];
      if (i % 2 == 0) {
        v *= 2;
        if (v > 9) v -= 9;
      }
      sum += v;
    }

    final mod = sum % 10;
    final check = (mod == 0) ? 0 : (10 - mod);
    return check == verifier;
  }

  bool _cedulaRepetida(String cedulaDigitsOnly) {
    final existing = [...widget.existingCedulas];

    // si editas, permite la cédula del índice actual
    if (widget.editingIndex != null &&
        widget.editingIndex! >= 0 &&
        widget.editingIndex! < existing.length) {
      existing.removeAt(widget.editingIndex!);
    }

    return existing.any(
      (c) => c.replaceAll(RegExp(r'\D'), '') == cedulaDigitsOnly,
    );
  }

  // ===== DINARDAP =====

  DateTime? _parseDdMmYyyy(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final parts = v.split('/');
    if (parts.length != 3) return null;
    final dd = int.tryParse(parts[0]) ?? 1;
    final mm = int.tryParse(parts[1]) ?? 1;
    final yyyy = int.tryParse(parts[2]) ?? 1900;
    return DateTime(yyyy, mm, dd);
  }

  int _calcAge(DateTime birth) {
    final now = DateTime.now();
    int age = now.year - birth.year;
    final beforeBirthday =
        (now.month < birth.month) ||
        (now.month == birth.month && now.day < birth.day);
    if (beforeBirthday) age--;
    return age;
  }

  Future<void> _consultDinardap() async {
    final cedula = _cedula.text.trim().replaceAll(RegExp(r'\D'), '');

    setState(() {
      _dinardapError = null;
    });

    if (cedula.length != 10) {
      setState(() => _dinardapError = 'La cédula debe tener 10 dígitos.');
      return;
    }
    if (!_isValidCedulaEc(cedula)) {
      setState(() => _dinardapError = 'Cédula inválida. Verifica el número.');
      return;
    }
    if (_cedulaRepetida(cedula)) {
      setState(
        () => _dinardapError = 'Esta cédula ya fue registrada en el hogar.',
      );
      return;
    }

    setState(() {
      _loadingDinardap = true;
      _dinardapError = null;
    });

    try {
      final person = await widget.bloc.consultDinardapNow(cedula);

      // person.nombresCompletos, person.fechaNacimientoDdMmYyyy (según tu implementación)
      final full = (person.nombresCompletos ?? '').toString().trim();
      final nac = (person.fechaNacimientoDdMmYyyy ?? '').toString().trim();

      if (full.isNotEmpty) {
        _nombres.text = full;
        _nombreFromDinardap = true;
      }

      final birth = _parseDdMmYyyy(nac);
      if (birth != null) {
        _edad.text = _calcAge(birth).toString();
        _edadFromDinardap = true;
      }

      setState(() {
        _loadingDinardap = false;
        _dinardapError = null;
      });
    } catch (e) {
      setState(() {
        _loadingDinardap = false;
        _dinardapError = 'No se pudo consultar DINARDAP. ${e.toString()}';
      });
    }
  }

  void _applyConditionalCleanup() {
    // Mujer? si no, borra gestacional
    if (!_isMujer) {
      etapaGestacional = null;
    }

    // Menor? si no, borra menorTrabaja
    if (!_isMenor) {
      menorTrabaja = null;
    }

    // Discapacidad? si no, borra tipo y porcentaje
    if (!_tieneDiscapacidadSi) {
      tipoDiscapacidad = null;
      _porcentaje.text = '';
    }

    // Ingresos? si no, borra cuánto
    if (!_generaIngresosSi) {
      _ingresoCuanto.text = '';
    }
  }

  String? _reqDropdown(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Requerido' : null;

  @override
  Widget build(BuildContext context) {
    final title = _ro
        ? 'Ver persona'
        : (widget.initial == null ? 'Agregar persona' : 'Editar persona');

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 560,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CÉDULA + botón DINARDAP
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cedula,
                        enabled: !_ro,
                        decoration: const InputDecoration(
                          labelText: 'Cédula',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          final ced = (v ?? '').trim().replaceAll(
                            RegExp(r'\D'),
                            '',
                          );
                          if (ced.isEmpty) return 'Requerido';
                          if (ced.length != 10) return 'Debe tener 10 dígitos';
                          if (!_isValidCedulaEc(ced)) return 'Cédula inválida';
                          if (_cedulaRepetida(ced))
                            return 'Cédula repetida en el hogar';
                          return null;
                        },
                        onChanged: (v) {
                          // Si se modifica la cédula, limpiar datos de DINARDAP
                          final ced = v.trim().replaceAll(RegExp(r'\D'), '');
                          if (ced.length < 10) {
                            setState(() {
                              if (_nombreFromDinardap) {
                                _nombres.clear();
                                _nombreFromDinardap = false;
                              }
                              if (_edadFromDinardap) {
                                _edad.clear();
                                _edadFromDinardap = false;
                              }
                              _dinardapError = null;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (!_ro)
                      SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _loadingDinardap ? null : _consultDinardap,
                          icon: _loadingDinardap
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.search),
                          label: const Text('DINARDAP'),
                        ),
                      ),
                  ],
                ),
                if (_dinardapError != null) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _dinardapError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
                const SizedBox(height: 12),

                TextFormField(
                  controller: _nombres,
                  enabled: !_ro && !_nombreFromDinardap,
                  decoration: InputDecoration(
                    labelText: 'Nombres y apellidos',
                    border: const OutlineInputBorder(),
                    suffixIcon: _nombreFromDinardap
                        ? const Icon(Icons.lock, size: 16, color: Colors.grey)
                        : null,
                  ),
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? 'Requerido' : null,
                  onChanged: (v) {
                    // Si el usuario modifica manualmente, quitar el lock
                    if (_nombreFromDinardap && v != _nombres.text) {
                      setState(() => _nombreFromDinardap = false);
                    }
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _edad,
                  enabled: !_ro && !_edadFromDinardap,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Edad',
                    border: const OutlineInputBorder(),
                    suffixIcon: _edadFromDinardap
                        ? const Icon(Icons.lock, size: 16, color: Colors.grey)
                        : null,
                  ),
                  validator: (v) {
                    final n = int.tryParse((v ?? '').trim());
                    if (n == null) return 'Edad inválida';
                    if (n < 0 || n > 120) return 'Edad fuera de rango';
                    return null;
                  },
                  onChanged: (v) {
                    // Si el usuario modifica manualmente, quitar el lock
                    if (_edadFromDinardap && v != _edad.text) {
                      setState(() => _edadFromDinardap = false);
                    }
                    _applyConditionalCleanup();
                  },
                ),
                const SizedBox(height: 12),

                // Identidad de género
                DropdownButtonFormField<String>(
                  value: identidadGenero,
                  decoration: const InputDecoration(
                    labelText: 'Identidad de género',
                    border: OutlineInputBorder(),
                  ),
                  items: _generos.entries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  onChanged: _ro
                      ? null
                      : (v) => setState(() {
                          identidadGenero = v;
                          _applyConditionalCleanup();
                        }),
                  validator: (v) => _reqDropdown(v),
                ),
                const SizedBox(height: 12),

                // Mujer -> Etapa gestacional
                if (_isMujer) ...[
                  DropdownButtonFormField<String>(
                    value: etapaGestacional,
                    decoration: const InputDecoration(
                      labelText: '¿Mujer en etapa gestacional?',
                      border: OutlineInputBorder(),
                    ),
                    items: _siNo.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(),
                    onChanged: _ro
                        ? null
                        : (v) => setState(() => etapaGestacional = v),
                    validator: (v) => _reqDropdown(v),
                  ),
                  const SizedBox(height: 12),
                ],

                // <18 -> Menor trabaja
                if (_isMenor) ...[
                  DropdownButtonFormField<String>(
                    value: menorTrabaja,
                    decoration: const InputDecoration(
                      labelText: '¿Menor de edad trabajando?',
                      border: OutlineInputBorder(),
                    ),
                    items: _siNo.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(),
                    onChanged: _ro
                        ? null
                        : (v) => setState(() => menorTrabaja = v),
                    validator: (v) => _reqDropdown(v),
                  ),
                  const SizedBox(height: 12),
                ],

                // Tiene discapacidad
                DropdownButtonFormField<String>(
                  value: tieneDiscapacidad,
                  decoration: const InputDecoration(
                    labelText: '¿Tiene discapacidad?',
                    border: OutlineInputBorder(),
                  ),
                  items: _siNo.entries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  onChanged: _ro
                      ? null
                      : (v) => setState(() {
                          tieneDiscapacidad = v;
                          _applyConditionalCleanup();
                        }),
                  validator: (v) => _reqDropdown(v),
                ),
                const SizedBox(height: 12),

                // Discapacidad -> Tipo + porcentaje
                if (_tieneDiscapacidadSi) ...[
                  DropdownButtonFormField<String>(
                    value: tipoDiscapacidad,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de discapacidad',
                      border: OutlineInputBorder(),
                    ),
                    items: _tipoDiscapacidad.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(),
                    onChanged: _ro
                        ? null
                        : (v) => setState(() => tipoDiscapacidad = v),
                    validator: (v) => _reqDropdown(v),
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _porcentaje,
                    enabled: !_ro,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Porcentaje de discapacidad (0-100)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final n = int.tryParse((v ?? '').trim());
                      if (n == null) return 'Requerido';
                      if (n < 0 || n > 100) return 'Debe estar entre 0 y 100';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                ],

                // Enfermedad catastrófica
                DropdownButtonFormField<String>(
                  value: enfermedadCatastrofica,
                  decoration: const InputDecoration(
                    labelText: '¿Enfermedad catastrófica?',
                    border: OutlineInputBorder(),
                  ),
                  items: _siNo.entries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  onChanged: _ro
                      ? null
                      : (v) => setState(() => enfermedadCatastrofica = v),
                  validator: (v) => _reqDropdown(v),
                ),
                const SizedBox(height: 12),

                // Parentesco
                DropdownButtonFormField<String>(
                  value: parentesco,
                  decoration: const InputDecoration(
                    labelText: 'Parentesco',
                    border: OutlineInputBorder(),
                  ),
                  items: _parentesco.entries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  onChanged: _ro ? null : (v) => setState(() => parentesco = v),
                  validator: (v) => _reqDropdown(v),
                ),
                const SizedBox(height: 12),

                // Genera ingresos?
                DropdownButtonFormField<String>(
                  value: generaIngresos,
                  decoration: const InputDecoration(
                    labelText: '¿Genera ingresos?',
                    border: OutlineInputBorder(),
                  ),
                  items: _siNo.entries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  onChanged: _ro
                      ? null
                      : (v) => setState(() {
                          generaIngresos = v;
                          _applyConditionalCleanup();
                        }),
                  validator: (v) => _reqDropdown(v),
                ),
                const SizedBox(height: 12),

                if (_generaIngresosSi) ...[
                  TextFormField(
                    controller: _ingresoCuanto,
                    enabled: !_ro,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: '¿Cuánto genera de ingresos?',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final d = double.tryParse(
                        (v ?? '').trim().replaceAll(',', '.'),
                      );
                      if (d == null) return 'Requerido';
                      if (d < 0) return 'No puede ser negativo';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
        if (!_ro)
          ElevatedButton(
            onPressed: () {
              _applyConditionalCleanup();

              if (!_formKey.currentState!.validate()) return;

              final cedulaDigits = _cedula.text.trim().replaceAll(
                RegExp(r'\D'),
                '',
              );

              final member = HouseholdMember(
                cedula: cedulaDigits,
                nombresApellidos: _nombres.text.trim(),
                edad: int.parse(_edad.text.trim()),

                identidadGenero: identidadGenero,
                idTieneDiscapacidad: tieneDiscapacidad,
                idTipoDiscapacidad: _tieneDiscapacidadSi
                    ? tipoDiscapacidad
                    : null,
                porcentajeDiscapacidad: _tieneDiscapacidadSi
                    ? int.tryParse(_porcentaje.text.trim())
                    : null,

                enfermedadCatastrofica: enfermedadCatastrofica,
                idEtapaGestacional: _isMujer ? etapaGestacional : null,
                idMenorTrabaja: _isMenor ? menorTrabaja : null,

                idParentesco: parentesco,

                idGeneraIngresos: generaIngresos,
                generaIngresosCuanto: _generaIngresosSi
                    ? double.tryParse(
                        _ingresoCuanto.text.trim().replaceAll(',', '.'),
                      )
                    : null,
              );

              Navigator.pop(context, member);
            },
            child: const Text('Guardar'),
          ),
      ],
    );
  }
}
