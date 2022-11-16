import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/controllers/categories_controller.dart';
import '../../flutter_widgets/custom_text_form_field.dart';
import 'select_icon.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoriesController provider =
        Provider.of<CategoriesController>(context);

    return Form(
      key: provider.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            title: 'name',
            textEditingController: provider.categoryName,
          ),
          const SizedBox(
            height: 10,
          ),
          const SelectIcon(),
        ],
      ),
    );
  }
}
