import 'package:cloud_firestore/cloud_firestore.dart';

/// A quiz question
///
/// This class represents a quiz question
///
/// This class requires the [questionText], [answers], and [correctAnswer] parameters
/// The [questionText] parameter is the text of the question
/// The [answers] parameter is a list of possible answers
/// The [correctAnswer] parameter is the correct answer
///
/// This class has a factory constructor that creates a [QuizQuestion] object from a [DocumentSnapshot]
/// The [DocumentSnapshot] parameter is the document snapshot to create the [QuizQuestion] object from
class QuizQuestion {
  final String questionText;
  final List<String> answers;
  final String correctAnswer;

  QuizQuestion(this.questionText, this.answers, this.correctAnswer);

  /// Factory constructor to create a [QuizQuestion] object from a [DocumentSnapshot]
  factory QuizQuestion.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return QuizQuestion(data['questionText'], List<String>.from(data['answers']), data['correctAnswer']);
  }
}
