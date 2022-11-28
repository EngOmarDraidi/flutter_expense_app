import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_project/core/constant/app_colors.dart';
import 'package:second_project/widgets/flutter_widgets/custom_text.dart';
import '../core/constant/app_icons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor,
                  Color.fromARGB(255, 178, 174, 226),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppIcons.logo,
                    color: Colors.white,
                    width: 120,
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: 'Expense App',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
