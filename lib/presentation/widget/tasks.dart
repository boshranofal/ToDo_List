import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';

import 'package:todo_list_app/presentation/widget/stats_card.dart';
import 'package:todo_list_app/provider/task_provider.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int completedTasks = 0;
  int pendingTasks = 0;

  @override
  void initState() {
    super.initState();
    _loadTaskStats();
  }

  // عندما يتم تحديث أي مهمة (إتمام أو حذف)
  // void _onTaskUpdated() {
  //   _loadTaskStats(); // تحديث الإحصائيات بعد أي تغيير
  // }

  // تحميل الإحصائيات من قاعدة البيانات
  Future<void> _loadTaskStats() async {
    // باستخدام `TaskProvider` للحصول على الإحصائيات
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    setState(() {
      completedTasks = taskProvider.completedTasks.length;
      pendingTasks = taskProvider.pendingTasks.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        // تحديث الإحصائيات بشكل دوري
        _loadTaskStats();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatsCard(
              title: "Completed Task",
              count: completedTasks.toString(),
              color: AppColors.kreamy,
            ),
            StatsCard(
              title: "Pending Task",
              count: pendingTasks.toString(),
              color: AppColors.rose,
            ),
          ],
        );
      },
    );
  }
}