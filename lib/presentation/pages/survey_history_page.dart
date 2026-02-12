import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../state/survey/survey_bloc.dart';
import '../state/survey/survey_state.dart';
import '../state/survey/survey_event.dart';
import '../../core/theme/app_colors.dart';

class SurveyHistoryPage extends StatefulWidget {
  const SurveyHistoryPage({super.key});

  @override
  State<SurveyHistoryPage> createState() => _SurveyHistoryPageState();
}

class _SurveyHistoryPageState extends State<SurveyHistoryPage> {
  late DateTime _selectedDate;
  bool _isOffline = false;
  bool _hasAttemptedLoad = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _checkConnectivityAndLoad();
  }

  Future<void> _checkConnectivityAndLoad() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = !connectivityResult.contains(ConnectivityResult.none);

    setState(() {
      _isOffline = !isConnected;
      _hasAttemptedLoad = true;
    });

    if (isConnected) {
      if (mounted) {
        context.read<SurveyBloc>().add(const SurveyLoadHistoryRequested());
      }
    }
  }

  Future<void> _refresh() async {
    await _checkConnectivityAndLoad();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Envíos'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.accent,
        elevation: 1,
      ),
      body: _hasAttemptedLoad
          ? (_isOffline ? _buildOfflineView() : _buildHistoryView())
          : const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
    );
  }

  Widget _buildOfflineView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              'Sin conexión a internet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Conéctese a internet para ver el historial de envíos',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _refresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Reconectarse a internet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryView() {
    return Column(
      children: [
        // Date picker header
        Container(
          color: AppColors.primary.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fecha seleccionada:',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      _formatDateHeader(_selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: _selectDate,
                icon: const Icon(Icons.edit_calendar, size: 18),
                label: const Text('Cambiar'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<SurveyBloc, SurveyState>(
            builder: (context, state) {
              if (state.isHistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              final allHistory = state.history;

              // Filter by selected date
              final filteredList = allHistory.where((item) {
                final itemDate = DateTime(
                  item.sentAt.year,
                  item.sentAt.month,
                  item.sentAt.day,
                );
                final selectedDay = DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                );
                return itemDate.isAtSameMomentAs(selectedDay);
              }).toList();

              if (filteredList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No hay encuestas enviadas en esta fecha',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return Card(
                      elevation: 2,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  radius: 20,
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.accent,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.nombres,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'C.I.: ${item.cedula}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Edad: ${item.edad ?? "N/A"}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  item.servicio,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Enviado: ${_formatDate(item.sentAt)}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatDateHeader(DateTime dt) {
    final weekday = _getWeekdayName(dt.weekday);
    return '$weekday, ${dt.day}/${dt.month}/${dt.year}';
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
