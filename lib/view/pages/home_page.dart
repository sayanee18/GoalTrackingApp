import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:goal_tracking_app/controller/user_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});
  final UserController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text(
            "Hi There!",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.14,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-0.98, -0.18),
                    end: Alignment(0.98, 0.18),
                    colors: [Color(0xFFFFF7AF), Color(0xFFFFE500)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'The difference between try and \ntriumph is just a little umph!',
                          style: TextStyle(
                            color: Color(0xFF444444),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Image.asset("assets/plant.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page',
    //     (route) =>
    //         (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}
