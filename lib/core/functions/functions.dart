import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/flutter_widgets/custom_text.dart';

Future<Widget?> myDialog(BuildContext context, dynamic message) async {
  if (message.runtimeType == List<String>) {
    message = message[0] + ' and ' + message[1];
  }

  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Error').tr(),
      content: Text('$message not be entered').tr(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: CustomText(
            text: context.locale.languageCode != 'ar' ? 'Ok' : 'حسنا',
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
