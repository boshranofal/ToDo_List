class TasksModel {
  final String title;
  final String description;
  final String date;
  final String time;
  final String status;

  TasksModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
  });
}

List<TasksModel> tasks = [];
