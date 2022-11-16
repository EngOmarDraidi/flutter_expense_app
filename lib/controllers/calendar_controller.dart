import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CalendarController extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  DateTime transactionFilterDate = DateTime.now();
  final bool todaySelected = true;

  changeTransactionFilterDate(int index) {
    transactionFilterDate = Jiffy().add(months: index).dateTime;
    notifyListeners();
  }

  changeData(DateTime day) {
    selectedDay = day;
    notifyListeners();
  }
}
