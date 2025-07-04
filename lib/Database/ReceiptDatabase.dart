import 'package:path/path.dart';
import 'package:scanner/Models/Receipt.dart';
import 'package:sqflite/sqflite.dart';

class ReceiptDatabase {
  static final ReceiptDatabase instance = ReceiptDatabase._init();
  static Database? _database;
  ReceiptDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('receipt.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE receipts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        merchant TEXT,
        total REAL,
        date TEXT,
        category TEXT,
        items TEXT,
        imageBase64 TEXT
      )
    ''');
  }

  Future<List<Receipt>> getReceipts() async {
    final db = await instance.database;
    final result = await db.query('receipts');
    return result.map((map) => Receipt.fromMap(map)).toList();
  }

  Future<void> insertReceipt(Receipt receipt) async {
    final db = await instance.database;
    await db.insert('receipts', receipt.toMap());
  }

  Future<void> deleteReceipt(int id) async {
    final db = await instance.database;
    await db.delete(
      'receipts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}