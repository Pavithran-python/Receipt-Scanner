import 'package:scanner/features/bills/models/bill_model.dart';

abstract class BillEvent {}

class LoadBills extends BillEvent {}

class AddBill extends BillEvent {
  final Bill bill;
  AddBill(this.bill);
}

class UpdateBill extends BillEvent {
  final String id;
  final Map<String, dynamic> updates;
  UpdateBill(this.id, this.updates);
}

class DeleteBill extends BillEvent {
  final String id;
  DeleteBill(this.id);
}

class UploadImageEvent extends BillEvent {
  final String base64;
  UploadImageEvent(this.base64);
}
/*
class AddBillToListEvent extends BillEvent {
  final Bill newBill;
  AddBillToListEvent(this.newBill);
}*/
