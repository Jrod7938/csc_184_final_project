import 'package:flutter/material.dart';

import 'package:csc_184_final_project/data/questions.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';
import 'package:csc_184_final_project/screens/questions_screen.dart';
import 'package:csc_184_final_project/screens/results_screen.dart';
import 'package:csc_184_final_project/screens/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key); // Fixed super.key to key

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  List<QuizQuestion>? questions; // List to hold the fetched questions
  var currentQuestionIndex = 0; // Index to track the current question
  var activeScreen = 'start-screen';

  @override
  void initState() {
    super.initState();
    _fetchQuestions(); // Fetch questions when the state is initialized
  }

  Future<void> _fetchQuestions() async {
    questions = await fetchQuestions();
    setState(() {});
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions!.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    } else {
      setState(() {
        currentQuestionIndex++; // Increment the question index after an answer is chosen
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      currentQuestionIndex = 0;
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()), // Show a loading indicator while questions are being fetched
        ),
      );
    }

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectedAnswer: chooseAnswer);
    }

    if (activeScreen == "results-screen") {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
        questions: questions!, // Pass the list of questions to ResultsScreen
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
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
          child: screenWidget,
        ),
      ),
    );
  }
}
