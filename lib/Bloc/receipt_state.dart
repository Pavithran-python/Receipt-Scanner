import 'package:scanner/Models/Receipt.dart';

abstract class ReceiptState {}
class ReceiptLoading extends ReceiptState {}
class ReceiptLoaded extends ReceiptState {
  final List<Receipt> receipts;
  ReceiptLoaded(this.receipts);
}