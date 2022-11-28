import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/currencies_controller.dart';
import '../../../models/model/currency.dart';
import 'currency_item.dart';

class CurrenciesList extends StatelessWidget {
  final List<Currency> copyList;
  const CurrenciesList({required this.copyList, super.key});

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
            code: copyList[index].code!,
            country: copyList[index].country!,
            onTap: () async {
              await provider.changeCurrencySelected(copyList[index].code!);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.5,
        ),
        itemCount: copyList.length,
      ),
    );
  }
}
