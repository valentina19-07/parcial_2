import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficaGravedad extends StatelessWidget {
  final Map<String, int> datos;
  const GraficaGravedad({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    final colores = [Colors.red, Colors.orange, Colors.green, Colors.grey];
    final entradas = datos.entries.toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Distribución por Gravedad',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: List.generate(entradas.length, (i) {
                    final total = datos.values.fold(0, (a, b) => a + b);
                    final porcentaje = (entradas[i].value / total * 100);
                    return PieChartSectionData(
                      value: entradas[i].value.toDouble(),
                      title: '${porcentaje.toStringAsFixed(1)}%',
                      color: colores[i % colores.length],
                      radius: 80,
                      titleStyle: const TextStyle(
                          fontSize: 11, color: Colors.white,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: List.generate(entradas.length, (i) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 12, height: 12,
                      color: colores[i % colores.length]),
                  const SizedBox(width: 4),
                  Text(entradas[i].key,
                      style: const TextStyle(fontSize: 11)),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}