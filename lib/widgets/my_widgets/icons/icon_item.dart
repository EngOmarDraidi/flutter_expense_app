import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/icons_controller.dart';
import '../../flutter_widgets/custom_container.dart';

class IconItem extends StatelessWidget {
  final int index;
  final String icon;

  const IconItem({required this.index, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final IconsController provider = Provider.of<IconsController>(context);

    return CustomContainer(
      onTap: () {
        provider.changeIcon(index);
        Navigator.of(context).pop();
      },
      padding: const EdgeInsets.all(10),
      borderRadius: 10,
      color: Colors.white,
      child: SvgPicture.asset(icon),
    );
  }
}
