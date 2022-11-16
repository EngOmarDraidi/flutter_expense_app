import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';

class MainExpenseInformation extends StatelessWidget {
  final num expenseMoney;
  final num incomeMoney;
  final String currencyCode;

  const MainExpenseInformation(
      {required this.expenseMoney,
      required this.incomeMoney,
      required this.currencyCode,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.white,
      height: 140,
      borderRadius: 10,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2.9 / 1,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CustomContainer(
            border: Border(
              right: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomContainer(
                  child: CustomText(
                    text: 'Expense',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: '${expenseMoney.toStringAsFixed(2)} $currencyCode',
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ],
            ),
          ),
          CustomContainer(
            padding: const EdgeInsets.only(left: 15, top: 15),
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Income',
                  color: AppColors.accentColor,
                  fontSize: 13,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: '${incomeMoney.toStringAsFixed(2)} $currencyCode',
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ],
            ),
          ),
          CustomContainer(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Balance',
                  fontSize: 13,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  text:
                      '${(incomeMoney - expenseMoney).toStringAsFixed(2)} $currencyCode',
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
