

import 'package:scanner/features/bills/models/bill_model.dart';

abstract class BillState {}

class BillInitial extends BillState {}

class BillLoading extends BillState {}

class BillLoaded extends BillState {
  final List<Bill> bills;
  BillLoaded(this.bills);
}

class BillOperationSuccess extends BillState {
  final Bill bill;
  BillOperationSuccess(this.bill);
}

class BillError extends BillState {
  final String message;
  BillError(this.message);
}

class DeleteBillSuccess extends BillState {
  final Map<String, dynamic> deleteResponse;
  DeleteBillSuccess(this.deleteResponse);
}

class ImageUploadSuccess extends BillState {
  final Map<String, dynamic> response;
  ImageUploadSuccess(this.response);
}


