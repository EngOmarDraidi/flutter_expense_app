import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/currencies_controller.dart';
import 'package:second_project/core/helper/shared_preferences_helper.dart';
import '../controllers/categories_controller.dart';
import '../controllers/transactions_controller.dart';
import '../core/constant/app_colors.dart';
import '../core/constant/app_icons.dart';
import '../core/constant/app_routes.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_tab_bar.dart';
import '../widgets/flutter_widgets/custom_container.dart';
import '../widgets/my_widgets/home/main_expense_information.dart';
import '../widgets/my_widgets/home/section_title.dart';
import '../widgets/my_widgets/home/section_expense.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    final CurrenciesController currencyProvider =
        Provider.of<CurrenciesController>(context);

    return Consumer<TransactionsController>(
        builder: (context, provider, child) {
      if (provider.isLoading) {
        currencyProvider.getCurrency();
        provider.getData();
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(
          title: 'Dashboard',
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: CustomTapBar(
                listOfTab: const ['Daily', 'Monthly', 'Yearly'],
                tapValue: provider.tranFilter,
                onTap: (value) => provider.changeTranFilter(value),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainExpenseInformation(
                expenseMoney: provider.moneyDetails['details']
                    [provider.tranFilter]['expense'] as double,
                incomeMoney: provider.moneyDetails['details']
                    [provider.tranFilter]['income'] as double,
                currencyCode: currencyProvider.code.toString(),
              ),
            ),
            if (provider.expenseTransactions.isNotEmpty)
              const SizedBox(height: 10),
            if (provider.expenseTransactions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(
                  title: 'Expense',
                  onPressed: () async {
                    await Provider.of<CategoriesController>(context,
                            listen: false)
                        .getData();
                    navigator.pushNamed(AppRoutes.addTransaction);
                  },
                ),
              ),
            if (provider.expenseTransactions.isNotEmpty)
              const SizedBox(height: 10),
            if (provider.expenseTransactions.isNotEmpty)
              CustomContainer(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.expenseTransactions.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          width: 20,
                        ),
                      SectionExpense(
                        categoryName:
                            provider.expenseTransactions[index].categoryName!,
                        icon: provider.expenseTransactions[index].categoryIcon!,
                        amount: provider.expenseTransactions[index].amount!,
                        mode: 0,
                      ),
                      if (index == provider.expenseTransactions.length - 1)
                        const SizedBox(
                          width: 20,
                        ),
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                ),
              ),
            if (provider.incomeTransactions.isNotEmpty)
              const SizedBox(height: 10),
            if (provider.incomeTransactions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(
                  title: 'Income',
                  onPressed: () async {
                    await Provider.of<CategoriesController>(context,
                            listen: false)
                        .getData();
                    navigator.pushNamed(AppRoutes.addTransaction);
                  },
                ),
              ),
            if (provider.incomeTransactions.isNotEmpty)
              const SizedBox(height: 10),
            if (provider.incomeTransactions.isNotEmpty)
              CustomContainer(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.incomeTransactions.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          width: 20,
                        ),
                      SectionExpense(
                        categoryName:
                            provider.incomeTransactions[index].categoryName!,
                        icon: provider.incomeTransactions[index].categoryIcon!,
                        amount: provider.incomeTransactions[index].amount!,
                        mode: 1,
                      ),
                      if (index == provider.incomeTransactions.length - 1)
                        const SizedBox(
                          width: 20,
                        ),
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                ),
              ),
          ],
        ),
      );
    });
  }
}
