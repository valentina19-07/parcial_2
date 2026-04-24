import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficaBarrios extends StatelessWidget {
  final Map<String, int> datos;
  const GraficaBarrios({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    final entradas = datos.entries.toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Top 5 Barrios con más Accidentes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: entradas.isEmpty ? 10 :
                      entradas.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble() * 1.2,
                  barGroups: List.generate(entradas.length, (i) =>
                    BarChartGroupData(x: i, barRods: [
                      BarChartRodData(
                        toY: entradas[i].value.toDouble(),
                        color: Colors.blue,
                        width: 22,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4)),
                      ),
                    ]),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i >= entradas.length) return const SizedBox();
                          final nombre = entradas[i].key;
                          final corto = nombre.length > 8
                              ? '${nombre.substring(0, 8)}...'
                              : nombre;
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(corto,
                                style: const TextStyle(fontSize: 9)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}