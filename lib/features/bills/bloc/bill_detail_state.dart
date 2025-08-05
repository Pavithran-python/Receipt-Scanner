import 'package:scanner/features/bills/models/bill_model.dart';

abstract class BillDetailState {}

class BillDetailInitial extends BillDetailState {}

class BillDetailLoading extends BillDetailState {}

class BillDeleteLoading extends BillDetailState {}

class BillGetDetailLoading extends BillDetailState {}

class BillOperationSuccess extends BillDetailState {
  final Bill bill;
  BillOperationSuccess(this.bill);
}

class DeleteBillSuccess extends BillDetailState {
  final Map<String, dynamic> deleteResponse;
  DeleteBillSuccess(this.deleteResponse);
}

class ImageUploadSuccess extends BillDetailState {
  final Map<String, dynamic> response;
  ImageUploadSuccess(this.response);
}

class BillDetailError extends BillDetailState {
  final String message;
  BillDetailError(this.message);
}