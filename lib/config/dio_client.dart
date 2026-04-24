import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static Dio getAccidentesClient() {
    return Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL_ACCIDENTES'] ?? '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  static Dio getParkingClient() {
    return Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL_PARKING'] ?? '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }
}