import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/my_widgets/settings/settings_list.dart';

class SettingsScreen extends StatefulWidget {
  final PageController pageController;

  const SettingsScreen({required this.pageController, super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'Settings',
        voidCallback: rebuild,
      ),
      body: SettingsList(pageController: widget.pageController),
    );
  }
}
