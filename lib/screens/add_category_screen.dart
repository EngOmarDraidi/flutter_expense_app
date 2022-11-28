import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controllers/categories_controller.dart';
import '../core/constant/app_colors.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_text.dart';
import '../widgets/flutter_widgets/custom_tab_bar.dart';
import '../widgets/my_widgets/add_category/add_category_form.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'New Category'.tr(),
        leading: TextButton(
          onPressed: () async {
            navigator.pop();
          },
          child: CustomText(
            text: 'Cancel'.tr(),
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Provider.of<CategoriesController>(context, listen: false)
                  .insertData();
            },
            child: CustomText(
              text: 'Done'.tr(),
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTapBar(
              listOfTab: const ['Expense', 'Income'],
              onTap: (value) =>
                  Provider.of<CategoriesController>(context, listen: false)
                      .tranType = value,
            ),
            const SizedBox(
              height: 20,
            ),
            const AddCategoryForm(),
          ],
        ),
      ),
    );
  }
}
