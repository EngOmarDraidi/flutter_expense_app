import 'package:flutter/material.dart';
import '../../core/constant/app_db.dart';
import '../core/functions/functions.dart';
import '../core/services/app_states.dart';
import '../../core/helper/sqflite_helper.dart';
import '../models/model/db_functions.dart';
import '../models/model/transaction.dart';

class TransactionsController extends ChangeNotifier with DBFunctions {
  GlobalKey formKey = GlobalKey<FormState>();
  BuildContext appContext = AppState.navigatorKey.currentContext!;
  NavigatorState navigator =
      Navigator.of(AppState.navigatorKey.currentContext!);
  TextEditingController amount = TextEditingController();
  TextEditingController note = TextEditingController();
  DateTime date = DateTime.now();
  int categoryId = 0;
  String categoryTitle = 'Not Selected';
  int categorySelected = -1;
  String categoryIcon = '';
  int tranType = 0;
  bool isLoading = true;
  bool isFinishCauculate = true;
  int tranFilter = 0;

  final Map<String, dynamic> moneyDetails = {
    'total': {'expense': 0.0, 'income': 0.0},
    'details': [
      {'expense': 0.0, 'income': 0.0},
      {'expense': 0.0, 'income': 0.0},
      {'expense': 0.0, 'income': 0.0},
    ],
  };
  final List<Transaction> _allTransactions = [];
  List<Transaction> _expenseTransactions = [];
  List<Transaction> _incomeTransactions = [];

  List<Transaction> get allTransactions => _allTransactions;

  List<Transaction> get expenseTransactions {
    final DateTime dateFilter = DateTime.now();

    if (tranFilter == 0) {
      return _expenseTransactions.where((element) {
        final DateTime tranDate =
            DateTime.fromMillisecondsSinceEpoch(element.date as int);

        final int diff = dateFilter.difference(tranDate).inDays;

        if (diff == 0) {
          return true;
        }
        return false;
      }).toList();
    } else if (tranFilter == 1) {
      return _expenseTransactions.where((element) {
        final DateTime tranDate =
            DateTime.fromMillisecondsSinceEpoch(element.date as int);

        final int diff = dateFilter.difference(tranDate).inDays;

        if (diff <= 30) {
          return true;
        }
        return false;
      }).toList();
    } else {
      return _expenseTransactions.where((element) {
        final DateTime tranDate =
            DateTime.fromMillisecondsSinceEpoch(element.date as int);

        final int diff = dateFilter.difference(tranDate).inDays;

        if (diff <= 365) {
          return true;
        }
        return false;
      }).toList();
    }
  }

  List<Transaction> get incomeTransactions {
    final DateTime dateFilter = DateTime.now();

    if (tranFilter == 0) {
      return _incomeTransactions.where((element) {
        final DateTime tranDate =
            DateTime.fromMillisecondsSinceEpoch(element.date as int);

        final int diff = dateFilter.difference(tranDate).inDays;

        if (diff == 0) {
          return true;
        }
        return false;
      }).toList();
    } else if (tranFilter == 1) {
      return _incomeTransactions.where((element) {
        final DateTime tranDate =
            DateTime.fromMillisecondsSinceEpoch(element.date as int);

        final int diff = dateFilter.difference(tranDate).inDays;

        if (diff <= 30) {
          return true;
        }
        return false;
      }).toList();
    } else {
      return _incomeTransactions.where((element) {
        final DateTime tranDate =
            DateTime.fromMillisecondsSinceEpoch(element.date as int);

        final int diff = dateFilter.difference(tranDate).inDays;

        if (diff <= 365) {
          return true;
        }
        return false;
      }).toList();
    }
  }

  Future<bool> checkForm() async {
    if (amount.text.trim().isEmpty && categorySelected == -1) {
      await myDialog(appContext, ['Amount', 'Category']);
      return false;
    } else if (amount.text.trim().isEmpty) {
      await myDialog(appContext, 'Amount');
      return false;
    } else if (categorySelected == -1) {
      await myDialog(appContext, 'Category');
      return false;
    }
    return true;
  }

  changeTranFilter(int index) {
    tranFilter = index;

    notifyListeners();
  }

  changeTranType(int type) {
    tranType = type;
    categoryId = 0;
    categorySelected = -1;
    categoryTitle = 'Not Selected';
    update();
  }

  update() {
    notifyListeners();
  }

  changeCategorySelected(int index, int id, String title, String icon) {
    categoryIcon = icon;
    categorySelected = index;
    categoryId = id;
    categoryTitle = title;

    notifyListeners();
  }

  clearData() {
    note.clear();
    amount.clear();
    categoryId = 0;
    categoryTitle = 'Not Selected';
    categorySelected = -1;
    categoryIcon = '';
    tranType = 0;

    update();
  }

  @override
  Future<void> getData() async {
    final DateTime dateTime = DateTime.now();
    _expenseTransactions = [];
    _incomeTransactions = [];

    final List<Map<String, dynamic>> result =
        await SqliteHelper.sqliteHelper.joinQuery();

    for (var tran in result) {
      Transaction newTran = Transaction.fromMap(tran);
      final int days = dateTime
          .difference(DateTime.fromMillisecondsSinceEpoch(newTran.date as int))
          .inDays;

      if (newTran.tranType == 0) {
        moneyDetails['total']['expense'] =
            moneyDetails['total']['expense'] + newTran.amount;

        if (days == 0) {
          moneyDetails['details'][0]['expense'] =
              moneyDetails['details'][0]['expense']! + newTran.amount!;
        }
        if (days <= 30) {
          moneyDetails['details'][1]['expense'] =
              moneyDetails['details'][1]['expense']! + newTran.amount!;
        }
        if (days <= 365) {
          moneyDetails['details'][2]['expense'] =
              moneyDetails['details'][2]['expense']! + newTran.amount!;
        }
        _expenseTransactions.add(newTran);
      } else {
        moneyDetails['total']['income'] =
            moneyDetails['total']['income'] + newTran.amount;

        if (days == 0) {
          moneyDetails['details'][0]['income'] =
              moneyDetails['details'][0]['income']! + newTran.amount!;
        }
        if (days <= 30) {
          moneyDetails['details'][1]['income'] =
              moneyDetails['details'][1]['income']! + newTran.amount!;
        }
        if (days <= 365) {
          moneyDetails['details'][2]['income'] =
              moneyDetails['details'][2]['income']! + newTran.amount!;
        }
        _incomeTransactions.add(newTran);
      }
      _allTransactions.add(newTran);
    }
    isLoading = false;

    update();
  }

  @override
  Future<int> insertData() async {
    final bool isValid = await checkForm();

    if (!isValid) {
      return 0;
    }

    Transaction newTransaction = Transaction.fromMap({
      'date': date.millisecondsSinceEpoch,
      'amount': double.parse(amount.text.trim()),
      'category_id': categoryId,
      'name': categoryTitle,
      'icon': categoryIcon,
      'tran_type': tranType,
      'note': note.text.trim().toLowerCase(),
    });

    int tranId = -1;

    if (tranType == 0) {
      tranId = _expenseTransactions.indexWhere(
        (element) => newTransaction.categoryId == element.categoryId,
      );
    } else {
      tranId = _incomeTransactions.indexWhere(
        (element) => newTransaction.categoryId == element.categoryId,
      );
    }

    if (tranId == -1) {
      final int rowId = await SqliteHelper.sqliteHelper.insertData(
        AppDatabase.transactionsTable,
        newTransaction.toMap(),
      );

      allTransactions.add(newTransaction);

      tranType == 0
          ? _expenseTransactions.add(newTransaction)
          : _incomeTransactions.add(newTransaction);

      clearData();

      update();
      return rowId;
    } else {
      if (tranType == 0) {
        newTransaction.amount =
            newTransaction.amount! + _expenseTransactions[tranId].amount!;
      } else {
        newTransaction.amount =
            newTransaction.amount! + _incomeTransactions[tranId].amount!;
      }

      final int rowId = await SqliteHelper.sqliteHelper.updateData(
        AppDatabase.transactionsTable,
        newTransaction.toMap(),
        'category_id = ?',
        [newTransaction.categoryId],
      );

      allTransactions.add(newTransaction);

      if (tranType == 0) {
        _expenseTransactions[tranId] = newTransaction;
      } else {
        _incomeTransactions[tranId] = newTransaction;
      }

      clearData();

      update();
      return rowId;
    }
  }

  @override
  Future<int> updateData(String where, List<Object> whereArgs) async {
    final int rowId = await SqliteHelper.sqliteHelper.updateData(
      AppDatabase.categoriesTable,
      {},
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
