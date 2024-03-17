import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:goal_tracking_app/models/task_model.dart';

class TaskService {
  void createTaskNotification(TaskModel model) async {
    await AwesomeNotifications()
        .requestPermissionToSendNotifications()
        .then((value) async {
      if (value) {
        final oneHourBefore = model.endDate.subtract(const Duration(hours: 1));
        await AwesomeNotifications().createNotification(
            schedule: NotificationCalendar.fromDate(date: oneHourBefore),
            content: NotificationContent(
              id: model.taskName.hashCode,
              channelKey: 'goal_tracker_channel',
              title: "Goal Reminder",
              body: 'Your task "${model.taskName}" is due in 1 hour!',
            ));
      } else {
        print("Notification permission denied");
      }
    });
  }
}
