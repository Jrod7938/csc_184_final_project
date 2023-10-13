import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main method
///
/// This method is the entry point of the application
/// This method initializes Firebase and runs the [Quiz] widget
class QuizSelectionScreen extends StatelessWidget {
  final void Function(String quizCollection) onQuizSelected;

  const QuizSelectionScreen({Key? key, required this.onQuizSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select a Quiz',
            style: GoogleFonts.lato(
              fontSize: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions'),
            child: Text(
              'Quiz 1',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions2'),
            child: Text(
              'Quiz 2',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions3'),
            child: Text(
              'Quiz 3',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
