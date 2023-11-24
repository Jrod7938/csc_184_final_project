import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

/// The Search Screen widget
///
/// This widget allows the user to search for a quiz
///
/// This widget requires the [onQuizSelected] parameter
///
/// This widget is the state of the [SearchScreen] widget
class SearchScreen extends StatefulWidget {
  final Function(String) onQuizSelected;

  const SearchScreen({Key? key, required this.onQuizSelected})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchTerm = '';

  void _searchQuiz(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter Quiz Name',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: _searchQuiz,
              ),
            ),
            Expanded(
              child: (_searchTerm.isEmpty)
                  ? Center(
                      child: Text(
                      'Please enter a quiz name to search.',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ))
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('quizzes')
                          .where(FieldPath.documentId, isEqualTo: _searchTerm)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No quizzes found'));
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return ListTile(
                              title: Text(doc.id),
                              onTap: () => widget.onQuizSelected(doc.id),
                            );
                          }).toList(),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
