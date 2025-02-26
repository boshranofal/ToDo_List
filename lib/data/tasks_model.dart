import 'package:intl/intl.dart';

class TasksModel {
  int? id;
  final String title;
  final String description;
  final String date;
 bool isCompleted;

  TasksModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'description': description,
    'date': DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
        'isCompleted': isCompleted ? 1 : 0,
  };
}

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      isCompleted:map['isCompleted'] == 1
    );
  }
}
