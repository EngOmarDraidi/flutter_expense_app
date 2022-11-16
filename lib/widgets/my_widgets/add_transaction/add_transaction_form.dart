import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../controllers/transactions_controller.dart';
import '../../../controllers/calendar_controller.dart';
import '../../../core/constant/app_routes.dart';
import '../../flutter_widgets/custom_text_form_field.dart';
import '../../my_widgets/add_transaction/select_text_field.dart';
import 'custom_note_field.dart';

class AddTransactionForm extends StatelessWidget {
  const AddTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    final TransactionsController provider =
        Provider.of<TransactionsController>(context);

    return Form(
      key: provider.formKey,
      child: Column(
        children: [
          Consumer<CalendarController>(
            builder: (context, value, child) => SelectTextField(
              onTap: () => navigator.pushNamed(AppRoutes.calendar),
              title: 'Date',
              choice: DateFormat('d MMM yyyy').format(value.selectedDay),
              isSelected: true,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            title: 'Amount',
            textEditingController: provider.amount,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          Consumer<TransactionsController>(builder: (context, value, child) {
            bool isSelected = true;
            if (value.categoryTitle.contains('Not Selected')) {
              isSelected = false;
            }

            return SelectTextField(
              onTap: () {
                navigator.pushNamed(
                  AppRoutes.categories,
                  arguments: {'status': 'select'},
                );
              },
              title: 'Category',
              choice: value.categoryTitle,
              isSelected: isSelected,
            );
          }),
          const SizedBox(height: 10),
          CustomNoteField(
            controller: provider.note,
          ),
        ],
      ),
    );
  }
}

// Card(
//                   color: Colors.transparent,
//                   elevation: 0.0,
//                   child: TextField(
//                     decoration: InputDecoration(
//                         labelText: "Nama",
//                         filled: true,
//                         fillColor: Colors.grey.shade50),
//                   ),
//                 ),
//               )
