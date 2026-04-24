// ignore_for_file: unnecessary_underscores
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/establecimiento_model.dart';
import '../../services/establecimientos_service.dart';

class EstablecimientosScreen extends StatefulWidget {
  const EstablecimientosScreen({super.key});

  @override
  State<EstablecimientosScreen> createState() => _EstablecimientosScreenState();
}

class _EstablecimientosScreenState extends State<EstablecimientosScreen> {
  final _service = EstablecimientosService();
  List<Establecimiento> _establecimientos = [];
  bool _cargando = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    try {
      setState(() { _cargando = true; _error = null; });
      final data = await _service.getEstablecimientos();
      setState(() { _establecimientos = data; _cargando = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _cargando = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Establecimientos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push('/establecimientos/crear');
          _cargar();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
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
                    onPressed: _cargar,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : _cargando
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _establecimientos.length,
                  itemBuilder: (context, index) {
                    final e = _establecimientos[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: e.logo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  e.logo!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.store, size: 40),
                                ),
                              )
                            : const Icon(Icons.store, size: 40),
                        title: Text(e.nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('NIT: ${e.nit}\n${e.direccion}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () async {
                          await context.push(
                            '/establecimientos/detalle/${e.id}',
                            extra: {
                              'nombre': e.nombre,
                              'nit': e.nit,
                              'direccion': e.direccion,
                              'telefono': e.telefono,
                              'logo': e.logo,
                            },
                          );
                          _cargar();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}