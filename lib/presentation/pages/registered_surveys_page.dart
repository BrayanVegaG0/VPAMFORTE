import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/survey_submission.dart';
import '../state/survey/survey_bloc.dart';
import '../state/survey/survey_event.dart';
import '../state/survey/survey_state.dart';
import '../widgets/app_drawer.dart';

class RegisteredSurveysPage extends StatefulWidget {
  const RegisteredSurveysPage({super.key});

  @override
  State<RegisteredSurveysPage> createState() => _RegisteredSurveysPageState();
}

class _RegisteredSurveysPageState extends State<RegisteredSurveysPage> {
  Future<List<SurveySubmission>>? _future;
  final Set<String> _selected = <String>{};

  void _load() {
    final bloc = context.read<SurveyBloc>();
    final surveyId = bloc.state.activeSurvey?.id;
    if (surveyId == null) return;

    setState(() {
      _future = bloc.loadRegisteredSubmissions(surveyId);
      _selected.clear(); // al recargar, limpia selección para evitar inconsistencias
    });
  }

  @override
  void initState() {
    super.initState();
    // Carga inicial apenas la pantalla exista
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Encuestas Registradas'),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh),
            onPressed: _load,
          ),
        ],
      ),

      body: BlocListener<SurveyBloc, SurveyState>(
        // ✅ Solo reaccionar cuando TERMINA el envío (true -> false) o cuando hay mensaje nuevo
        listenWhen: (p, c) =>
        (p.isSending && !c.isSending) || (p.message != c.message) || (p.sendError != c.sendError),
        listener: (context, state) {
          final msg = state.message;
          if (msg != null && msg.trim().isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
          }
          // ✅ al terminar envío o si hubo cambios, recarga lista
          _load();
        },
        child: BlocBuilder<SurveyBloc, SurveyState>(
          builder: (context, state) {
            final survey = state.activeSurvey;
            if (survey == null) {
              return const Center(child: Text('No hay encuesta cargada.'));
            }

            final future = _future ?? context.read<SurveyBloc>().loadRegisteredSubmissions(survey.id);

            return FutureBuilder<List<SurveySubmission>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final list = snapshot.data ?? const [];

                if (list.isEmpty) {
                  return const Center(child: Text('No hay encuestas registradas aún.'));
                }

                // ✅ Seleccionables: solo pending o error (sent no debería venir porque lo borras del pending)
                final selectable = list.where((x) =>
                x.status == SubmissionStatus.pending || x.status == SubmissionStatus.error).toList();

                final allSelectableIds = selectable.map((e) => e.createdAt.toIso8601String()).toList();

                final selectedCount = _selected.length;
                final totalSelectable = allSelectableIds.length;

                final isAllSelected = totalSelectable > 0 && selectedCount == totalSelectable;

                return Column(
                  children: [
                    // ====== Seleccionar todo ======
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: isAllSelected,
                            onChanged: totalSelectable == 0
                                ? null
                                : (v) {
                              setState(() {
                                if (v == true) {
                                  _selected
                                    ..clear()
                                    ..addAll(allSelectableIds);
                                } else {
                                  _selected.clear();
                                }
                              });
                            },
                          ),
                          title: const Text('Seleccionar todo'),
                          subtitle: Text('Total: $totalSelectable'),
                          trailing: const Icon(Icons.swap_horiz),
                        ),
                      ),
                    ),

                    // ====== Lista ======
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final item = list[i];
                          final summary = _buildSummary(item);

                          final id = item.createdAt.toIso8601String();
                          final isSelectable = item.status == SubmissionStatus.pending ||
                              item.status == SubmissionStatus.error;
                          final checked = _selected.contains(id);

                          return Card(
                            child: ListTile(
                              leading: Checkbox(
                                value: checked,
                                onChanged: !isSelectable
                                    ? null
                                    : (v) {
                                  setState(() {
                                    if (v == true) {
                                      _selected.add(id);
                                    } else {
                                      _selected.remove(id);
                                    }
                                  });
                                },
                              ),
                              title: Text('Cédula: ${summary.cedula}'),
                              subtitle: Text(
                                '${summary.nombre}\n'
                                    'Creado: ${_fmtDateTime(item.createdAt)}',
                              ),
                              isThreeLine: true,

                              // ====== Chips de estado ======
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) async {
                                  if (value == 'view') {
                                    await _showViewDialog(context, item, summary);
                                  } else if (value == 'answers') {
                                    await _showAnswersDialog(context, item);
                                  } else if (value == 'delete') {
                                    final ok = await _confirmDelete(context);
                                    if (ok == true && context.mounted) {
                                      context.read<SurveyBloc>().add(
                                        DeletePendingSubmissionRequested(
                                          surveyId: item.surveyId,
                                          createdAtIso: item.createdAt.toIso8601String(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                itemBuilder: (_) => const [
                                  PopupMenuItem(value: 'view', child: Text('Ver')),
                                  PopupMenuItem(value: 'answers', child: Text('Ver answers')),
                                  PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                                ],
                              ),

                              // ====== Estado debajo (visible) ======
                              contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              dense: false,
                            ),
                          );
                        },
                      ),
                    ),

                    // footer text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Seleccionadas: $selectedCount / $totalSelectable'),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),

      // ====== Botón Sincronizar ======
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: BlocBuilder<SurveyBloc, SurveyState>(
          buildWhen: (p, c) => p.isSending != c.isSending || p.activeSurvey != c.activeSurvey,
          builder: (context, state) {
            final surveyId = state.activeSurvey?.id;
            final sending = state.isSending;

            final canSend = (surveyId != null) && !sending && _selected.isNotEmpty;

            return SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: canSend
                    ? () {
                  context.read<SurveyBloc>().add(
                    SendPendingSubmissions(
                      surveyId!,
                      selectedCreatedAtIso: _selected.toList(),
                    ),
                  );
                }
                    : null,
                icon: sending
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Icon(Icons.sync),
                label: Text(sending ? 'Sincronizando...' : 'Sincronizar (${_selected.length})'),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showAnswersDialog(BuildContext context, SurveySubmission item) async {
    final pretty = const JsonEncoder.withIndent('  ').convert(item.answers);

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Answers (raw JSON)'),
        content: SingleChildScrollView(child: SelectableText(pretty)),
        actions: [
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: pretty));
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Copiar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showViewDialog(BuildContext context, SurveySubmission item, _Summary s) async {
    String two(int n) => n.toString().padLeft(2, '0');
    String fmtDateTime(DateTime dt) {
      final date = '${dt.year.toString().padLeft(4, '0')}-${two(dt.month)}-${two(dt.day)}';
      final time = '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
      return '$date $time';
    }

    final created = fmtDateTime(item.createdAt);
    final statusText = item.status.name.toUpperCase();

    final isError = item.status == SubmissionStatus.error;
    final hasErrorText = item.lastError != null && item.lastError!.trim().isNotEmpty;

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        title: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person_outline)),
            const SizedBox(width: 12),
            Expanded(child: Text(s.nombre, maxLines: 2, overflow: TextOverflow.ellipsis)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (s.edad != null)
                    Chip(
                      avatar: const Icon(Icons.cake_outlined),
                      label: Text('${s.edad} años'),
                    ),
                  if (s.estadoCivil != null)
                    Chip(
                      avatar: const Icon(Icons.favorite_border),
                      label: Text(s.estadoCivil!),
                    ),
                  Chip(
                    avatar: Icon(isError ? Icons.error_outline : Icons.info_outline),
                    label: Text(statusText),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _kvRow('Cédula', s.cedula),
                      const Divider(height: 16),
                      _kvRow('Creado', created),
                      const Divider(height: 16),
                      _kvRow('Intentos', item.attempts.toString()),
                    ],
                  ),
                ),
              ),
              if (hasErrorText) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.errorContainer,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.error_outline, color: Theme.of(context).colorScheme.onErrorContainer),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.lastError!,
                          style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }

  Widget _kvRow(String k, String v) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 90, child: Text(k, style: const TextStyle(fontWeight: FontWeight.w600))),
        const SizedBox(width: 8),
        Expanded(child: Text(v, textAlign: TextAlign.right)),
      ],
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar encuesta'),
        content: const Text('Esto borrará este registro del almacenamiento local. ¿Continuar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );
  }

  _Summary _buildSummary(SurveySubmission item) {
    final a = item.answers;

    final nombres = (a['Nombres'] ?? '').toString().trim();
    final apellidos = (a['Apellidos'] ?? '').toString().trim();
    final nombre = ('$nombres $apellidos').trim().isEmpty ? '-' : ('$nombres $apellidos').trim();

    final cedula = (a['nroDocumentoM'] ?? '-').toString().trim();
    final estadoCivilId = (a['11'] ?? '').toString().trim();
    final estadoCivil = _estadoCivilLabel(estadoCivilId);

    final fechaNacStr = (a['fechaNacimientoM'] ?? '').toString().trim();
    final edad = _calcularEdad(fechaNacStr);

    return _Summary(
      nombre: nombre,
      cedula: cedula.isEmpty ? '-' : cedula,
      edad: edad,
      estadoCivil: estadoCivil,
    );
  }

  String? _calcularEdad(String yyyyMmDd) {
    if (yyyyMmDd.isEmpty) return null;
    final dob = DateTime.tryParse(yyyyMmDd);
    if (dob == null) return null;

    final now = DateTime.now();
    int years = now.year - dob.year;
    final hadBirthdayThisYear =
        (now.month > dob.month) || (now.month == dob.month && now.day >= dob.day);
    if (!hadBirthdayThisYear) years--;

    if (years < 0) return null;
    return years.toString();
  }

  String? _estadoCivilLabel(String id) {
    switch (id) {
      case '1':
        return 'Soltero/a';
      case '2':
        return 'Casado/a';
      case '3':
        return 'Separado/a';
      case '4':
        return 'Divorciado/a';
      case '5':
        return 'Viudo';
      case '6':
        return 'Unión Libre';
      default:
        return null;
    }
  }

  String _fmtDateTime(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    final date = '${dt.year.toString().padLeft(4, '0')}-${two(dt.month)}-${two(dt.day)}';
    final time = '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
    return '$date $time';
  }
}

class _Summary {
  final String nombre;
  final String cedula;
  final String? edad;
  final String? estadoCivil;

  _Summary({
    required this.nombre,
    required this.cedula,
    required this.edad,
    required this.estadoCivil,
  });
}
