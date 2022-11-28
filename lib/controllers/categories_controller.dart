import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'icons_controller.dart';
import '../core/constant/app_db.dart';
import '../core/functions/functions.dart';
import '../core/services/app_states.dart';
import '../core/helper/sqflite_helper.dart';
import '../models/model/db_functions.dart';
import '../models/model/category.dart';

class CategoriesController extends ChangeNotifier with DBFunctions {
  GlobalKey<FormState> formKey = GlobalKey();
  BuildContext appContext = AppState.navigatorKey.currentContext!;
  NavigatorState navigator =
      Navigator.of(AppState.navigatorKey.currentContext!);
  TextEditingController categoryName = TextEditingController();
  IconsController? provider;
  int tranType = 0;

  List<Category> _categories = [];

  List<Category> get categories => _categories
      .where((element) => element.transactionType == tranType)
      .toList();

  Future<bool> checkForm() async {
    if (categoryName.text.trim().isEmpty) {
      await myDialog(appContext, 'Name');
      return false;
    }
    return true;
  }

  void filterCategories(int indexTranType) {
    tranType = indexTranType;

    notifyListeners();
  }

  @override
  Future<List<Category>> getData() async {
    _categories = [];

    final List<Map<String, dynamic>> result =
        await SqliteHelper.sqliteHelper.getData(AppDatabase.categoriesTable);

    for (var category in result) {
      _categories.add(Category.fromMap(category));
    }

    return _categories;
  }

  @override
  Future<int> insertData() async {
    provider = Provider.of<IconsController>(
        AppState.navigatorKey.currentContext!,
        listen: false);

    final bool isValid = await checkForm();
    if (!isValid) {
      return 0;
    }

    Category newCategory = Category(
      categoryName.text.trim(),
      provider!.iconName,
      tranType,
    );

    final int rowId = await SqliteHelper.sqliteHelper.insertData(
      AppDatabase.categoriesTable,
      newCategory.toMap(),
    );

    categoryName.text = '';
    provider!.iconSelected = 29;
    tranType = 0;

    newCategory.id = rowId;
    _categories.add(newCategory);
    notifyListeners();

    navigator.pop();

    return rowId;
  }

  @override
  Future<int> updateData(String where, List<Object> whereArgs) async {
    Category category = Category(
      categoryName.text.trim(),
      provider!.iconName,
      tranType,
    );

    final int rowId = await SqliteHelper.sqliteHelper.updateData(
      AppDatabase.categoriesTable,
      category.toMap(),
      where,
      whereArgs,
    );

    return rowId;
  }

  @override
  Future<int> deleteData(String where, List<Object> whereArgs) async {
    final int rowId = await SqliteHelper.sqliteHelper.deleteData(
      AppDatabase.categoriesTable,
      where,
      whereArgs,
    );

    return rowId;
  }
}
