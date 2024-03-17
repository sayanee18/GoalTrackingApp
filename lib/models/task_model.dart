import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  String taskName = "";
  String description = "";
  DateTime startDate;
  DateTime? endDate;
  bool isCompleted = false;
  String priority = "Normal";
  List<dynamic> subTask = [];
  TaskModel({
    required this.taskName,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.isCompleted,
    required this.priority,
    required this.subTask,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate != null ? endDate!.millisecondsSinceEpoch : 0,
      'isCompleted': isCompleted,
      'priority': priority,
      'subTask': subTask.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName: map['taskName'] as String,
      description: map['description'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
      isCompleted: map['isCompleted'] as bool,
      priority: map['priority'] as String,
      subTask: List<TaskModel>.from(
        (map['subTask'] as List<dynamic>).map<dynamic>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
