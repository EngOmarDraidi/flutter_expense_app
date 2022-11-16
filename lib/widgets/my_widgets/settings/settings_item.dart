import 'package:flutter/material.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String choice;
  final void Function()? onTap;

  const SettingsItem(
      {required this.title,
      required this.choice,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            CustomText(
              text: choice,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
