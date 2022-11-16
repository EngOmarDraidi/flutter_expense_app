import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/categories_controller.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  final Map<String, String>? status;

  const CategoriesList({this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Colors.white,
        child: Consumer<CategoriesController>(
          builder: (context, provider, child) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CategoryItem(
                  index: index,
                  status: status,
                  id: provider.categories[index].id as int,
                  title: provider.categories[index].name.toString(),
                  icon: provider.categories[index].icon.toString(),
                  isLast: index == provider.categories.length - 1,
                );
              },
              itemCount: provider.categories.length,
            );
          },
        ),
      ),
    );
  }
}
