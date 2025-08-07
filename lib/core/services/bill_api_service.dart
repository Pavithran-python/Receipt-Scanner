import 'package:dio/dio.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/utils/check_internet_connection_method.dart';
import 'package:scanner/core/utils/dio_client.dart';
import 'package:scanner/features/bills/models/bill_model.dart';

class BillApiService {
  final Dio _dio = DioClient.dio;

  Future<List<Bill>> getAllBills() async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.get(billsEndPoint);
        return (response.data as List).map((e) => Bill.fromJson(e)).toList();
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception(noInternetConnectionMessage);
    }
  }

  Future<Bill> getBill(String id) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.get('$billsEndPoint/$id');
        return Bill.fromJson(response.data);
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception(noInternetConnectionMessage);
    }
  }

  Future<Bill> createBill(Bill bill) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.post(billsEndPoint, data: bill.toJson());
        return Bill.fromJson(response.data);
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception(noInternetConnectionMessage);
    }
  }

  Future<Bill> updateBill(String id, Map<String, dynamic> updates) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.put('$billsEndPoint/$id', data: updates);
        return Bill.fromJson(response.data);
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception(noInternetConnectionMessage);
    }
  }

  Future<Map<String, dynamic>> deleteBill(String id) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response  =await _dio.delete('$billsEndPoint/$id');
        return response.data;
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception(noInternetConnectionMessage);
    }
  }

  Future<Map<String, dynamic>> uploadImage(String base64String) async {
    if(await CheckInternetConnectionMethod()){
      try {
        final response = await _dio.post(uploadEndPoint, data: {
          imageBase64String: "$imageBase64Value$base64String"
        });
        return response.data;
      } on DioException catch (e) {
        _handleDioError(e);
      }
    }
    else{
      throw Exception(noInternetConnectionMessage);
    }
  }

  /// Common error handler to throw readable errors from Dio
  Never _handleDioError(DioException e) {
    String? message = unKnownError;
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data[message] != null && data[message].toString().isNotEmpty) {
        message = data[message];
      } else {
        message = "$error ${e.response?.statusCode} ${e.response?.statusMessage}";
      }
    } else {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        message = timeOut;
      } else if (e.type == DioExceptionType.unknown) {
        message = serverUnreachable;
      } else {
        message = e.message;
      }
    }
    throw Exception(message);
  }
}
