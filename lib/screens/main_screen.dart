import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/main_screen_controller.dart';
import 'package:second_project/controllers/transactions_controller.dart';
import '../widgets/flutter_widgets/custom_bottom_navigator_bar.dart';
import 'home_screen.dart';
import 'splash_screen.dart';
import 'transactions_screen.dart';
import 'categories_screen.dart';
import 'settings_screen.dart';
import 'currencies_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller =
        Provider.of<MainScreenController>(context);

    return Consumer<TransactionsController>(
        builder: (context, provider, child) {
      if (provider.isLoading) {
        provider.getData();
        return const SplashScreen();
      }

      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            const HomeScreen(),
            const TransactionsScreen(),
            const CategoriesScreen(),
            SettingsScreen(pageController: controller.pageController),
            CurrenciesScreen(pageController: controller.pageController),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigatorBar(
          pageController: controller.pageController,
        ),
      );
    });
  }
}
