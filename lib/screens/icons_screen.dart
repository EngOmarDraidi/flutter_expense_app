import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/constant/app_colors.dart';
import '../core/constant/app_icons.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/my_widgets/icons/icons_list.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'Icons'.tr(),
        leading: IconButton(
          onPressed: () {
            navigator.pop();
          },
          icon: SvgPicture.asset(
            context.locale.languageCode == 'ar'
                ? AppIcons.forwardArrowIcon
                : AppIcons.backArrowIcon,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            IconsList(),
          ],
        ),
      ),
    );
  }
}
