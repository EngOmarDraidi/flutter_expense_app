import 'package:shared_preferences/shared_preferences.dart';

SharedPreferencesApp sharedPreferencesApp = SharedPreferencesApp._();

class SharedPreferencesApp {
  SharedPreferencesApp._();

  SharedPreferences? _sharedPreferences;

  initSharedPred() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences!.setInt('currency_code', 149);
  }

  Object? getDate(String key) {
    return _sharedPreferences!.getInt(key);
  }

  Future<bool> setData(String key, int data) async {
    return await _sharedPreferences!.setInt(key, data);
  }

  Future<bool> deleteData(String key) async {
    return await _sharedPreferences!.remove(key);
  }

  Future<bool> clearSharedApp() async {
    return await _sharedPreferences!.clear();
  }
}
