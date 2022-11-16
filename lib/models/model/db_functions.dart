abstract class DBFunctions {
  Future<void> getData();
  Future<int> insertData();
  Future<int> updateData(String where, List<Object> whereArgs);
  Future<int> deleteData(String where, List<Object> whereArgs);
}
