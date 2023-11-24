import 'package:csc_184_final_project/data/questions.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';
import 'package:csc_184_final_project/widgets/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The questions screen widget
///
/// This widget displays the questions of the quiz
///
/// This widget requires the [onSelectedAnswer] and [quizCollection] parameters
class QuestionsScreen extends StatefulWidget {
  final void Function(String answer) onSelectedAnswer;
  final List<QuizQuestion> questions;

  const QuestionsScreen({super.key, required this.onSelectedAnswer, required this.questions});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= widget.questions.length) {
      return const Center(child: Text('Quiz completed!')); // Or navigate to results screen
    }
    final currentQuestion = widget.questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.questionText,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.answers.map((answer) {
              return Container(
                margin: const EdgeInsets.all(5),
                child: AnswerButton(
                    answerText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    }),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
