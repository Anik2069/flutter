import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map<String,Object>> questions;
  final String questionText;

  Quiz(this.questionText);

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
