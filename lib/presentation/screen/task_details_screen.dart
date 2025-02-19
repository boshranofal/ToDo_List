import 'package:flutter/material.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/widget/tasck_details_body.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  
  List<String> filteredTasks = [];
  List<String> allTasks = [];
  @override


  void _filterTasks(String query) {
    setState(() {
      filteredTasks = allTasks
          .where((task) => task.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addTask() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        allTasks
            .add(_searchController.text); // إضافة المهمة إلى القائمة الأصلية
        filteredTasks = List.from(allTasks); // تحديث القائمة المعروضة
        _searchController.clear(); // مسح النص بعد الإضافة
        FocusScope.of(context).unfocus(); // إغلاق لوحة المفاتيح بعد الإضافة
      });
    }
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sunday",
                        style: TextStyle(
                          fontFamily: 'islandMoments',
                          fontSize: 35,
                          color: AppColors.pink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "14, April, 2025",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'AbhayaLibre',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TasckDetailsBody(),
                  const SizedBox(height: 20),

                  
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(filteredTasks[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
