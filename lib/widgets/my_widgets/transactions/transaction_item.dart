import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../core/constant/app_colors.dart';
import '../../flutter_widgets/custom_text.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String icon;
  final double amount;
  final int date;
  final String note;
  final int mode;
  final String code;

  const TransactionItem(
      {required this.title,
      required this.icon,
      required this.amount,
      required this.date,
      required this.mode,
      required this.note,
      required this.code,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 30,
      ),
      title: Row(
        children: [
          CustomText(
            text: title,
            fontWeight: FontWeight.w600,
          ),
          if (note.isNotEmpty)
            CustomText(
              text:
                  ' ( ${note[0].toUpperCase() + note.substring(1, note.length)} )',
              fontSize: 13,
              color: Colors.grey.shade400,
            )
        ],
      ),
      subtitle: CustomText(
        text: DateFormat.yMMMd(
                context.locale.languageCode != 'ar' ? 'en_USA' : 'ar_SA')
            .format(
          DateTime.fromMillisecondsSinceEpoch(date),
        ),
        fontSize: 13,
        color: Colors.grey.shade400,
      ),
      trailing: CustomText(
        text: '${amount.toStringAsFixed(2)} $code',
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: mode == 0 ? Colors.red : AppColors.accentColor,
      ),
    );
  }
}
