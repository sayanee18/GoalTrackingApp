import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goal_tracking_app/constant/constants.dart';
import 'package:goal_tracking_app/controller/user_controller.dart';
import 'package:goal_tracking_app/models/task_model.dart';
import 'package:goal_tracking_app/service/firebase_service.dart';
import 'package:goal_tracking_app/service/user_service.dart';
import 'package:goal_tracking_app/view/pages/login_page.dart';
import 'package:goal_tracking_app/view/pages/new_goal.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});
  final UserController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var setting;
  Future<void> setUser() async {
    UserService service = UserService();
    widget.controller.userModel.value = await service.getUser();
    print(widget.controller.userModel.value.pending);
    setState(() {});
  }

  int getCompleted(List<TaskModel> subgoal) {
    int count = 0;
    for (TaskModel task in subgoal) {
      if (task.isCompleted) {
        count++;
      }
    }
    return count;
  }

  @override
  void initState() {
    setting = setUser();
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
          toolbarHeight: 80,
          title: const Text(
            "Hi There!",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(LoginPage(controller: widget.controller));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text("Logout"),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: setUser(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 100,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                color: Color.fromARGB(122, 158, 158, 158),
                                offset: Offset(0, 0),
                                spreadRadius: 3,
                              ),
                            ]),
                        child: Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 5.0,
                                  percent: widget.controller.userModel.value
                                          .completed.isNotEmpty
                                      ? (widget.controller.userModel.value
                                              .completed.length) /
                                          (widget.controller.userModel.value
                                                      .completed.length +
                                                  widget.controller.userModel
                                                      .value.pending.length)
                                              .round()
                                      : 0,
                                  progressColor: Colors.green,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Keep it gowing",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "${widget.controller.userModel.value.completed.length} / ${(widget.controller.userModel.value.completed.length + widget.controller.userModel.value.pending.length)} tasks are completed",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Your Tasks",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(
                                AddNewGoal(controller: widget.controller),
                              );
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 5 / 5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 150,
                          ),
                          itemCount:
                              widget.controller.userModel.value.pending.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: colors[index % 4].withOpacity(0.3),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    widget.controller.userModel.value
                                        .pending[index].taskName,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      TaskModel model = widget.controller
                                          .userModel.value.pending[index];
                                      widget.controller.userModel.value.pending
                                          .removeAt(index);
                                      FirebaseService service =
                                          FirebaseService();

                                      widget
                                          .controller.userModel.value.completed
                                          .add(model);
                                      await service.setUserModel(
                                          widget.controller.userModel.value);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: colors[(index % 3) + 1],
                                      ),
                                      child: Center(
                                          child: const Text("Completed")),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
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
