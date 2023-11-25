import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// StartScreen is the first screen that the user sees when they open the app.
/// It contains a button that starts the quiz.
///
/// This widget is a StatelessWidget, which means that it cannot change its
/// internal state. This is fine for this screen, since it doesn't need to
/// change its state.
///
/// The constructor takes a function that is called when the user presses the
/// button. This function is passed down to the StartScreen's child widget,
/// which is a StartScreen.
///
/// The StartScreen widget is used in the Quiz widget's build method.
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/image/hofstra.png",
            width: 500,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Learn Flutter the fun way!",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.arrow_circle_right_sharp),
            label: const Text(
              "Start Quiz!",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      ),
    );
  }
}
