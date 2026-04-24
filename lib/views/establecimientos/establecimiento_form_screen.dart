import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/establecimientos_service.dart';

class EstablecimientoFormScreen extends StatefulWidget {
  final int? id;
  final Map<String, dynamic>? datosIniciales;

  const EstablecimientoFormScreen({super.key, this.id, this.datosIniciales});

  @override
  State<EstablecimientoFormScreen> createState() =>
      _EstablecimientoFormScreenState();
}

class _EstablecimientoFormScreenState extends State<EstablecimientoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _nitCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  File? _imagenSeleccionada;
  bool _guardando = false;
  final _service = EstablecimientosService();

  bool get _esEdicion => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (_esEdicion && widget.datosIniciales != null) {
      _nombreCtrl.text = widget.datosIniciales!['nombre'] ?? '';
      _nitCtrl.text = widget.datosIniciales!['nit'] ?? '';
      _direccionCtrl.text = widget.datosIniciales!['direccion'] ?? '';
      _telefonoCtrl.text = widget.datosIniciales!['telefono'] ?? '';
    }
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final imagen = await picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      setState(() => _imagenSeleccionada = File(imagen.path));
    }
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_esEdicion && _imagenSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes seleccionar un logo')),
      );
      return;
    }

    setState(() => _guardando = true);
    try {
      if (_esEdicion) {
        await _service.editarEstablecimiento(
          id: widget.id!,
          nombre: _nombreCtrl.text,
          nit: _nitCtrl.text,
          direccion: _direccionCtrl.text,
          telefono: _telefonoCtrl.text,
          logoPath: _imagenSeleccionada?.path,
        );
      } else {
        await _service.crearEstablecimiento(
          nombre: _nombreCtrl.text,
          nit: _nitCtrl.text,
          direccion: _direccionCtrl.text,
          telefono: _telefonoCtrl.text,
          logoPath: _imagenSeleccionada!.path,
        );
      }
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar Establecimiento' : 'Nuevo Establecimiento'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _seleccionarImagen,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _imagenSeleccionada != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_imagenSeleccionada!,
                              fit: BoxFit.cover),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate,
                                size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Toca para seleccionar logo',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              _campo(_nombreCtrl, 'Nombre', Icons.store),
              _campo(_nitCtrl, 'NIT', Icons.badge),
              _campo(_direccionCtrl, 'Dirección', Icons.location_on),
              _campo(_telefonoCtrl, 'Teléfono', Icons.phone),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _guardando ? null : _guardar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: _guardando
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(_esEdicion ? 'Guardar cambios' : 'Crear establecimiento'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(
      TextEditingController ctrl, String label, IconData icono) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icono),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }
}
