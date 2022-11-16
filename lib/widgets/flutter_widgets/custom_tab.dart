import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../flutter_widgets/custom_container.dart';
import '../flutter_widgets/custom_text.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final int index;
  final bool isSelected;
  final double? precSize;
  final void Function(int)? fun;

  const CustomTab({
    required this.title,
    required this.isSelected,
    required this.index,
    this.precSize,
    this.fun,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        fun!(index);
      },
      color: isSelected ? AppColors.primaryColor : null,
      margin: EdgeInsets.all(isSelected ? 2 : 0),
      padding: const EdgeInsets.symmetric(vertical: 10),
      borderRadius: 8,
      alignment: Alignment.center,
      width: precSize == null
          ? null
          : MediaQuery.of(context).size.width * precSize!,
      child: CustomText(
        text: title,
        color: isSelected ? Colors.white : AppColors.primaryColor,
      ),
    );
  }
}
