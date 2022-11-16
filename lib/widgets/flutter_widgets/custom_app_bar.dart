import 'package:flutter/material.dart';
import 'package:second_project/core/constant/app_colors.dart';
import 'package:second_project/widgets/flutter_widgets/custom_container.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final double? elevation;
  final bool? centerTitle;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CustomAppBar({
    required this.title,
    this.backgroundColor,
    this.elevation,
    this.centerTitle,
    this.leading,
    this.actions,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: AppBar(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        elevation: elevation ?? 0,
        centerTitle: centerTitle ?? true,
        actions: actions,
        leading: leading,
        leadingWidth: 80,
        bottom: bottom,
        title: Text(title),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
