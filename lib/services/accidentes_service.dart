import 'package:dio/dio.dart';
import '../config/dio_client.dart';
import '../models/accidente_model.dart';

class AccidentesService {
  final Dio _dio = DioClient.getAccidentesClient();

  Future<List<Accidente>> getAccidentes() async {
    try {
      final response = await _dio.get('', queryParameters: {
        '\$limit': 100000,
      });

      final List data = response.data;
      return data.map((json) => Accidente.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al cargar accidentes: $e');
    }
  }
}