import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/survey_submission.dart';
import '../state/survey/survey_bloc.dart';
import '../state/survey/survey_event.dart';
import '../state/survey/survey_state.dart';
import '../widgets/app_drawer.dart';
import '../../core/theme/app_colors.dart';

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
      _selected
          .clear(); // al recargar, limpia selección para evitar inconsistencias
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
      appBar: AppBar(title: const Text('Encuestas Registradas')),

      body: BlocListener<SurveyBloc, SurveyState>(
        // ✅ Solo reaccionar cuando TERMINA el envío (true -> false) o cuando hay mensaje nuevo
        listenWhen: (p, c) =>
            (p.isSending && !c.isSending) ||
            (p.message != c.message) ||
            (p.sendError != c.sendError),
        listener: (context, state) {
          final msg = state.message;
          if (msg != null && msg.trim().isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
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

            final future =
                _future ??
                context.read<SurveyBloc>().loadRegisteredSubmissions(survey.id);

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
                  return const Center(
                    child: Text('No hay encuestas registradas aún.'),
                  );
                }

                // ✅ Seleccionables: solo pending o error (sent no debería venir porque lo borras del pending)
                final selectable = list
                    .where(
                      (x) =>
                          x.status == SubmissionStatus.pending ||
                          x.status == SubmissionStatus.error,
                    )
                    .toList();

                final allSelectableIds = selectable
                    .map((e) => e.createdAt.toIso8601String())
                    .toList();

                final selectedCount = _selected.length;
                final totalSelectable = allSelectableIds.length;

                final isAllSelected =
                    totalSelectable > 0 && selectedCount == totalSelectable;

                return Column(
                  children: [
                    // ====== Card Informativa (Header) ======
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Card(
                        elevation: 0,
                        color: AppColors.primary.withOpacity(0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: AppColors.primary.withOpacity(0.1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Gestión de Encuestas',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      'Aquí puedes gestionar las encuestas guardadas localmente y sincronizarlas con el servidor.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ====== Seleccionar todo ======
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: InkWell(
                        onTap: totalSelectable == 0
                            ? null
                            : () {
                                setState(() {
                                  if (isAllSelected) {
                                    _selected.clear();
                                  } else {
                                    _selected
                                      ..clear()
                                      ..addAll(allSelectableIds);
                                  }
                                });
                              },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isAllSelected
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: totalSelectable == 0
                                    ? Colors.grey
                                    : AppColors.primary,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Seleccionar todo',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Disponibles: $totalSelectable',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.swap_horiz,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ====== Lista ======
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final item = list[i];
                          final summary = _buildSummary(item);

                          final id = item.createdAt.toIso8601String();
                          final isSelectable =
                              item.status == SubmissionStatus.pending ||
                              item.status == SubmissionStatus.error;
                          final checked = _selected.contains(id);

                          return Card(
                            elevation: 2,
                            shadowColor: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: checked
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: InkWell(
                              onTap: !isSelectable
                                  ? null
                                  : () {
                                      setState(() {
                                        if (checked) {
                                          _selected.remove(id);
                                        } else {
                                          _selected.add(id);
                                        }
                                      });
                                    },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (isSelectable)
                                          Icon(
                                            checked
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: AppColors.primary,
                                            size: 22,
                                          ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Cédula: ${summary.cedula}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                summary.nombre,
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 13,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            size: 20,
                                          ),
                                          onSelected: (value) async {
                                            if (value == 'answers') {
                                              await _showAnswersDialog(
                                                context,
                                                item,
                                              );
                                            } else if (value == 'delete') {
                                              final ok = await _confirmDelete(
                                                context,
                                              );
                                              if (ok == true &&
                                                  context.mounted) {
                                                context.read<SurveyBloc>().add(
                                                  DeletePendingSubmissionRequested(
                                                    surveyId: item.surveyId,
                                                    createdAtIso: item.createdAt
                                                        .toIso8601String(),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          itemBuilder: (_) => const [
                                            PopupMenuItem(
                                              value: 'answers',
                                              child: Text(
                                                'Ver respuestas JSON',
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text(
                                                'Eliminar',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (summary.edad != null)
                                          Text(
                                            'Edad: ${summary.edad} años',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        Text(
                                          'Registrado el: ${_fmtDateTime(item.createdAt)}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _buildStatusBadge(item),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
        minimum: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          24,
        ), // ✅ Aumentado el padding inferior
        child: BlocBuilder<SurveyBloc, SurveyState>(
          buildWhen: (p, c) =>
              p.isSending != c.isSending || p.activeSurvey != c.activeSurvey,
          builder: (context, state) {
            final surveyId = state.activeSurvey?.id;
            final sending = state.isSending;

            final canSend =
                (surveyId != null) && !sending && _selected.isNotEmpty;

            return FutureBuilder<List<SurveySubmission>>(
              future:
                  _future ??
                  context.read<SurveyBloc>().loadRegisteredSubmissions(
                    surveyId ?? '',
                  ),
              builder: (context, snapshot) {
                final list = snapshot.data ?? [];
                final selectable = list
                    .where(
                      (x) =>
                          x.status == SubmissionStatus.pending ||
                          x.status == SubmissionStatus.error,
                    )
                    .toList();
                final totalSelectable = selectable.length;

                return SizedBox(
                  height: 56,
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    icon: sending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.sync),
                    label: Text(
                      sending
                          ? 'Sincronizando...'
                          : 'Sincronizar (${_selected.length} / $totalSelectable)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _showAnswersDialog(
    BuildContext context,
    SurveySubmission item,
  ) async {
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

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar encuesta'),
        content: const Text(
          'Esto borrará este registro del almacenamiento local. ¿Continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  _Summary _buildSummary(SurveySubmission item) {
    final a = item.answers;

    final nombres = (a['Nombres'] ?? '').toString().trim();
    final apellidos = (a['Apellidos'] ?? '').toString().trim();
    final nombre = ('$nombres $apellidos').trim().isEmpty
        ? '-'
        : ('$nombres $apellidos').trim();

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
        (now.month > dob.month) ||
        (now.month == dob.month && now.day >= dob.day);
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
    final date =
        '${dt.year.toString().padLeft(4, '0')}-${two(dt.month)}-${two(dt.day)}';
    final time = '${two(dt.hour)}:${two(dt.minute)}';
    return '$date $time';
  }

  Widget _buildStatusBadge(SurveySubmission item) {
    Color color;
    String text;
    IconData icon;

    if (item.status == SubmissionStatus.pending) {
      color = Colors.blue;
      text = 'Lista para enviar';
      icon = Icons.hourglass_empty;
    } else if (item.status == SubmissionStatus.error) {
      color = Colors.red;
      text = 'ERROR INTERNO (${item.attempts} intentos)';
      icon = Icons.error_outline;
    } else {
      color = Colors.green;
      text = 'Enviado';
      icon = Icons.check_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
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
