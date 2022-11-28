import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import '../../core/constant/app_colors.dart';
import 'custom_container.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;

  const CustomTextFormField(
      {required this.title,
      this.keyboardType,
      this.textEditingController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      borderRadius: 10,
      color: Colors.white,
      child: Row(
        children: [
          CustomText(
            text: title.tr(),
            color: AppColors.primaryColor,
            fontSize: 15,
          ),
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              textDirection: context.locale.languageCode == 'ar'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: title.tr(),
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  fontSize: 14,
                ),
                hintTextDirection: context.locale.languageCode == 'ar'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
