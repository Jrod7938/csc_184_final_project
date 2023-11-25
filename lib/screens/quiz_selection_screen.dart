import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main method
///
/// This method is the entry point of the application
/// This method initializes Firebase and runs the [Quiz] widget
class QuizSelectionScreen extends StatelessWidget {
  final void Function(String quizCollection) onQuizSelected;

  final void Function() createQuiz;
  final void Function() searchQuiz;

  const QuizSelectionScreen({Key? key, required this.onQuizSelected, required this.createQuiz, required this.searchQuiz}) : super(key: key);

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
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions'),
            child: Text(
              'Novice',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions2'),
            child: Text(
              'Intermediate',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions3'),
            child: Text(
              'Proficient',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions4'),
            child: Text(
              'Advanced',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onQuizSelected('questions5'),
            child: Text(
              'Expert',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => createQuiz(),
                child: Text(
                  "Create Quiz",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => searchQuiz(),
                child: Text(
                  "Search Quiz",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
