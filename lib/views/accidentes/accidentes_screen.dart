import 'package:flutter/material.dart';
import '../../models/estadisticas_model.dart';
import '../../services/accidentes_service.dart';
import '../../isolates/accidentes_isolate.dart';
import 'widgets/grafica_clase.dart';
import 'widgets/grafica_gravedad.dart';
import 'widgets/grafica_barrios.dart';
import 'widgets/grafica_dias.dart';

class AccidentesScreen extends StatefulWidget {
  const AccidentesScreen({super.key});

  @override
  State<AccidentesScreen> createState() => _AccidentesScreenState();
}

class _AccidentesScreenState extends State<AccidentesScreen> {
  EstadisticasAccidentes? _estadisticas;
  bool _cargando = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    try {
      setState(() { _cargando = true; _error = null; });
      final service = AccidentesService();
      final accidentes = await service.getAccidentes();
      final stats = await Future(() => procesarAccidentes(accidentes));
      setState(() { _estadisticas = stats; _cargando = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _cargando = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Accidentes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(_error!, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _cargarDatos,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : _cargando
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Cargando estadísticas...',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Esto puede tardar unos segundos',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GraficaClase(datos: _estadisticas!.porClase),
                      const SizedBox(height: 16),
                      GraficaGravedad(datos: _estadisticas!.porGravedad),
                      const SizedBox(height: 16),
                      GraficaBarrios(datos: _estadisticas!.topBarrios),
                      const SizedBox(height: 16),
                      GraficaDias(datos: _estadisticas!.porDia),
                    ],
                  ),
                ),
    );
  }
}