import 'package:scanner/Models/Receipt.dart';

abstract class ReceiptEvent {}

class LoadReceipts extends ReceiptEvent {}

class AddReceipt extends ReceiptEvent {
  final Receipt receipt;
  AddReceipt(this.receipt);
}

class DeleteReceipt extends ReceiptEvent {
  final int receiptId;
  DeleteReceipt(this.receiptId);
}