import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/calendar_controller.dart';
import 'package:second_project/models/model/transaction.dart';
import '../controllers/categories_controller.dart';
import '../controllers/currencies_controller.dart';
import '../controllers/transactions_controller.dart';
import '../core/constant/app_colors.dart';
import '../core/constant/app_icons.dart';
import '../core/constant/app_routes.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_container.dart';
import '../widgets/my_widgets/transactions/expense_information.dart';
import '../widgets/my_widgets/transactions/header.dart';
import '../widgets/my_widgets/transactions/transaction_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Transactions',
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<CategoriesController>(context, listen: false)
                  .getData();
              navigator.pushNamed(AppRoutes.addTransaction);
            },
            icon: SvgPicture.asset(
              AppIcons.addIcon,
              color: Colors.white,
              width: 20,
            ),
          ),
        ],
      ),
      body: Consumer2<TransactionsController, CalendarController>(
          builder: (context, provider, calendarProvider, child) {
        if (provider.isLoading) {
          provider.getData();
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        final Map<String, double> moneyDetails = {
          'expense': 0.0,
          'income': 0.0
        };

        final List<Transaction> listOfTransactions =
            provider.allTransactions.where((element) {
          DateTime date =
              DateTime.fromMillisecondsSinceEpoch(int.tryParse(element.date!)!);

          if (calendarProvider.transactionFilterDate.month == date.month &&
              calendarProvider.transactionFilterDate.year == date.year) {
            if (element.tranType == 0) {
              moneyDetails['expense'] =
                  moneyDetails['expense']! + element.amount!;
            } else {
              moneyDetails['income'] =
                  moneyDetails['income']! + element.amount!;
            }
            return true;
          }
          return false;
        }).toList();

        return Column(
          children: [
            const Header(),
            ExpenseInformation(
              expenseMoney: moneyDetails['expense'] as double,
              incomeMoney: moneyDetails['income'] as double,
              code: Provider.of<CurrenciesController>(context).code.toString(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listOfTransactions.length,
                itemBuilder: (context, index) => Dismissible(
                  key: UniqueKey(),
                  background: CustomContainer(
                    onTap: () => navigator.pushNamed(
                      AppRoutes.addTransaction,
                      arguments: {
                        'mode': 'update',
                        'data': listOfTransactions[index]
                      },
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red.shade100,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return true;
                    }
                    return false;
                  },
                  child: Column(
                    children: [
                      TransactionItem(
                        title: listOfTransactions[index].categoryName!,
                        icon: listOfTransactions[index].categoryIcon!,
                        amount: listOfTransactions[index].amount! as double,
                        date: int.tryParse(listOfTransactions[index].date!)!,
                        mode: listOfTransactions[index].tranType! as int,
                        note: listOfTransactions[index].note!,
                        code: Provider.of<CurrenciesController>(context)
                            .code
                            .toString(),
                      ),
                      const Divider(thickness: 0.5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
