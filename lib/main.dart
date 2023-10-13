import 'package:csc_184_final_project/data/firebase_options.dart';
import 'package:csc_184_final_project/quiz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// The main method
///
/// This method is the entry point of the application
/// This method initializes Firebase and runs the [Quiz] widget
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Quiz());
}
