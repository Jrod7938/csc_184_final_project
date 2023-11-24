import 'package:csc_184_final_project/screens/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:csc_184_final_project/data/questions.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';
import 'package:csc_184_final_project/screens/questions_screen.dart';
import 'package:csc_184_final_project/screens/results_screen.dart';
import 'package:csc_184_final_project/screens/start_screen.dart';
import 'package:csc_184_final_project/screens/quiz_selection_screen.dart';

import 'screens/search_screen.dart';

/// The Quiz widget
///
/// This widget is the root widget of the application
class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

/// The Quiz state
///
/// This class is the state of the [Quiz] widget
class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  List<QuizQuestion>? questions;
  var currentQuestionIndex = 0;
  String? selectedQuizCollection;
  var activeScreen = 'start-screen';

  /// Fetch questions based on the selected quiz collection
  Future<void> _fetchQuestions(String collection) async {
    questions = await fetchQuestions(collection);
    setState(() {});
  }

  /// Method to switch the screen
  void switchScreen() {
    setState(() {
      activeScreen = 'quiz-selection-screen';
    });
  }

  /// Method to choose an answer
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

  /// Method to restart the quiz
  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      currentQuestionIndex = 0;
      activeScreen = 'quiz-selection-screen';
    });
  }

  /// Method to handle quiz selection
  void selectQuiz(String quizCollection) {
    _fetchQuestions(quizCollection);
    setState(() {
      activeScreen = 'questions-screen';
      selectedQuizCollection = quizCollection;
    });
  }

  void selectSearch(String quizName) async {
    questions = await fetchQuiz(quizName);
    setState(() {
      activeScreen = 'questions-screen';
      selectedQuizCollection = quizName;
    });
  }

  void createQuiz() {
    setState(() {
      activeScreen = "create_screen";
    });
  }

  void onQuizCreated() {
    switchScreen();
  }

  void searchQuiz() {
    setState(() {
      activeScreen = "search-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    switch (activeScreen) {
      case 'quiz-selection-screen':
        screenWidget = QuizSelectionScreen(
          onQuizSelected: selectQuiz,
          createQuiz: createQuiz,
          searchQuiz: searchQuiz,
        );
        break;
      case 'questions-screen':
        if (questions == null || selectedQuizCollection == null) {
          screenWidget = const Center(child: CircularProgressIndicator());
        } else {
          screenWidget = QuestionsScreen(
            onSelectedAnswer: chooseAnswer,
            questions: questions!,
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
      case 'create_screen':
        screenWidget = CreateScreen(onQuizCreated: onQuizCreated);
        break;
      case 'search-screen':
        screenWidget = SearchScreen(onQuizSelected: selectSearch);
        break;
      default:
        screenWidget = StartScreen(switchScreen);
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
