// ignore_for_file: unnecessary_underscores
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/establecimientos_service.dart';

class EstablecimientoDetalleScreen extends StatelessWidget {
  final int id;
  final Map<String, dynamic> datos;

  const EstablecimientoDetalleScreen({
    super.key,
    required this.id,
    required this.datos,
  });

  @override
  Widget build(BuildContext context) {
    final service = EstablecimientosService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/establecimientos/editar/$id', extra: datos);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmar = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Eliminar'),
                  content: const Text('¿Estás seguro de eliminar este establecimiento?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Eliminar',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirmar == true) {
                await service.eliminarEstablecimiento(id);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (datos['logo'] != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    datos['logo'],
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.store, size: 80),
                  ),
                ),
              ),
            const SizedBox(height: 24),
            _campo('Nombre', datos['nombre']),
            _campo('NIT', datos['nit']),
            _campo('Dirección', datos['direccion']),
            _campo('Teléfono', datos['telefono']),
          ],
        ),
      ),
    );
  }

  Widget _campo(String label, String? valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(valor ?? '-', style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }
}