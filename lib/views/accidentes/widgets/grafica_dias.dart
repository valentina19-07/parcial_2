import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficaDias extends StatelessWidget {
  final Map<String, int> datos;
  const GraficaDias({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    final orden = ['Lunes', 'Martes', 'Miércoles', 'Jueves',
        'Viernes', 'Sábado', 'Domingo'];
    final entradas = datos.entries.toList()
      ..sort((a, b) {
        final ia = orden.indexOf(a.key);
        final ib = orden.indexOf(b.key);
        if (ia == -1 && ib == -1) return 0;
        if (ia == -1) return 1;
        if (ib == -1) return -1;
        return ia.compareTo(ib);
      });

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Accidentes por Día de la Semana',
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
                        color: Colors.orange,
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
                          final dia = entradas[i].key;
                          final corto = dia.length > 3
                              ? dia.substring(0, 3)
                              : dia;
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(corto,
                                style: const TextStyle(fontSize: 10)),
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