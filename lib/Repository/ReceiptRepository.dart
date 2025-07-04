import 'package:scanner/Database/ReceiptDatabase.dart';
import 'package:scanner/Models/Receipt.dart';

class ReceiptRepository {
  final db = ReceiptDatabase.instance;

  Future<List<Receipt>> getReceipts() => db.getReceipts();

  Future<void> insertReceipt(Receipt receipt) => db.insertReceipt(receipt);

  Future<void> deleteReceipt(int id) => db.deleteReceipt(id);
}