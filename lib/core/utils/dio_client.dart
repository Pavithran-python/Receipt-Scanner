import 'package:dio/dio.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/constants/sizes.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: AppSizes.callingTimeoutSecond),
      receiveTimeout: const Duration(seconds: AppSizes.callingTimeoutSecond),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}