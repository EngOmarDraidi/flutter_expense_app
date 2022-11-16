import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../flutter_widgets/custom_container.dart';
import '../../flutter_widgets/custom_text.dart';
import '../../../controllers/transactions_controller.dart';

class CategoryItem extends StatelessWidget {
  final Map<String, String>? status;
  final int index;
  final int? id;
  final String title;
  final String icon;
  final bool isLast;

  const CategoryItem(
      {this.status,
      required this.index,
      required this.id,
      required this.title,
      required this.icon,
      required this.isLast,
      super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionsController provider =
        Provider.of<TransactionsController>(context, listen: false);

    return Column(
      children: [
        CustomContainer(
          onTap: () {
            if (status != null) {
              provider.changeCategorySelected(index, id!, title, icon);
              Navigator.of(context).pop();
            }
          },
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 25,
              ),
              const SizedBox(width: 15),
              CustomText(
                text: title,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            thickness: 1,
            color: Colors.grey.shade200,
          ),
      ],
    );
  }
}
