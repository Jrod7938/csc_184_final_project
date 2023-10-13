import 'package:flutter/material.dart';

/// The AnswerButton widget
///
/// This widget is a button that displays an answer
///
/// This widget requires the [answerText] and [onTap] parameters
/// The [answerText] parameter is the text of the answer
/// The [onTap] parameter is a function that is called when the button is tapped
///
/// The [onTap] function requires no parameters
class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        backgroundColor: Color.fromARGB(255, 8, 45, 155),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
