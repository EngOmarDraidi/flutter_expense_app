import 'package:flutter/material.dart';
import '../core/helper/shared_preferences_helper.dart';

class CurrenciesController extends ChangeNotifier {
  String? code;
  String? currencySelected;
  bool isLoading = true;

  changeCurrencySelected(String codeSelected) {
    currencySelected = codeSelected;
    notifyListeners();
  }

  Future<void> changeCurrency() async {
    code = currencySelected;
    await SharedPreferencesApp.sharedPreferencesApp
        .setData('currency_code', currencySelected!);
    notifyListeners();
  }

  void getCurrency() {
    currencySelected = code =
        SharedPreferencesApp.sharedPreferencesApp.getDate('currency_code') ??
            'USD';
  }
}
