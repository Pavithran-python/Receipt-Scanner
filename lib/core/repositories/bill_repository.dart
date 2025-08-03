

import 'package:scanner/core/services/bill_api_service.dart';
import 'package:scanner/features/bills/models/bill_model.dart';

class BillRepository {
  final BillApiService apiService;

  BillRepository(this.apiService);

  Future<List<Bill>> getBills() => apiService.getAllBills();
  Future<Bill> getBillDetail(String id) => apiService.getBill(id);
  Future<Bill> createBill(Bill bill) => apiService.createBill(bill);
  Future<Bill> updateBill(String id, Map<String, dynamic> updates) => apiService.updateBill(id, updates);
  Future<Map<String,dynamic>> deleteBill(String id) => apiService.deleteBill(id);
  Future<Map<String, dynamic>> uploadImage(String base64) => apiService.uploadImage(base64);
}