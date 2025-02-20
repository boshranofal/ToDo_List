import 'package:flutter/material.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';

import 'package:todo_list_app/presentation/widget/stats_card.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatsCard(title: "Completed Task", count: "04", color: AppColors.kreamy),
        StatsCard(title: "Pending Task", count: "02", color: AppColors.rose),
      ],
    );
  }
}