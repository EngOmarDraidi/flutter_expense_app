import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_icons.dart';
import '../../flutter_widgets/custom_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SectionTitle({required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: title.tr(),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            AppIcons.circleAddIcon,
            width: 30,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
