import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_list_app/data/tasks_model.dart';
import 'package:todo_list_app/helper/database_helper.dart';

class TaskProvider with ChangeNotifier {

  static Database? _database;
  List<TasksModel> allTasks = [];
  List<TasksModel> filteredTasks = [];

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT)',
      );
    }, version: 1);
  }

  Future<void> addTask(TasksModel task) async {
  final db = await database;

  await db.insert(
    'tasks',
    task.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await getAllTasks();
  
  notifyListeners();

  await _loadTaskStats();
}

  Future<void> loadTasks() async {
    await getAllTasks();
  }

  Future<void> updateTask(TasksModel task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    await getAllTasks(); // تأكد من جلب جميع المهام بعد التحديث
    notifyListeners();
  }

  Future<void> removeTask(int id) async {
    final db = await database;

    print("🔹 حذف المهمة ذات المعرف: $id");

    int result = await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result > 0) {
      print("✅ تم حذف المهمة ذات المعرف: $id بنجاح!");
      await getAllTasks(); 
      notifyListeners();
    } else {
      print("❌ فشل في حذف المهمة! ربما لا توجد في قاعدة البيانات.");
    }
  }

  Future<void> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    allTasks = List.generate(maps.length, (i) {
      return TasksModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        isCompleted: maps[i]['isCompleted'] == 1, // تحويل القيمة 1 إلى true
      );
    });
    notifyListeners();
  }

  void filterTasks(String query) {
    filteredTasks = allTasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

 List<TasksModel> get tasks => filteredTasks;  // هنا نعرض فقط المهام غير المكتملة
  List<TasksModel> get pendingTasks => allTasks.where((task) => !task.isCompleted).toList();
  List<TasksModel> get completedTasks => allTasks.where((task) => task.isCompleted).toList();

  Future<void> completeTask(int taskId) async {
  final taskIndex = allTasks.indexWhere((task) => task.id == taskId);
  if (taskIndex != -1) {
    // تحديث الحالة في الذاكرة
    allTasks[taskIndex].isCompleted = true;

    // تحديث قاعدة البيانات
    final db = await database;
    await db.update(
      'tasks',
      {'isCompleted': 1},  // 1 تعني مكتملة
      where: 'id = ?',
      whereArgs: [taskId],
    );

    // لا تقوم بتغيير filteredTasks هنا، بل استخدم allTasks مباشرة
    notifyListeners();
  }
  await _loadTaskStats();
}

  Future<void> _loadTaskStats() async {
  // تحديث الإحصائيات هنا (عدد المهام المنجزة والغير منجزة)
  int completed = await DatabaseHelper.instance.getCompletedTasksCount();
  int pending = await DatabaseHelper.instance.getPendingTasksCount();

    notifyListeners();
}

  
  
}
