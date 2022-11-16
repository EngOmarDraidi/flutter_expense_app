import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';

class CustomTapBar extends StatefulWidget {
  final List<String> listOfTab;
  final void Function(int)? onTap;
  final int? tapValue;
  const CustomTapBar(
      {required this.listOfTab, this.onTap, this.tapValue, super.key});

  @override
  State<CustomTapBar> createState() => _CustomTapBarState();
}

class _CustomTapBarState extends State<CustomTapBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.listOfTab.length, vsync: this);
    _tabController.index = widget.tapValue ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(2),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primaryColor,
        onTap: widget.onTap,
        tabs: widget.listOfTab.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}
