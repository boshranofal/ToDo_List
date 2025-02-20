// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';
import 'package:todo_list_app/core/theme/app_style.dart';

//import 'package:todo_list_app/core/utils/theme/app_style.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  final String title;
  final String count;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title,
          textAlign: TextAlign.center,
          style: AppStyle.blod.copyWith(color: AppColors.lightblack,)),
          Text(count,
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color:AppColors.lightblack))
        ],
      ),
    );
  }
}
