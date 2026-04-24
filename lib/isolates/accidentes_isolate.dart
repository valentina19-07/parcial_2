// ignore_for_file: avoid_print
import '../models/accidente_model.dart';
import '../models/estadisticas_model.dart';

EstadisticasAccidentes procesarAccidentes(List<Accidente> accidentes) {
  final inicio = DateTime.now();
  print('[Isolate] Iniciado — ${accidentes.length} registros recibidos');

  // 1. Distribución por clase de accidente
  final Map<String, int> porClase = {};
  // 2. Distribución por gravedad
  final Map<String, int> porGravedad = {};
  // 3. Conteo por barrio
  final Map<String, int> todosBarrios = {};
  // 4. Distribución por día
  final Map<String, int> porDia = {};

  for (final accidente in accidentes) {
    // Clase de accidente
    final clase = accidente.claseAccidente.trim().isNotEmpty
        ? accidente.claseAccidente.trim()
        : 'Otros';
    porClase[clase] = (porClase[clase] ?? 0) + 1;

    // Gravedad
    final gravedad = accidente.gravedadAccidente.trim().isNotEmpty
        ? accidente.gravedadAccidente.trim()
        : 'Desconocido';
    porGravedad[gravedad] = (porGravedad[gravedad] ?? 0) + 1;

    // Barrio
    final barrio = accidente.barrio.trim().isNotEmpty
        ? accidente.barrio.trim()
        : 'Desconocido';
    todosBarrios[barrio] = (todosBarrios[barrio] ?? 0) + 1;

    // Día
    final dia = accidente.dia.trim().isNotEmpty
        ? accidente.dia.trim()
        : 'Desconocido';
    porDia[dia] = (porDia[dia] ?? 0) + 1;
  }

  // Top 5 barrios
  final listaBarrios = todosBarrios.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  final topBarrios = Map.fromEntries(listaBarrios.take(5));

  final fin = DateTime.now();
  final ms = fin.difference(inicio).inMilliseconds;
  print('[Isolate] Completado en $ms ms');

  return EstadisticasAccidentes(
    porClase: porClase,
    porGravedad: porGravedad,
    topBarrios: topBarrios,
    porDia: porDia,
  );
}