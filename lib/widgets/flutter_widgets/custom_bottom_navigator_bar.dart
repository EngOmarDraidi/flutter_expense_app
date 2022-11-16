import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/categories_controller.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_icons.dart';
import '../flutter_widgets/custom_container.dart';

class CustomBottomNavigatorBar extends StatefulWidget {
  final PageController pageController;

  const CustomBottomNavigatorBar({required this.pageController, super.key});

  @override
  State<CustomBottomNavigatorBar> createState() =>
      _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      border: const Border(
        top: BorderSide(color: Colors.black12, width: 0.5),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xfffefefe),
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) async {
          currentIndex = value;
          if (value == 2) {
            await Provider.of<CategoriesController>(context, listen: false)
                .getData();
          }
          widget.pageController.jumpToPage(currentIndex);
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.dashboardIcon,
              width: 30,
              color:
                  currentIndex == 0 ? AppColors.primaryColor : Colors.black54,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.transactionsIcon,
              width: 30,
              color:
                  currentIndex == 1 ? AppColors.primaryColor : Colors.black54,
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.categoriesIcon,
              width: 30,
              color:
                  currentIndex == 2 ? AppColors.primaryColor : Colors.black54,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.settingsIcon,
              width: 30,
              color:
                  currentIndex == 3 ? AppColors.primaryColor : Colors.black54,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
