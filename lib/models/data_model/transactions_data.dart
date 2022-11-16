import '../../core/constant/app_db.dart';
import '../../core/helper/sqflite_helper.dart';
import '../model/transaction.dart';

class Transactions {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> getData() async {
    List<Map<String, dynamic>> res =
        await SqliteHelper.sqliteHelper.getData(AppDatabase.transactionsTable);

    for (var element in res) {
      _transactions.add(Transaction.fromMap(element));
    }
  }

  Future<int> insertData(Transaction tran) async {
    int rowId = await SqliteHelper.sqliteHelper
        .insertData(AppDatabase.transactionsTable, tran.toMap());
    return rowId;
  }

  Future<int> updateData(
      Transaction tran, String where, List<Object> whereArgs) async {
    int rowId = await SqliteHelper.sqliteHelper.updateData(
      AppDatabase.transactionsTable,
      tran.toMap(),
      where,
      whereArgs,
    );
    return rowId;
  }

  Future<int> deleteData(String where, List<Object> whereArgs) async {
    int rowId = await SqliteHelper.sqliteHelper
        .deleteData(AppDatabase.transactionsTable, where, whereArgs);
    return rowId;
  }
}
