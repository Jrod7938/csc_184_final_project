import 'package:cloud_firestore/cloud_firestore.dart';

class QuizQuestion {
  final String questionText;
  final List<String> answers;
  final String correctAnswer;

  QuizQuestion(this.questionText, this.answers, this.correctAnswer);

  factory QuizQuestion.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return QuizQuestion(data['questionText'], List<String>.from(data['answers']), data['correctAnswer']);
  }
}
