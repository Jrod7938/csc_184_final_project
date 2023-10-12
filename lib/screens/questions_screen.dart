import 'package:csc_184_final_project/data/questions.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';
import 'package:csc_184_final_project/widgets/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key, required this.onSelectedAnswer}) : super(key: key);

  final void Function(String answer) onSelectedAnswer;

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
    return FutureBuilder<List<QuizQuestion>>(
      future: fetchQuestions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final questions = snapshot.data!;
          if (currentQuestionIndex >= questions.length) {
            return const Center(child: Text('Quiz completed!')); // Or navigate to results screen
          }
          final currentQuestion = questions[currentQuestionIndex];

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
      },
    );
  }
}
