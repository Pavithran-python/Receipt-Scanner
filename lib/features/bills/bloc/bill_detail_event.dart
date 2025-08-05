import 'package:scanner/features/bills/models/bill_model.dart';

abstract class BillDetailEvent {}

class GetBill extends BillDetailEvent {
  final String id;
  GetBill(this.id);
}

class AddBill extends BillDetailEvent {
  final Bill bill;
  AddBill(this.bill);
}

class UpdateBill extends BillDetailEvent {
  final String id;
  final Map<String, dynamic> updates;
  UpdateBill(this.id, this.updates);
}

class DeleteBill extends BillDetailEvent {
  final String id;
  DeleteBill(this.id);
}

class UploadImageEvent extends BillDetailEvent {
  final String base64;
  UploadImageEvent(this.base64);
}