import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import 'custom_container.dart';
import 'custom_tab.dart';

class MyTabBar extends StatefulWidget {
  final List<Map<String, dynamic>> listOfTab;
  const MyTabBar({required this.listOfTab, super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int tabSelected = 0;

  void selectTap(int index) {
    tabSelected = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: AppColors.secondaryColor,
      borderRadius: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.listOfTab
            .map(
              (tab) => CustomTab(
                title: tab['title'],
                index: tab['id'],
                isSelected: tabSelected == tab['id'],
                precSize: widget.listOfTab.length == 3 ? 0.29 : 0.44,
                fun: selectTap,
              ),
            )
            .toList(),
      ),
    );
  }
}
