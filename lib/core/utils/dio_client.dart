import 'package:dio/dio.dart';
import 'package:scanner/core/constants/constant.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}