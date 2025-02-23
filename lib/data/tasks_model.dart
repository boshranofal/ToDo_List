import 'package:intl/intl.dart';

class TasksModel {
  int? id;
  final String title;
  final String description;
  final String date;

  TasksModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });
Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'description': description,
    'date': DateFormat('yyyy-MM-dd').format(DateTime.parse(date)), 
  };
}

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
}
