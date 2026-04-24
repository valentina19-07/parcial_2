import 'package:dio/dio.dart';
import '../config/dio_client.dart';
import '../models/establecimiento_model.dart';

class EstablecimientosService {
  final Dio _dio = DioClient.getParkingClient();

  // GET todos
  Future<List<Establecimiento>> getEstablecimientos() async {
    try {
      final response = await _dio.get('/establecimientos');
      final List data = response.data['data'] ?? response.data;
      return data.map((json) => Establecimiento.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al cargar establecimientos: $e');
    }
  }

  // GET uno
  Future<Establecimiento> getEstablecimiento(int id) async {
    try {
      final response = await _dio.get('/establecimientos/$id');
      return Establecimiento.fromJson(response.data['data'] ?? response.data);
    } catch (e) {
      throw Exception('Error al cargar establecimiento: $e');
    }
  }

  // POST crear
  Future<void> crearEstablecimiento({
    required String nombre,
    required String nit,
    required String direccion,
    required String telefono,
    required String logoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'nombre': nombre,
        'nit': nit,
        'direccion': direccion,
        'telefono': telefono,
        'logo': await MultipartFile.fromFile(logoPath),
      });
      await _dio.post('/establecimientos', data: formData);
    } catch (e) {
      throw Exception('Error al crear establecimiento: $e');
    }
  }

  // POST editar (con _method=PUT)
  Future<void> editarEstablecimiento({
  required int id,
  required String nombre,
  required String nit,
  required String direccion,
  required String telefono,
  String? logoPath,
}) async {
  try {
    final map = <String, dynamic>{
      '_method': 'PUT',
      'nombre': nombre,
      'nit': nit,
      'direccion': direccion,
      'telefono': telefono,
    };

    if (logoPath != null) {
      map['logo'] = await MultipartFile.fromFile(logoPath);
    }

    final formData = FormData.fromMap(map);
    await _dio.post('/api/establecimientos/$id', data: formData);
  } catch (e) {
    throw Exception('Error al editar establecimiento: $e');
  }
}

  // DELETE
  Future<void> eliminarEstablecimiento(int id) async {
    try {
      await _dio.delete('/establecimientos/$id');
    } catch (e) {
      throw Exception('Error al eliminar establecimiento: $e');
    }
  }
}