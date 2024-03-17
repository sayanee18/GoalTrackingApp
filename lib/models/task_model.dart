// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  String taskName = "";
  String description = "";
  DateTime startDate;
  DateTime endDate;
  String priority = "Normal";
  TaskModel({
    required this.taskName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
  });
}
