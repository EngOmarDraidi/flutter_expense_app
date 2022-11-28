import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/categories_controller.dart';
import '../controllers/transactions_controller.dart';
import '../core/constant/app_colors.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_text.dart';
import '../widgets/flutter_widgets/custom_tab_bar.dart';
import '../widgets/my_widgets/add_transaction/add_transaction_form.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    final TransactionsController provider =
        Provider.of<TransactionsController>(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'New Transaction'.tr(),
        leading: TextButton(
          onPressed: () {
            provider.changeTranType(0);
            Provider.of<CategoriesController>(context, listen: false).tranType =
                0;
            navigator.pop();
          },
          child: CustomText(
            text: 'Cancel'.tr(),
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              int rowId = await provider.insertData();
              if (rowId != 0) {
                navigator.pop();
              }
            },
            child: CustomText(
              text: 'Done'.tr(),
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTapBar(
                listOfTab: const ['Expense', 'Income'],
                onTap: (value) {
                  Provider.of<TransactionsController>(context, listen: false)
                      .changeTranType(value);
                  Provider.of<CategoriesController>(context, listen: false)
                      .filterCategories(value);
                }),
            const SizedBox(height: 20),
            const AddTransactionForm(),
          ],
        ),
      ),
    );
  }
}
