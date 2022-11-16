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
      title: const Text('Error'),
      content: Text('$message not be entered'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomText(
            text: 'Ok',
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
