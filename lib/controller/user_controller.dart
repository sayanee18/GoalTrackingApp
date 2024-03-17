import 'package:get/get.dart';
import 'package:goal_tracking_app/models/task_model.dart';
import 'package:goal_tracking_app/models/user_model.dart';
import 'package:goal_tracking_app/service/user_service.dart';

class UserController extends GetxController {
  UserService userService = UserService();
  Rx<UserModel> userModel =
      UserModel(completed: [], email: "", name: "", pending: [], userID: "")
          .obs;

  void initUser() async {
    UserModel model = await userService.getUser();
    userModel.value.completed.addAll(model.completed);
    userModel.value.pending.addAll(model.pending);
    userModel.value.userID = model.userID;
    userModel.value.email = model.email;
  }

  void addPendingTask({required TaskModel taskModel}) {
    userModel.value.pending.add(taskModel);
  }

  void addCompletedTask({required TaskModel taskModel}) {
    userModel.value.pending.add(taskModel);
  }
}
