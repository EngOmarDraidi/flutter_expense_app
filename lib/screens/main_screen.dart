import 'package:flutter/material.dart';
import '../widgets/flutter_widgets/custom_bottom_navigator_bar.dart';
import 'home_screen.dart';
import 'transactions_screen.dart';
import 'categories_screen.dart';
import 'settings_screen.dart';
import 'currencies_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          const HomeScreen(),
          const TransactionsScreen(),
          const CategoriesScreen(),
          SettingsScreen(pageController: _pageController!),
          CurrenciesScreen(pageController: _pageController!),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigatorBar(
        pageController: _pageController!,
      ),
    );
  }
}
