import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/currencies_controller.dart';
import '../../flutter_widgets/custom_text.dart';

class CurrencyItem extends StatelessWidget {
  final int index;
  final String code;
  final String country;
  final void Function()? onTap;

  const CurrencyItem(
      {required this.index,
      required this.code,
      required this.country,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: code,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                CustomText(
                  text: country,
                  fontSize: 15,
                ),
              ],
            ),
            const Spacer(),
            if (index == Provider.of<CurrenciesController>(context).index)
              const Icon(Icons.check),
          ],
        ),
      ),
    );
  }
}
