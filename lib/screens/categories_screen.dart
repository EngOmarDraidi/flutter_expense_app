import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../controllers/categories_controller.dart';
import '../core/constant/app_icons.dart';
import '../core/constant/app_colors.dart';
import '../core/constant/app_routes.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_tab_bar.dart';
import '../widgets/flutter_widgets/custom_text.dart';
import '../widgets/my_widgets/categories/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    final status =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'Categories',
        leading: status != null
            ? TextButton(
                onPressed: () {
                  navigator.pop();
                },
                child: const CustomText(
                  text: 'Back',
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            : null,
        actions: status == null
            ? [
                IconButton(
                  onPressed: () {
                    navigator.pushNamed(AppRoutes.addCategory);
                  },
                  icon: SvgPicture.asset(
                    AppIcons.addIcon,
                    color: Colors.white,
                    width: 20,
                  ),
                ),
              ]
            : [],
      ),
      body: Column(
        children: [
          if (status == null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer<CategoriesController>(
                  builder: (context, provider, child) {
                return CustomTapBar(
                  listOfTab: const ['Expense', 'Income'],
                  tapValue: provider.tranType,
                  onTap: (value) {
                    provider.filterCategories(value);
                  },
                );
              }),
            ),
          CategoriesList(
            status: status,
          ),
        ],
      ),
    );
  }
}
