// data/questions.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_184_final_project/models/quiz_questions.dart';

Future<List<QuizQuestion>> fetchQuestions() async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('questions').get();
  return snapshot.docs.map((doc) => QuizQuestion.fromFirestore(doc)).toList();
}
