import 'package:flutter/material.dart';
import 'package:second_project/core/constant/app_colors.dart';
import 'package:second_project/widgets/flutter_widgets/custom_container.dart';
import 'package:second_project/widgets/flutter_widgets/custom_text.dart';

class ExpenseInformation extends StatelessWidget {
  final double expenseMoney;
  final double incomeMoney;
  final String code;

  const ExpenseInformation(
      {required this.expenseMoney,
      required this.incomeMoney,
      required this.code,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: AppColors.bgColor,
      child: CustomContainer(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: '${expenseMoney.toStringAsFixed(2)} $code',
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            const CustomContainer(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: VerticalDivider(
                thickness: 1.3,
              ),
            ),
            CustomText(
              text: '${incomeMoney.toStringAsFixed(2)} $code',
              fontWeight: FontWeight.w500,
              color: AppColors.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
