import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';
import 'package:todo_list_app/presentation/widget/tasck_details_body.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> allTasks = []; // القائمة تبدأ فارغة
  List<String> filteredTasks = [];

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
        allTasks.add(_searchController.text); // إضافة المهمة إلى القائمة
        filteredTasks = List.from(allTasks); // تحديث القائمة المعروضة
        _searchController.clear(); // مسح النص بعد الإضافة
        FocusScope.of(context).unfocus(); // إغلاق لوحة المفاتيح بعد الإضافة
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      allTasks.removeAt(index);
    });
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
                  Text(
                    "Sunday",
                    style: TextStyle(
                      fontFamily: 'islandMoments',
                      fontSize: 35,
                      color: AppColors.pink,
                    ),
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
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _filterTasks,
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
                          icon: Icon(Icons.add, color: Colors.white, size: 30),
                          onPressed: _addTask, 
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  filteredTasks.isEmpty
                      ? Center(
                          child: Text(
                            "No tasks yet!",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: AppColors.kreamy,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// **عنوان المهمة**
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          //allTasks[index]["title"]!,
                                          "llll",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/Vector.svg",
                                          fit: BoxFit.contain,
                                          width: 30,
                                          height: 30,
                                
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          //allTasks[index]["description"]!,
                                          "nnn",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/Vector (1).svg",
                                          fit: BoxFit.cover,
                                          width: 30,
                                          height: 30,
                                      
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Start date : ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          //allTasks[index]["date"]!,
                                          "pppp",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/Group 128.svg",
                                          fit: BoxFit.cover,
                                          width: 30,
                                          height: 30,
                                      
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
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
