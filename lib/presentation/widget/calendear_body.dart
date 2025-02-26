import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';
import 'package:todo_list_app/core/theme/app_style.dart';

import 'package:todo_list_app/presentation/widget/table_calendear.dart';

class CalendearBody extends StatefulWidget {
  const CalendearBody({super.key});

  @override
  State<CalendearBody> createState() => _CalendearBodyState();
}

class _CalendearBodyState extends State<CalendearBody> {
   String dayName = DateFormat('EEEE').format(DateTime.now()); // استخراج اسم اليوم
  String formattedDate = DateFormat('d MMMM, yyyy').format(DateTime.now()); 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Hello,Boshra,",
                        style: AppStyle.semibold
                            .copyWith(color: AppColors.black, fontSize: 20)),
                    Text("Start Planning Today",
                        style: AppStyle.semibold
                            .copyWith(color: AppColors.grey, fontSize: 20)),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  dayName,
                  style: TextStyle(
                      fontFamily: 'islandMoments',
                      fontSize: 35,
                      color: AppColors.pink),
                ),
                const SizedBox(height: 8),
                Text(
                  formattedDate.toString(),
                  style: AppStyle.semibold.copyWith(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 25,
                      color: AppColors.black),
                ),
                const SizedBox(height: 20),
                TableCalendear(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
