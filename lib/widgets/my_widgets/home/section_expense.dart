import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constant/app_colors.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';

class SectionExpense extends StatelessWidget {
  final String categoryName;
  final String icon;
  final num amount;
  final int mode;

  const SectionExpense({
    required this.categoryName,
    required this.icon,
    required this.amount,
    required this.mode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      borderRadius: 10,
      child: Column(
        children: [
          CustomContainer(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(7),
            margin: const EdgeInsets.only(
              left: 45,
              right: 45,
              bottom: 10,
            ),
            borderRadius: 10,
            color: mode == 0 ? Colors.red : AppColors.accentColor,
            child: SvgPicture.asset(
              icon,
              color: Colors.white,
            ),
          ),
          CustomText(
            text: categoryName,
            color: mode == 0 ? Colors.red : AppColors.accentColor,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 5),
          CustomText(
            text: '$amount USD',
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
