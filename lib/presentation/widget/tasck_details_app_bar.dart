import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';
import 'package:todo_list_app/data/tasks_model.dart';
import 'package:todo_list_app/provider/task_provider.dart';

class TaskDetailsAppBar extends StatefulWidget {
  const TaskDetailsAppBar({super.key});

  @override
  State<TaskDetailsAppBar> createState() => _TaskDetailsAppBarState();
}

class _TaskDetailsAppBarState extends State<TaskDetailsAppBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<TasksModel> filteredTasks = [];
  List<TasksModel> allTasks = [];

  void _addTask() {
    if (_searchController.text.isNotEmpty) {
      final newTask = TasksModel(
        id: null,
        title: _searchController.text,
        description: "وصف افتراضي",
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );

      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

      _searchController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return TextField(
                controller: _searchController,
                onChanged: (query) => taskProvider.filterTasks(query),
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: "Task...",
                  filled: true,
                  fillColor: AppColors.lightgrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 30),
            onPressed: _addTask,
          ),
        ),
      ],
    );
  }
}
