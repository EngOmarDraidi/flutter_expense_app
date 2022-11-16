import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/calendar_controller.dart';
import '../../../widgets/flutter_widgets/custom_container.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_icons.dart';
import '../../flutter_widgets/custom_text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarController>(builder: (context, provider, child) {
      return CustomContainer(
        color: const Color(0xffe1e0f2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                provider.changeTransactionFilterDate(-1);
              },
              icon: SvgPicture.asset(
                AppIcons.backArrowIcon,
                width: 17,
                color: AppColors.primaryColor,
              ),
            ),
            CustomText(
              text: DateFormat('MMM. yyyy')
                  .format(provider.transactionFilterDate),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
            IconButton(
              onPressed: () {
                provider.changeTransactionFilterDate(1);
              },
              icon: SvgPicture.asset(
                AppIcons.forwardArrowIcon,
                width: 17,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
