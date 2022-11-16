import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/icons_controller.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_icons.dart';
import '../../../core/constant/app_routes.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';

class SelectIcon extends StatelessWidget {
  const SelectIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return CustomContainer(
      onTap: () => navigator.pushNamed(AppRoutes.icons),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 22,
      ),
      borderRadius: 10,
      color: Colors.white,
      child: Row(
        children: [
          const CustomText(
            text: 'Icon',
            color: AppColors.primaryColor,
            fontSize: 15,
          ),
          const Spacer(),
          Consumer<IconsController>(
            builder: (context, value, child) => CustomContainer(
              child: SvgPicture.asset(
                value.iconName,
                width: 30,
              ),
            ),
          ),
          const SizedBox(width: 15),
          CustomContainer(
            child: SvgPicture.asset(
              AppIcons.forwardArrowIcon,
              width: 15,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
