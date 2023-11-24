import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';

/// Fetch questions from the Firestore database
///
/// This function fetches questions from the Firestore database
///
/// This function requires the [collection] parameter
/// The [collection] parameter is the name of the collection to fetch questions from
Future<List<QuizQuestion>> fetchQuestions(String collection) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collection).get();
  return snapshot.docs.map((doc) => QuizQuestion.fromFirestore(doc)).toList();
}

/// Fetch a quiz from the Firestore database
///
/// This function fetches a quiz from the Firestore database
///
/// This function requires the [quizName] parameter
/// The [quizName] parameter is the name of the quiz to fetch
Future<List<QuizQuestion>> fetchQuiz(String quizName) async {
  DocumentSnapshot quizDoc = await FirebaseFirestore.instance.collection('quizzes').doc(quizName).get();

  if (!quizDoc.exists) {
    return []; // Return an empty list if the quiz is not found
  }

  var quizData = quizDoc.data() as Map<String, dynamic>;
  var questionsData = quizData['questions'] as List<dynamic>;

  return questionsData.map((q) {
    var questionMap = q as Map<String, dynamic>;
    return QuizQuestion(
      questionMap['questionText'],
      List<String>.from(questionMap['answers']),
      questionMap['correctAnswer'],
    );
  }).toList();
}
