import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';
import 'package:todo_list_app/data/tasks_model.dart';
import 'package:todo_list_app/provider/task_provider.dart';

class TaslDetailsBody extends StatefulWidget {
  const TaslDetailsBody({super.key});

  @override
  State<TaslDetailsBody> createState() => _TaslDetailsBodyState();
}

class _TaslDetailsBodyState extends State<TaslDetailsBody> {
  List<TasksModel> filteredTasks = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<TaskProvider>(context, listen: false).getAllTasks();

      Provider.of<TaskProvider>(context, listen: false)
          .allTasks
          .forEach((task) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final tasks = taskProvider.allTasks;
         

        return tasks.isEmpty
            ? const Center(
                child: Text(
                  "No tasks yet!",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return Card(
                    color: AppColors.kreamy,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                task.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                 Provider.of<TaskProvider>(context, listen: false)
                                    .completeTask(task.id!);
                                },
                                child: SvgPicture.asset(
                                  task.isCompleted?
                                  "assets/images/Vectorgreen.svg"
                                  :"assets/images/Vector.svg",
                                  fit: BoxFit.contain,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Start date : ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                task.date,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .removeTask(task.id!);
                                },
                                child: SvgPicture.asset(
                                  "assets/images/Group 128.svg",
                                  fit: BoxFit.cover,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
