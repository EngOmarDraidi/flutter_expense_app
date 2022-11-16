import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApp {
  SharedPreferencesApp._();
  static SharedPreferencesApp sharedPreferencesApp = SharedPreferencesApp._();

  SharedPreferences? _sharedPreferences;
  String? currencyCode;

  initSharedPred() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDate(String key) {
    currencyCode = _sharedPreferences!.getString(key);
    return currencyCode;
  }

  Future<bool> setData(String key, String data) async {
    return await _sharedPreferences!.setString(key, data);
  }

  Future<bool> deleteData(String key) async {
    return await _sharedPreferences!.remove(key);
  }

  Future<bool> clearSharedApp() async {
    return await _sharedPreferences!.clear();
  }
}
