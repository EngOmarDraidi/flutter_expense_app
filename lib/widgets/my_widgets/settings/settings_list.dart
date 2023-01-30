import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:second_project/controllers/calendar_controller.dart';
import '../../../controllers/main_screen_controller.dart';
import '../../../controllers/currencies_controller.dart';
import '../../../widgets/flutter_widgets/custom_container.dart';
import 'settings_item.dart';

class SettingsList extends StatelessWidget {
  final PageController pageController;
  final VoidCallback? voidCallback;

  const SettingsList(
      {required this.pageController, this.voidCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsItem(
          onTap: () {
            pageController.animateToPage(4,
                duration: const Duration(milliseconds: 250),
                curve: Curves.linear);
          },
          title: 'Currency',
          choice: Provider.of<CurrenciesController>(context).code.toString(),
        ),
        const CustomContainer(
          color: Colors.white,
          child: Divider(thickness: 0.5),
        ),
        SettingsItem(
          onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    if (context.locale.languageCode != 'ar') {
                      context.setLocale(const Locale('ar'));
                      Provider.of<MainScreenController>(context, listen: false)
                          .update();
                      Provider.of<CalendarController>(context, listen: false)
                          .updateCalender();
                    }
                    voidCallback;
                    Navigator.of(context).pop();
                  },
                  child: const Text('العربية'),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    if (context.locale.languageCode != 'en') {
                      context.setLocale(const Locale('en'));
                      Provider.of<MainScreenController>(context, listen: false)
                          .update();
                      Provider.of<CalendarController>(context, listen: false)
                          .updateCalender();
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('English'),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('Cancel').tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          title: 'Language',
          choice: context.locale.languageCode == 'ar' ? 'العربية' : 'English',
        ),
      ],
    );
  }
}
