import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:second_project/controllers/transactions_controller.dart';
import '../../../controllers/calendar_controller.dart';
import '../../../widgets/flutter_widgets/custom_container.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_icons.dart';
import '../../flutter_widgets/custom_text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CalendarController, TransactionsController>(
        builder: (context, calendarProvider, transProvider, child) {
      return CustomContainer(
        color: const Color(0xffe1e0f2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                calendarProvider.changeTransactionFilterDate(-1);
                // transProvider.filterTransactionScreen(
                //     calendarProvider.transactionFilterDate);
              },
              icon: SvgPicture.asset(
                context.locale.languageCode == 'ar'
                    ? AppIcons.forwardArrowIcon
                    : AppIcons.backArrowIcon,
                width: 17,
                color: AppColors.primaryColor,
              ),
            ),
            CustomText(
              text: DateFormat.yMMM(
                      context.locale.languageCode != 'ar' ? 'en_USA' : 'ar_SA')
                  .format(calendarProvider.transactionFilterDate),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
            IconButton(
              onPressed: () {
                calendarProvider.changeTransactionFilterDate(1);
              },
              icon: SvgPicture.asset(
                context.locale.languageCode == 'ar'
                    ? AppIcons.backArrowIcon
                    : AppIcons.forwardArrowIcon,
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
