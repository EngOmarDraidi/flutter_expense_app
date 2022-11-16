import 'package:flutter/material.dart';
import '../../../core/constant/data.dart';
import 'icon_item.dart';

class IconsList extends StatelessWidget {
  const IconsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 7,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) =>
            IconItem(index: index, icon: icons[index]),
        itemCount: icons.length,
      ),
    );
  }
}
