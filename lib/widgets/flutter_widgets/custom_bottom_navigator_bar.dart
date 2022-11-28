import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../controllers/main_screen_controller.dart';
import '../../controllers/categories_controller.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_icons.dart';
import '../flutter_widgets/custom_container.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  final PageController pageController;

  const CustomBottomNavigatorBar({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenController>(builder: (context, provider, child) {
      return CustomContainer(
        border: const Border(
          top: BorderSide(color: Colors.black12, width: 0.5),
        ),
        child: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xfffefefe),
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (value) async {
            provider.changeCurrentIndex(value);
            if (value == 2) {
              await Provider.of<CategoriesController>(context, listen: false)
                  .getData();
            }
            pageController.jumpToPage(provider.currentIndex);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.dashboardIcon,
                width: 30,
                color: provider.currentIndex == 0
                    ? AppColors.primaryColor
                    : Colors.black54,
              ),
              label: 'Dashboard'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.transactionsIcon,
                width: 30,
                color: provider.currentIndex == 1
                    ? AppColors.primaryColor
                    : Colors.black54,
              ),
              label: 'Transactions'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.categoriesIcon,
                width: 30,
                color: provider.currentIndex == 2
                    ? AppColors.primaryColor
                    : Colors.black54,
              ),
              label: 'Categories'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.settingsIcon,
                width: 30,
                color: provider.currentIndex == 3
                    ? AppColors.primaryColor
                    : Colors.black54,
              ),
              label: 'Settings'.tr(),
            ),
          ],
        ),
      );
    });
  }
}
