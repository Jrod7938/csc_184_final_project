import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
