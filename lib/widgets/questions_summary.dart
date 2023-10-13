import 'package:csc_184_final_project/widgets/summary_item.dart';
import 'package:flutter/material.dart';

/// The questions summary widget
///
/// This widget displays the summary of the questions
///
/// This widget requires the [summaryData] parameter
/// The [summaryData] parameter is a list of maps containing the summary data
class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
