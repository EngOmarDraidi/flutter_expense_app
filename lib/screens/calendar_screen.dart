import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/transactions_controller.dart';
import '../core/constant/app_colors.dart';
import '../widgets/flutter_widgets/custom_app_bar.dart';
import '../widgets/flutter_widgets/custom_text.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController provider =
        Provider.of<CalendarController>(context);
    final TransactionsController tranProvider =
        Provider.of<TransactionsController>(context);

    return Scaffold(
      appBar: CustomAppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomText(
            text: 'Cancel',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        title: 'Celender',
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(DateTime.now().year - 2),
            lastDay: DateTime.utc(DateTime.now().year + 2),
            focusedDay: DateTime.now(),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.red.shade700,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue.shade700,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: AppColors.primaryColor,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: AppColors.primaryColor,
              ),
              formatButtonTextStyle: TextStyle(
                color: AppColors.primaryColor,
              ),
              titleTextStyle: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 17,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: AppColors.primaryColor),
              weekendStyle: TextStyle(color: AppColors.primaryColor),
            ),
            selectedDayPredicate: (day) => isSameDay(provider.selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              provider.changeData(selectedDay);
              tranProvider.date = provider.selectedDay;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
