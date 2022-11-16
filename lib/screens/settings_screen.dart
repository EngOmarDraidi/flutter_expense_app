import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/my_widgets/settings/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  final PageController pageController;

  const SettingsScreen({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: SettingsList(pageController: pageController),
    );
  }
}
