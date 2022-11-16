import 'package:flutter/material.dart';
import '../core/helper/shared_preferences_helper.dart';

class CurrenciesController extends ChangeNotifier {
  int? index;

  Future<void> changeCurrency(int indexCurrency) async {
    index = indexCurrency;
    print(index);
    bool i = await sharedPreferencesApp.setData('currency_code', indexCurrency);
    print(i);
    notifyListeners();
  }

  void getCurrency() {
    notifyListeners();
  }
}
