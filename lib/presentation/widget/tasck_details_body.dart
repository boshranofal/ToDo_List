import 'package:flutter/material.dart';
import 'package:todo_list_app/core/theme/app_colors.dart';

class TasckDetailsBody extends StatefulWidget {
  const TasckDetailsBody({super.key});

  @override
  State<TasckDetailsBody> createState() => _TasckDetailsBodyState();
}

class _TasckDetailsBodyState extends State<TasckDetailsBody> {
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
            .add(_searchController.text);
        filteredTasks = List.from(allTasks);
        _searchController.clear(); 
        FocusScope.of(context).unfocus();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
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
            onPressed: _addTask, // عند الضغط، يتم إضافة المهمة
          ),
        ),
      ],
    );
  }
}
