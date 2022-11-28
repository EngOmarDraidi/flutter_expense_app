import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../controllers/currencies_controller.dart';
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
      if (provider.isFinishCauculate) {
        currencyProvider.getCurrency();
        provider.getAllTransactions();
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
            if (provider
                .filterTransactions[provider.tranFilter]['expense']!.isNotEmpty)
              const SizedBox(height: 10),
            if (provider
                .filterTransactions[provider.tranFilter]['expense']!.isNotEmpty)
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
            if (provider
                .filterTransactions[provider.tranFilter]['expense']!.isNotEmpty)
              const SizedBox(height: 10),
            if (provider
                .filterTransactions[provider.tranFilter]['expense']!.isNotEmpty)
              CustomContainer(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: (provider.filterTransactions[provider.tranFilter]
                          ['expense'] as List)
                      .length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          width: 20,
                        ),
                      SectionExpense(
                        categoryName:
                            (provider.filterTransactions[provider.tranFilter]
                                    ['expense'] as List)[index]
                                .categoryName!,
                        icon: (provider.filterTransactions[provider.tranFilter]
                                ['expense'] as List)[index]
                            .categoryIcon!,
                        amount:
                            (provider.filterTransactions[provider.tranFilter]
                                    ['expense'] as List)[index]
                                .amount!,
                        currencyCode: currencyProvider.code.toString(),
                        mode: 0,
                      ),
                      if (index ==
                          (provider.filterTransactions[provider.tranFilter]
                                      ['expense'] as List)
                                  .length -
                              1)
                        const SizedBox(
                          width: 20,
                        ),
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                ),
              ),
            if (provider
                .filterTransactions[provider.tranFilter]['income']!.isNotEmpty)
              const SizedBox(height: 10),
            if (provider
                .filterTransactions[provider.tranFilter]['income']!.isNotEmpty)
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
            if (provider
                .filterTransactions[provider.tranFilter]['income']!.isNotEmpty)
              const SizedBox(height: 10),
            if (provider
                .filterTransactions[provider.tranFilter]['income']!.isNotEmpty)
              CustomContainer(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: (provider.filterTransactions[provider.tranFilter]
                          ['income'] as List)
                      .length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          width: 20,
                        ),
                      SectionExpense(
                        categoryName:
                            (provider.filterTransactions[provider.tranFilter]
                                    ['income'] as List)[index]
                                .categoryName!,
                        icon: (provider.filterTransactions[provider.tranFilter]
                                ['income'] as List)[index]
                            .categoryIcon!,
                        amount:
                            (provider.filterTransactions[provider.tranFilter]
                                    ['income'] as List)[index]
                                .amount!,
                        currencyCode: currencyProvider.code.toString(),
                        mode: 1,
                      ),
                      if (index ==
                          (provider.filterTransactions[provider.tranFilter]
                                      ['income'] as List)
                                  .length -
                              1)
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
