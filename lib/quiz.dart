import 'package:flutter/material.dart';
import 'package:csc_184_final_project/data/questions.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';
import 'package:csc_184_final_project/screens/questions_screen.dart';
import 'package:csc_184_final_project/screens/results_screen.dart';
import 'package:csc_184_final_project/screens/start_screen.dart';
import 'package:csc_184_final_project/screens/quiz_selection_screen.dart';

// Defining the Quiz StatefulWidget
class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// Defining the _QuizState class
class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  List<QuizQuestion>? questions;
  var currentQuestionIndex = 0;
  String? selectedQuizCollection;
  var activeScreen = 'start-screen';

  // Fetch questions based on the selected quiz collection
  Future<void> _fetchQuestions(String collection) async {
    questions = await fetchQuestions(collection);
    setState(() {});
  }

  // Method to switch to quiz-selection-screen
  void switchScreen() {
    setState(() {
      activeScreen = 'quiz-selection-screen';
    });
  }

  // Method to handle answer selection
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions!.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  // Method to restart the quiz
  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      currentQuestionIndex = 0;
      activeScreen = 'quiz-selection-screen'; // Return to quiz-selection-screen on restart
    });
  }

  // Method to handle quiz selection
  void selectQuiz(String quizCollection) {
    _fetchQuestions(quizCollection);
    setState(() {
      activeScreen = 'questions-screen';
      selectedQuizCollection = quizCollection; // Store the selected collection name
    });
  }

  // Build method to build the UI based on the active screen
  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    switch (activeScreen) {
      case 'quiz-selection-screen':
        screenWidget = QuizSelectionScreen(onQuizSelected: selectQuiz);
        break;
      case 'questions-screen':
        if (questions == null || selectedQuizCollection == null) {
          screenWidget = const Center(child: CircularProgressIndicator());
        } else {
          screenWidget = QuestionsScreen(
            onSelectedAnswer: chooseAnswer,
            quizCollection: selectedQuizCollection!,
          );
        }
        break;
      case 'results-screen':
        screenWidget = ResultsScreen(
          chosenAnswers: selectedAnswers,
          onRestart: restartQuiz,
          questions: questions!,
        );
        break;
      default:
        screenWidget = StartScreen(switchScreen);
    }

    // Returning the MaterialApp widget
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
