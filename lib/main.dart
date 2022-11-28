import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'controllers/main_screen_controller.dart';
import 'controllers/currencies_controller.dart';
import 'controllers/categories_controller.dart';
import 'controllers/calendar_controller.dart';
import 'controllers/icons_controller.dart';
import 'controllers/transactions_controller.dart';
import 'core/constant/data.dart';
import 'core/constant/app_routes.dart';
import 'core/helper/shared_preferences_helper.dart';
import 'core/helper/sqflite_helper.dart';
import 'core/services/app_states.dart';
import 'screens/main_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/add_category_screen.dart';
import 'screens/icons_screen.dart';
import 'screens/calendar_screen.dart';

int? currencyCode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesApp.sharedPreferencesApp.initSharedPred();
  await SqliteHelper.sqliteHelper.connectToDatabase();
  if (SharedPreferencesApp.sharedPreferencesApp.getDate('currency_code') ==
      null) {
    await SharedPreferencesApp.sharedPreferencesApp
        .setData('currency_code', 'USD');
    await SqliteHelper.sqliteHelper.insertInitialCategpry(categories);
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ExpenseApp(),
    ),
  );
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => IconsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalendarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrenciesController(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (context, child) => const MaterialWidget(),
      ),
    );
  }
}

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppState.navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/',
      routes: {
        AppRoutes.mainScreen: (context) => const MainScreen(),
        AppRoutes.categories: (context) => const CategoriesScreen(),
        AppRoutes.addTransaction: (context) => const AddTransactionScreen(),
        AppRoutes.addCategory: (context) => const AddCategoryScreen(),
        AppRoutes.icons: (context) => const IconsScreen(),
        AppRoutes.calendar: (context) => const CalendarScreen(),
      },
    );
  }
}
