import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../constant/app_db.dart';

class SqliteHelper {
  SqliteHelper._();
  static SqliteHelper sqliteHelper = SqliteHelper._();

  Database? _database;

  Future<void> connectToDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();

    _database = await openDatabase(
      '${directory.path}/${AppDatabase.dbName}.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${AppDatabase.categoriesTable}(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(50),
            tran_type INTEGER,
            icon INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE ${AppDatabase.transactionsTable}(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date INTEGER,
            amount DOUBLE,
            category_id INTEGER,
            note VARCHAR(255),
            FOREIGN KEY(category_id) REFERENCES ${AppDatabase.categoriesTable}(id)
          )
        ''');
      },
    );
  }

  insertInitialCategpry(List<Map<String, dynamic>> data) async {
    for (var element in data) {
      await insertData(AppDatabase.categoriesTable, element);
    }
  }

  deleteDB() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    await databaseFactory.deleteDatabase(directory.path);
  }

  Future<List<Map<String, dynamic>>> getData(String table,
      [String? where, List<Object?>? whereArgs]) async {
    await connectToDatabase();

    return _database!.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, Object?>>> joinQuery() async {
    await connectToDatabase();

    return await _database!.rawQuery('''
    SELECT * FROM ${AppDatabase.transactionsTable} AS tran
    INNER JOIN ${AppDatabase.categoriesTable} AS cat
    ON cat.id = tran.category_id;
    ''');
  }

  Future<List<Map<String, Object?>>> truncateTable() async {
    await connectToDatabase();

    return await _database!
        .rawQuery('DELETE FROM ${AppDatabase.transactionsTable};');
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    await connectToDatabase();

    return await _database!.insert(table, data);
  }

  Future<int> updateData(String table, Map<String, dynamic> data,
      [String? where, List<Object?>? whereArgs]) async {
    await connectToDatabase();

    return await _database!.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> deleteData(String table,
      [String? where, List<Object?>? whereArgs]) async {
    await connectToDatabase();

    return await _database!.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
