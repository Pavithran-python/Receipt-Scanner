import 'package:scanner/features/bills/models/bill_model.dart';

abstract class BillListEvent {}

class LoadBills extends BillListEvent {}

class AddBillToListEvent extends BillListEvent {
  final Bill newBill;
  AddBillToListEvent(this.newBill);
}

class DeleteBillToListEvent extends BillListEvent {
  final String billId;
  DeleteBillToListEvent(this.billId);
}

class UpdateBillToListEvent extends BillListEvent {
  final Bill updateBill;
  UpdateBillToListEvent(this.updateBill);
}