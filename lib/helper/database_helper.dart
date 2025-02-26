
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list_app/data/tasks_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

 
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db'); 
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath(); 
    final path = join(dbPath, filePath); 
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);  
  }

 Future _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      date TEXT NOT NULL,
     isCompleted INTEGER NOT NULL DEFAULT 0
   
    )
  ''');
}

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('ALTER TABLE tasks ADD COLUMN isCompleted INTEGER DEFAULT 0');
  }
}
 

  Future<int> insertTask(TasksModel task) async {
    final db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<TasksModel>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    return result.map((json) => TasksModel.fromMap(json)).toList();
  }


  Future<int> updateTask(TasksModel task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
    Future<void> checkDatabaseSchema() async {
    final db = await instance.database; 
    final result = await db.rawQuery('PRAGMA table_info(tasks);');
    print(result); 
  }
  Future<int> getCompletedTasksCount() async {
  final db = await database;
  final result = await db.rawQuery('SELECT COUNT(*) AS count FROM tasks WHERE isCompleted = 1');
  return Sqflite.firstIntValue(result) ?? 0;
}

Future<int> getPendingTasksCount() async {
  final db = await database;
  final result = await db.rawQuery('SELECT COUNT(*) AS count FROM tasks WHERE isCompleted = 0');
  return Sqflite.firstIntValue(result) ?? 0;
}
}



