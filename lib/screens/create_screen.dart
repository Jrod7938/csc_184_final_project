import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';

/// The Create Quiz Screen widget
///
/// This widget allows the user to create a quiz
///
/// This widget requires the [onQuizCreated] parameter
///
/// This widget is the state of the [CreateScreen] widget
class CreateScreen extends StatefulWidget {
  final Function() onQuizCreated;
  const CreateScreen({super.key, required this.onQuizCreated});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _quizNameController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers = List.generate(4, (index) => TextEditingController());
  String? _correctAnswer;
  List<QuizQuestion> _questions = [];

  @override
  void dispose() {
    _quizNameController.dispose();
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addQuestion() {
    final questionText = _questionController.text.trim();
    final answers = _answerControllers.map((controller) => controller.text.trim()).toList();

    if (questionText.isNotEmpty && answers.every((answer) => answer.isNotEmpty) && _correctAnswer != null) {
      String correctAnswerString = answers[int.parse(_correctAnswer!.split(' ')[1]) - 1];
      _questions.add(QuizQuestion(questionText, answers, correctAnswerString));

      // Clear fields for next question
      _questionController.clear();
      _answerControllers.forEach((controller) => controller.clear());
      setState(() {
        _correctAnswer = null;
      });
    }
  }

  Future<void> _submitQuiz() async {
    final quizName = _quizNameController.text.trim();

    if (quizName.isEmpty || _questions.isEmpty) {
      // Show validation error
      return;
    }

    // Structure to store multiple questions in one document
    final quizData = {
      'questions': _questions
          .map((q) => {
                'questionText': q.questionText,
                'answers': q.answers,
                'correctAnswer': q.correctAnswer,
              })
          .toList()
    };

    // Add to Firestore with quizName as document ID
    await FirebaseFirestore.instance.collection('quizzes').doc(quizName).set(quizData);

    widget.onQuizCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: _quizNameController,
              decoration: const InputDecoration(hintText: 'Enter Quiz Name'),
            ),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(hintText: 'Enter your question'),
            ),
            ...List.generate(4, (index) {
              return TextField(
                controller: _answerControllers[index],
                decoration: InputDecoration(hintText: 'Answer ${index + 1}'),
              );
            }),
            DropdownButton<String>(
              value: _correctAnswer,
              hint: const Text('Select Correct Answer'),
              items: List.generate(4, (index) => 'Answer ${index + 1}').map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _correctAnswer = newValue;
                });
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _addQuestion,
              child: const Text('Add Question'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _submitQuiz,
              child: const Text('Submit Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
