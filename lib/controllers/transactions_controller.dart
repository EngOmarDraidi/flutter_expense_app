import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
  final List<Transaction> listFilterTran = [];
  final List<Transaction> dailyTrans = [];
  final List<Transaction> monthlyTrans = [];
  final List<Transaction> yearlyTrans = [];

  Map<String, dynamic> moneyDetails = {
    'total': {'expense': 0.0, 'income': 0.0},
    'details': [
      {'expense': 0.0, 'income': 0.0},
      {'expense': 0.0, 'income': 0.0},
      {'expense': 0.0, 'income': 0.0},
    ],
  };
  List<Transaction> _allTransactions = [];
  List<Map<String, List<Transaction>>> _filterTransactions = [
    {'expense': [], 'income': []},
    {'expense': [], 'income': []},
    {'expense': [], 'income': []},
  ];

  List<Transaction> get allTransactions => _allTransactions;
  List<Map<String, List<Transaction>>> get filterTransactions =>
      _filterTransactions;

  Future<void> getAllTransactions() async {
    _filterTransactions = [
      {'expense': [], 'income': []},
      {'expense': [], 'income': []},
      {'expense': [], 'income': []}
    ];
    moneyDetails = {
      'total': {'expense': 0.0, 'income': 0.0},
      'details': [
        {'expense': 0.0, 'income': 0.0},
        {'expense': 0.0, 'income': 0.0},
        {'expense': 0.0, 'income': 0.0},
      ],
    };

    final List<Map<String, dynamic>> dailyData = await SqliteHelper.sqliteHelper
        .getDataByGroup(AppDatabase.transactionsTable,
            where: 'WHERE dateDiff < 1');

    final List<Map<String, dynamic>> monthlyData = await SqliteHelper
        .sqliteHelper
        .getDataByGroup(AppDatabase.transactionsTable,
            where: 'WHERE dateDiff <= 31');

    final List<Map<String, dynamic>> yearlyData = await SqliteHelper
        .sqliteHelper
        .getDataByGroup(AppDatabase.transactionsTable,
            where: 'WHERE dateDiff <= 365');

    for (var tran in dailyData) {
      if (tran['tran_type'] == 0) {
        moneyDetails['details'][0]['expense'] =
            moneyDetails['details'][0]['expense'] + tran['amount'];
        (_filterTransactions[0]['expense'] as List)
            .add(Transaction.fromMap(tran));
      } else {
        moneyDetails['details'][0]['income'] =
            moneyDetails['details'][0]['income'] + tran['amount'];
        (_filterTransactions[0]['income'] as List)
            .add(Transaction.fromMap(tran));
      }
    }
    for (var tran in monthlyData) {
      if (tran['tran_type'] == 0) {
        moneyDetails['details'][1]['expense'] =
            moneyDetails['details'][1]['expense'] + tran['amount'];
        (_filterTransactions[1]['expense'] as List)
            .add(Transaction.fromMap(tran));
      } else {
        moneyDetails['details'][1]['income'] =
            moneyDetails['details'][1]['income'] + tran['amount'];
        (_filterTransactions[1]['income'] as List)
            .add(Transaction.fromMap(tran));
      }
    }

    for (var tran in yearlyData) {
      if (tran['tran_type'] == 0) {
        moneyDetails['details'][2]['expense'] =
            moneyDetails['details'][2]['expense'] + tran['amount'];
        (_filterTransactions[2]['expense'] as List)
            .add(Transaction.fromMap(tran));
      } else {
        moneyDetails['details'][2]['income'] =
            moneyDetails['details'][2]['income'] + tran['amount'];
        (_filterTransactions[2]['income'] as List)
            .add(Transaction.fromMap(tran));
      }
    }

    isFinishCauculate = false;
    notifyListeners();
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
    categorySelected = 0;
    categoryId = 0;
    categoryTitle = 'Not Selected';
    categorySelected = -1;
    categoryIcon = '';
    tranType = 0;

    update();
  }

  @override
  Future<void> getData() async {
    _allTransactions = [];
    moneyDetails['total'] = {'expense': 0.0, 'income': 0.0};

    final data =
        await SqliteHelper.sqliteHelper.getData(AppDatabase.transactionsTable);

    for (var tran in data) {
      if (tran['tran_type'] == 0) {
        moneyDetails['total']['expense'] =
            moneyDetails['total']['expense'] + tran['amount'];
      } else {
        moneyDetails['total']['income'] =
            moneyDetails['total']['income'] + tran['amount'];
      }

      _allTransactions.add(Transaction.fromMap(tran));
    }

    isLoading = false;

    await Future.delayed(
      const Duration(seconds: 2),
    );

    update();
  }

  @override
  Future<int> insertData() async {
    final bool isValid = await checkForm();

    if (!isValid) {
      return 0;
    }

    Transaction newTransaction = Transaction.fromMap({
      'date': date.millisecondsSinceEpoch.toString(),
      'amount': double.parse(amount.text.trim()),
      'category_id': categoryId,
      'name': categoryTitle,
      'icon': categoryIcon,
      'tran_type': tranType,
      'note': note.text.trim().toLowerCase(),
    });

    final int rowId = await SqliteHelper.sqliteHelper.insertData(
      AppDatabase.transactionsTable,
      newTransaction.toMap(),
    );

    _allTransactions.add(newTransaction);

    final DateTime currentDate = DateTime.now();

    if (tranType == 0) {
      moneyDetails['total']['expense'] =
          moneyDetails['total']['expense'] + newTransaction.amount!;

      if (currentDate.difference(date).inDays == 0) {
        moneyDetails['details'][0]['expense'] =
            moneyDetails['details'][0]['expense'] + newTransaction.amount!;
        int index =
            (_filterTransactions[0]['expense'] as List<Transaction>).indexWhere(
          (element) => element.categoryName == newTransaction.categoryName,
        );
        if (index != -1) {
          (_filterTransactions[0]['expense'] as List<Transaction>)[index]
                  .amount =
              (_filterTransactions[0]['expense'] as List<Transaction>)[index]
                      .amount! +
                  newTransaction.amount!;
        } else {
          (_filterTransactions[0]['expense'] as List).add(newTransaction);
        }
      }
      if (currentDate.difference(date).inDays <= 30) {
        moneyDetails['details'][1]['expense'] =
            moneyDetails['details'][1]['expense'] + newTransaction.amount!;
        int index =
            (_filterTransactions[1]['expense'] as List<Transaction>).indexWhere(
          (element) => element.categoryName == newTransaction.categoryName,
        );
        if (index != -1) {
          (_filterTransactions[1]['expense'] as List<Transaction>)[index]
                  .amount =
              (_filterTransactions[1]['expense'] as List<Transaction>)[index]
                      .amount! +
                  newTransaction.amount!;
        } else {
          (_filterTransactions[1]['expense'] as List).add(newTransaction);
        }
      }
      if (currentDate.difference(date).inDays <= 365) {
        moneyDetails['details'][2]['expense'] =
            moneyDetails['details'][2]['expense'] + newTransaction.amount!;
        int index =
            (_filterTransactions[2]['expense'] as List<Transaction>).indexWhere(
          (element) => element.categoryName == newTransaction.categoryName,
        );
        if (index != -1) {
          (_filterTransactions[2]['expense'] as List<Transaction>)[index]
                  .amount =
              (_filterTransactions[2]['expense'] as List<Transaction>)[index]
                      .amount! +
                  newTransaction.amount!;
        } else {
          (_filterTransactions[2]['expense'] as List).add(newTransaction);
        }
      }
    } else {
      moneyDetails['total']['income'] =
          moneyDetails['total']['income'] + newTransaction.amount!;
      if (currentDate.difference(date).inDays == 0) {
        moneyDetails['details'][0]['income'] =
            moneyDetails['details'][0]['income'] + newTransaction.amount!;
        int index =
            (_filterTransactions[0]['income'] as List<Transaction>).indexWhere(
          (element) => element.categoryName == newTransaction.categoryName,
        );
        if (index != -1) {
          (_filterTransactions[0]['income'] as List<Transaction>)[index]
                  .amount =
              (_filterTransactions[0]['income'] as List<Transaction>)[index]
                      .amount! +
                  newTransaction.amount!;
        } else {
          (_filterTransactions[0]['income'] as List).add(newTransaction);
        }
      }
      if (currentDate.difference(date).inDays <= 30) {
        moneyDetails['details'][1]['income'] =
            moneyDetails['details'][1]['income'] + newTransaction.amount!;
        int index =
            (_filterTransactions[1]['income'] as List<Transaction>).indexWhere(
          (element) => element.categoryName == newTransaction.categoryName,
        );
        if (index != -1) {
          (_filterTransactions[1]['income'] as List<Transaction>)[index]
                  .amount =
              (_filterTransactions[1]['income'] as List<Transaction>)[index]
                      .amount! +
                  newTransaction.amount!;
        } else {
          (_filterTransactions[1]['income'] as List).add(newTransaction);
        }
      }
      if (currentDate.difference(date).inDays <= 365) {
        moneyDetails['details'][2]['income'] =
            moneyDetails['details'][2]['income'] + newTransaction.amount!;
        int index =
            (_filterTransactions[2]['income'] as List<Transaction>).indexWhere(
          (element) => element.categoryName == newTransaction.categoryName,
        );
        if (index != -1) {
          (_filterTransactions[2]['income'] as List<Transaction>)[index]
                  .amount =
              (_filterTransactions[2]['income'] as List<Transaction>)[index]
                      .amount! +
                  newTransaction.amount!;
        } else {
          (_filterTransactions[2]['income'] as List).add(newTransaction);
        }
      }
    }

    clearData();

    update();
    return rowId;
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
