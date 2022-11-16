import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/currencies_controller.dart';
import 'package:second_project/widgets/flutter_widgets/custom_container.dart';
import 'settings_item.dart';

class SettingsList extends StatelessWidget {
  final PageController pageController;

  const SettingsList({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsItem(
          onTap: () {
            pageController.animateToPage(4,
                duration: const Duration(milliseconds: 250),
                curve: Curves.linear);
          },
          title: 'Currency',
          choice: Provider.of<CurrenciesController>(context).code.toString(),
        ),
        const CustomContainer(
          color: Colors.white,
          child: Divider(thickness: 0.5),
        ),
        const SettingsItem(
          onTap: null,
          title: 'Language',
          choice: 'English',
        ),
      ],
    );
  }
}
