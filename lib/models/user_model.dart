// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
