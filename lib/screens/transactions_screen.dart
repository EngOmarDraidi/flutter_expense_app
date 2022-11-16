import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../controllers/transactions_controller.dart';
import '../core/constant/app_colors.dart';
import '../core/constant/app_icons.dart';
import '../core/constant/app_routes.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_text.dart';
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
        leading: TextButton(
          onPressed: () {},
          child: const CustomText(
            text: 'Filter',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
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
      body:
          Consumer<TransactionsController>(builder: (context, provider, child) {
        if (provider.isLoading) {
          provider.getData();
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        return Column(
          children: [
            const Header(),
            ExpenseInformation(
              expenseMoney: provider.moneyDetails['total']['expense'] as double,
              incomeMoney: provider.moneyDetails['total']['income'] as double,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.allTransactions.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    TransactionItem(
                      title: provider.allTransactions[index].categoryName!,
                      icon: provider.allTransactions[index].categoryIcon!,
                      amount: provider.allTransactions[index].amount! as double,
                      date: provider.allTransactions[index].date! as int,
                      mode: provider.allTransactions[index].tranType! as int,
                    ),
                    const Divider(thickness: 0.5),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
