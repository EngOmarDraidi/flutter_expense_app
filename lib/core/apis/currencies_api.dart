import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> getListOfCurrencies() async {
  const String url = 'https://openexchangerates.org/api/currencies.json';

  final Uri uri = Uri.parse(url);
  final data = await http.get(uri);

  List<Map<String, dynamic>> mapData = [];

  jsonDecode(data.body).forEach((key, value) {
    mapData.add({'code': key, 'country': value});
  });

  return mapData;
}
