import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  IntroductionPage({super.key});

  var listPageModel = [
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
    return Scaffold(
      body: IntroductionScreen(
        pages: listPageModel,
        showSkipButton: false,
        showNextButton: true,
        next: const Text("Next"),
        done: const Text("Done"),
        // controlsPosition: ,
        onDone: () {
          // On button pressed
        },
      ),
    );
  }
}
