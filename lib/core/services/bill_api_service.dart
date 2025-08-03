import 'package:dio/dio.dart';
import 'package:scanner/core/utils/check_internet_connection_method.dart';
import 'package:scanner/core/utils/dio_client.dart';
import 'package:scanner/features/bills/models/bill_model.dart';

class BillApiService {
  final Dio _dio = DioClient.dio;

  Future<List<Bill>> getAllBills() async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.get('/bills');
        print("Get All Bill Response : ${response.data}");
        return (response.data as List).map((e) => Bill.fromJson(e)).toList();
      } on DioException catch (e) {
        print("Error : ${e.toString()}");
        _handleDioError(e);
      }
    }
    else{
      throw Exception("No internet connection");
    }
  }

  Future<Bill> getBill(String id) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.get('/bills/$id');
        return Bill.fromJson(response.data);
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception("No internet connection");
    }
  }

  Future<Bill> createBill(Bill bill) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.post('/bills', data: bill.toJson());
        return Bill.fromJson(response.data);
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception("No internet connection");
    }
  }

  Future<Bill> updateBill(String id, Map<String, dynamic> updates) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.put('/bills/$id', data: updates);
        return Bill.fromJson(response.data);
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception("No internet connection");
    }
  }

  Future<Map<String, dynamic>> deleteBill(String id) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response  =await _dio.delete('/bills/$id');
        return response.data;
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception("No internet connection");
    }
  }

  Future<Map<String, dynamic>> uploadImage(String base64String) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.post('/upload', data: {
          "imageBase64": "data:image/png;base64,$base64String"
        });
        return response.data;
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception("No internet connection");
    }
  }

  /// Common error handler to throw readable errors from Dio
  Never _handleDioError(DioException e) {
    String? message = "Unknown error";

    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data['message'] != null && data['message'].toString().isNotEmpty) {
        message = data['message'];
      } else {
        message = "Error: ${e.response?.statusCode} ${e.response?.statusMessage}";
      }
    } else {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        message = "Connection timed out";
      } else if (e.type == DioExceptionType.unknown) {
        message = "No Internet or Server Unreachable";
      } else {
        message = e.message;
      }
    }

    throw Exception(message);
  }
}
