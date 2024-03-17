// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:goal_tracking_app/models/task_model.dart';

class UserModel {
  String userID = "";
  String name = "";
  String email = "";
  List<TaskModel> completed = [];
  List<TaskModel> pending = [];
  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.completed,
    required this.pending,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'name': name,
      'email': email,
      'completed': completed.map((x) => x.toMap()).toList(),
      'pending': pending.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      completed: List<TaskModel>.from(
        (map['completed'] as List<dynamic>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pending: List<TaskModel>.from(
        (map['pending'] as List<dynamic>).map<TaskModel>(
          (x) => TaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
