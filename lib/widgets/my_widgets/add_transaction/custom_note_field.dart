import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../core/constant/app_colors.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';
import '../../flutter_widgets/custom_button.dart';
import 'select_text_field.dart';

class CustomNoteField extends StatelessWidget {
  final TextEditingController? controller;

  const CustomNoteField({this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return Consumer<TransactionsController>(
        builder: (context, provider, child) {
      return SelectTextField(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();

          showCupertinoDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              content: CustomContainer(
                topLeft: 10,
                topRight: 10,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TextField(
                  maxLines: 7,
                  controller: provider.note,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Enter Note'.tr(),
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              contentPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              backgroundColor: AppColors.secondaryColor,
              actions: [
                CustomButton(
                  elevation: 0,
                  buttonColor: AppColors.secondaryColor,
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                  onPressed: () {
                    provider.note.clear();
                    navigator.pop();
                  },
                  child: CustomText(
                    text: 'Cancel'.tr(),
                    color: AppColors.primaryColor,
                  ),
                ),
                CustomButton(
                  elevation: 0,
                  buttonColor: AppColors.secondaryColor,
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                  onPressed: () {
                    provider.update();
                    navigator.pop();
                  },
                  child: CustomText(
                    text: 'Add'.tr(),
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          );
        },
        title: 'Note',
        choice: provider.note.text.trim() == ''
            ? 'Enter Note'
            : controller!.text.trim(),
        isSelected: provider.note.text.trim() == '' ? false : true,
      );
    });
  }
}
