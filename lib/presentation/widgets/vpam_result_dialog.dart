import 'package:flutter/material.dart';
import 'package:ficha_vulnerabilidad/domain/entities/response_vpam.dart';

class VpamResultDialog extends StatelessWidget {
  final ResponseVPAM result;

  const VpamResultDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final summary = result.summary;
    final color = _getVulnerabilityColor(summary.nivelVulnerabilidad);

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            summary.nivelVulnerabilidad == 'BAJA'
                ? Icons.check_circle
                : (summary.nivelVulnerabilidad == 'MEDIA'
                      ? Icons.warning
                      : Icons.error),
            color: color,
          ),
          const SizedBox(width: 8),
          const Text('Resultado VPAM'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nivel de Vulnerabilidad: ${summary.nivelVulnerabilidad}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            _buildScoreItem('Global:', summary.vulnerabilidadGlobalNormalizada),
            _buildScoreItem('Carencias:', summary.carenciasNormalizadas),
            _buildScoreItem('Riesgo Futuro:', summary.riesgoFuturoNormalizado),
            _buildScoreItem(
              'Dependencia:',
              summary.riesgoDependenciaNormalizado,
            ),

            if (summary.alertas.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Alertas:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...summary.alertas.map((alerta) => _buildAlertaItem(alerta)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CERRAR'),
        ),
      ],
    );
  }

  Widget _buildScoreItem(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '${value.toStringAsFixed(2)}%',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertaItem(Alerta alerta) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notification_important,
            size: 16,
            color: alerta.severidad == 'ALTA' ? Colors.red : Colors.orange,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(alerta.mensaje, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Color _getVulnerabilityColor(String nivel) {
    switch (nivel.toUpperCase()) {
      case 'BAJA':
        return Colors.green;
      case 'MEDIA':
        return Colors.orange;
      case 'ALTA':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
