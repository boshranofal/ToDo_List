import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';

import 'package:todo_list_app/presentation/screen/task_details_screen.dart';
import 'package:todo_list_app/presentation/widget/tasks.dart';

class TableCalendear extends StatefulWidget {
  const TableCalendear({super.key});

  @override
  State<TableCalendear> createState() => _TableCalendearState();
}

class _TableCalendearState extends State<TableCalendear> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (day.weekday == DateTime.saturday ||
                    day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  );
                }
                return null;
              },
            ),
            selectedDayPredicate: (day) {
              return isSameDay(day, DateTime.now());
            },
            onDaySelected: (selectedDay, focusedDay) {
    if (isSameDay(selectedDay, DateTime.now())) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailsScreen(),
        ),
      );
    }
  },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.pink,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.pink,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: AppColors.white),
              todayTextStyle: TextStyle(color: AppColors.black),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          
          ),
        
        ),
        SizedBox(height: 20),
        Tasks(),
      ],
    );
    
  }
}
