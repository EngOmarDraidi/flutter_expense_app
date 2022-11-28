import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/currencies_controller.dart';
import '../core/constant/app_colors.dart';
import '../core/constant/data.dart';
import '../models/model/currency.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_container.dart';
import '../widgets/flutter_widgets/custom_text.dart';
import '../widgets/my_widgets/currenies/search_text_field.dart';
import '../widgets/my_widgets/currenies/currencies_list.dart';

final List<Currency> listOfCurrenciesObjects = [];

void getCurrencies() {
  for (var currency in listOfCurrencies) {
    listOfCurrenciesObjects.add(
      Currency.fromJSON(
        {
          'code': currency.keys.first,
          'country': currency.values.first,
        },
      ),
    );
  }
}

class CurrenciesScreen extends StatefulWidget {
  final PageController? pageController;

  const CurrenciesScreen({this.pageController, super.key});

  @override
  State<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  List<Currency> copyList = [];

  @override
  initState() {
    super.initState();
    getCurrencies();
    copyList = listOfCurrenciesObjects;
  }

  search(String value) {
    copyList = listOfCurrenciesObjects
        .where(
          (element) =>
              element.code.toString().toLowerCase().contains(
                    value.toLowerCase(),
                  ) ||
              element.country.toString().toLowerCase().contains(
                    value.toLowerCase(),
                  ),
        )
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Currency'.tr(),
        leading: TextButton(
          onPressed: () {
            widget.pageController!.animateToPage(3,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          },
          child: CustomText(
            text: 'Back'.tr(),
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<CurrenciesController>(context, listen: false)
                  .changeCurrency();
              widget.pageController!.animateToPage(3,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            },
            child: CustomText(
              text: 'Save'.tr(),
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: AppColors.secondaryColor,
            child: SearchTextField(
              onChanged: search,
            ),
          ),
          CurrenciesList(copyList: copyList),
        ],
      ),
    );
  }
}
