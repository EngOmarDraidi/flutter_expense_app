import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/currencies_controller.dart';
import '../../../models/model/currency.dart';
import '../../../core/constant/data.dart';
import 'currency_item.dart';

List<Currency> listOfCurrencies = [];

getCurrencies() async {
  currencies.forEach((key, value) {
    listOfCurrencies.add(Currency.fromJSON({'code': key, 'country': value}));
  });
}

class CurrenciesList extends StatefulWidget {
  const CurrenciesList({super.key});

  @override
  State<CurrenciesList> createState() => _CurrenciesListState();
}

class _CurrenciesListState extends State<CurrenciesList> {
  int? indexCode;

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    final CurrenciesController provider =
        Provider.of<CurrenciesController>(context);

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          return CurrencyItem(
            index: index,
            code: listOfCurrencies[index].code!,
            country: listOfCurrencies[index].country!,
            onTap: () async {
              await provider
                  .changeCurrencySelected(listOfCurrencies[index].code!);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.5,
        ),
        itemCount: listOfCurrencies.length,
      ),
    );
  }
}
