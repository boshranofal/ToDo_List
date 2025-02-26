import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';
import 'package:todo_list_app/data/tasks_model.dart';
import 'package:todo_list_app/presentation/widget/tasck_details_app_bar.dart';
import 'package:todo_list_app/presentation/widget/task_details_body.dart';


class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  List<TasksModel> allTasks = [];
  List<TasksModel> filteredTasks = [];

  String dayName =
      DateFormat('EEEE').format(DateTime.now()); 
  String formattedDate = DateFormat('d MMMM, yyyy')
      .format(DateTime.now()); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Details")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontFamily: 'islandMoments',
                      fontSize: 35,
                      color: AppColors.pink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formattedDate.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'AbhayaLibre',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TaskDetailsAppBar(),
                  const SizedBox(height: 20),
                  TaslDetailsBody(),
                  const SizedBox(height: 50),
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
