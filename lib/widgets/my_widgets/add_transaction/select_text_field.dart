import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_icons.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';

class SelectTextField extends StatelessWidget {
  final String title;
  final String choice;
  final bool isSelected;
  final void Function()? onTap;

  const SelectTextField({
    required this.title,
    required this.choice,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      borderRadius: 10,
      color: Colors.white,
      child: Row(
        children: [
          CustomText(
            text: context.locale.countryCode == 'ar' ? title : title.tr(),
            color: AppColors.primaryColor,
            fontSize: 15,
          ),
          const Spacer(),
          CustomText(
            text: choice.tr(),
            color: !isSelected ? Colors.grey.withOpacity(0.6) : null,
            fontSize: 14,
          ),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            context.locale.languageCode == 'ar'
                ? AppIcons.backArrowIcon
                : AppIcons.forwardArrowIcon,
            width: 15,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
