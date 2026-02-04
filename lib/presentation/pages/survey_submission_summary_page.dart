import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/theme/app_colors.dart';

import '../../domain/entities/survey_section.dart';
import '../../domain/rules/survey_rules_engine.dart';
import '../state/survey/survey_bloc.dart';
import '../state/survey/survey_event.dart';
import '../state/survey/survey_state.dart';
import '../utils/survey_section_filter_helper.dart';
import '../utils/question_progress_helper.dart';

/// Pantalla de resumen pre-envío
/// Muestra al usuario qué secciones completó antes de enviar la encuesta
class SurveySubmissionSummaryPage extends StatelessWidget {
  const SurveySubmissionSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Encuesta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<SurveyBloc, SurveyState>(
        builder: (context, state) {
          final survey = state.activeSurvey;
          if (survey == null) {
            return const Center(child: Text('No hay encuesta activa'));
          }

          // ✅ Contar solo preguntas visibles según el flujo
          final rules = const SurveyRulesEngine();
          final visibleSections = SurveySectionFilterHelper.getVisibleSections(
            surveySectionsOrder,
            state.answers,
          );
          final totalQuestions = QuestionProgressHelper.countVisibleQuestions(
            survey.questions,
            state.answers,
            rules,
            visibleSections,
          );
          final answeredQuestions =
              QuestionProgressHelper.countAnsweredVisibleQuestions(
                survey.questions,
                state.answers,
                rules,
                visibleSections,
              );
          final progress = totalQuestions > 0
              ? answeredQuestions / totalQuestions
              : 0.0;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // TARJETA DE PROGRESO GENERAL
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 32,
                            color: Colors.blue[700],
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Progreso General',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Preguntas respondidas',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '$answeredQuestions / $totalQuestions',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C2FA3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF2C2FA3),
                          ),
                          minHeight: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(progress * 100).toStringAsFixed(0)}% completado',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Secciones de la Encuesta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // LISTA DE SECCIONES (filtradas por edad)
              for (var i = 0; i < surveySectionsOrder.length; i++)
                if (SurveySectionFilterHelper.shouldShowSection(
                  surveySectionsOrder[i],
                  state.answers,
                ))
                  _buildSectionCard(context, state, survey, i),

              const SizedBox(height: 32),

              // BOTONES DE ACCIÓN
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // VERIFICACIÓN ESTRICTA DE UBICACIÓN
                        final serviceEnabled =
                            await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: AppColors.primary,
                                content: Text(
                                  'La ubicación es obligatoria para enviar la encuesta. Por favor actívela.',
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                          return;
                        }

                        if (!context.mounted) return;
                        Navigator.pop(context);
                        context.read<SurveyBloc>().add(
                          const SurveyFinalizeRequested(),
                        );
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Enviar Encuesta'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF2C2FA3),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Advertencia si faltan respuestas
              if (answeredQuestions < totalQuestions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0), // Padding extra
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.orange[700]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Hay ${totalQuestions - answeredQuestions} pregunta(s) sin responder. '
                            'Puedes enviar de todas formas o revisar para completar.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    SurveyState state,
    dynamic survey,
    int index,
  ) {
    final section = surveySectionsOrder[index];
    final rules = const SurveyRulesEngine();

    // ✅ Contar solo preguntas visibles de esta sección
    final sectionQuestions = survey.questions
        .where((q) => q.section == section && rules.isVisible(q, state.answers))
        .toList();
    final sectionAnswered = sectionQuestions
        .where((q) => QuestionProgressHelper.isAnswered(q, state.answers[q.id]))
        .length;
    final sectionTotal = sectionQuestions.length;
    final isCompleted = sectionAnswered == sectionTotal && sectionTotal > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCompleted ? Colors.green : Colors.grey[300],
          child: Icon(
            isCompleted ? Icons.check : Icons.edit_outlined,
            color: isCompleted ? Colors.white : Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(
          section.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$sectionAnswered / $sectionTotal preguntas',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: () {
          // Retornamos el índice para que SurveysPage sepa a dónde ir
          // y active el modo "Edición desde Resumen".
          Navigator.pop(context, index);
        },
      ),
    );
  }
}
