import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_list_app/data/tasks_model.dart';

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

    // إدراج المهمة في قاعدة البيانات
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await getAllTasks(); // جلب كل المهام المحدثة من قاعدة البيانات
    notifyListeners(); // إشعار الواجهة بالتحديث
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
    getAllTasks();
    notifyListeners();
  }
Future<void> removeTask(int id) async {
  final db = await database;
  await db.delete(
    'tasks',
    where: 'id = ?',
    whereArgs: [id],
  );

  await getAllTasks(); // تحديث القائمة بعد الحذف
  notifyListeners(); // تحديث الواجهة
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
      );
    });
  }

    void filterTasks(String query) {
      filteredTasks = allTasks
          .where(
              (task) => task.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

