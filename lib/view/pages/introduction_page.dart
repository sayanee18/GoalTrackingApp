import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  IntroductionPage({super.key});
  Rx<int> currentIndex = 0.obs;
  final listPageModel = [
    PageViewModel(
      title: "Set your goals!",
      body:
          "Don't worry if you have trouble determining your goals, we can help you!",
      image: Center(
        child: Image.asset("assets/Intro1.png"),
      ),
    ),
    PageViewModel(
      title: "Track your progress",
      body: "You set your goals and we will help you track and achieve them",
      image: Center(
        child: Image.asset("assets/Intro2.png"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: IntroductionScreen(
            canProgress: (val) {
              currentIndex.value = val;
              return true;
            },
            customProgress: Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: currentIndex.value == 0 ? 20 : 10,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: currentIndex.value == 0
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                        borderRadius: currentIndex.value == 0
                            ? BorderRadius.circular(3)
                            : null,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Container(
                      height: 10,
                      width: currentIndex.value == 1 ? 20 : 10,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: currentIndex.value == 1
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                        borderRadius: currentIndex.value == 1
                            ? BorderRadius.circular(3)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pages: listPageModel,
            showSkipButton: false,
            showNextButton: true,
            next: const Text("Next"),
            done: const Text("Done"),
            onDone: () {
              // On button pressed
            },
          ),
        ),
      ),
    );
  }
}
