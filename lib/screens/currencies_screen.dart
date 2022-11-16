import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_container.dart';
import '../widgets/flutter_widgets/custom_text.dart';
import '../widgets/my_widgets/currenies/currencies_list.dart';

class CurrenciesScreen extends StatelessWidget {
  final PageController? pageController;

  const CurrenciesScreen({this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Currency',
        leading: TextButton(
          onPressed: () {
            pageController!.animateToPage(3,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          },
          child: const CustomText(
            text: 'Back',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const CustomText(
              text: 'Save',
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
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.only(bottom: 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const CurrenciesList(),
        ],
      ),
    );
  }
}
