import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goal_tracking_app/controller/user_controller.dart';
import 'package:goal_tracking_app/service/user_service.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home_page.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key, required this.controller});
  UserController controller;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/sign.png",
                  // height: height * 0.5,
                ),
                const Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () async {
                    UserService service = UserService();
                    await service
                        .loginUser(email.text, password.text)
                        .then((value) => {
                              controller.userModel.value.name = name.text,
                              if (FirebaseAuth.instance.currentUser != null)
                                Get.offAll(
                                  HomePage(
                                    controller: controller,
                                  ),
                                ),
                            });
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width,
                    decoration: BoxDecoration(
                        color: HexColor("FFE500"),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Register",
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
      ),
    );
  }
}
