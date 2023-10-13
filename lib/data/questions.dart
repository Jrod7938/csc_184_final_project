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
