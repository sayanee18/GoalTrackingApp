import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goal_tracking_app/constant/constants.dart';
import 'package:goal_tracking_app/controller/user_controller.dart';
import 'package:goal_tracking_app/models/task_model.dart';
import 'package:goal_tracking_app/service/firebase_service.dart';
import 'package:goal_tracking_app/view/pages/home_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AddNewGoal extends StatelessWidget {
  AddNewGoal({super.key, required this.controller});
  UserController controller;
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final TextEditingController dateTimeEditingController =
      TextEditingController();
  final String priority = "Normal";
  final RxList<dynamic> subgoal = [].obs;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 245, 245),
                        borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        subgoal.add(
                          TaskModel(
                            taskName: "",
                            description: "",
                            startDate: DateTime.now(),
                            isCompleted: false,
                            priority: priority,
                            subTask: [],
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Add subgoal",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    controller.userModel.value.pending.add(
                      TaskModel(
                        taskName: titleEditingController.text,
                        description: descriptionEditingController.text,
                        startDate: DateTime.now(),
                        isCompleted: false,
                        subTask: subgoal as List<TaskModel>,
                        priority: priority,
                      ),
                    );
                    FirebaseService service = FirebaseService();
                    await service.setUserModel(controller.userModel.value);
                    Get.offAll(
                      HomePage(
                        controller: controller,
                      ),
                    );
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor("FFE500"),
                    ),
                    child: const Center(
                      child: Text(
                        "Save Goal",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text(
            "Add new goal",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: descriptionEditingController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "End Date",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: dateTimeEditingController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        var dateTime =
                            await showDateTimePicker(context: context);

                        DateFormat format = DateFormat("dd-MM-yyyy HH:mm");
                        dateTime = format.parse(dateTime.toString());
                        dateTimeEditingController.text = dateTime
                            .toString()
                            .replaceRange(0, 2, "")
                            .replaceRange(14, 21, "");
                        // print(dateTime);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => SizedBox(
                    // height: subgoal.length * height * 0.12,
                    child: ListView.builder(
                      itemCount: subgoal.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        TextEditingController titleEditingController =
                            TextEditingController();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subgoal ${(index + 1)}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    subgoal.removeAt(index);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: titleEditingController,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 245, 245, 245),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
