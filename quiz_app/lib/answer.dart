import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function answerHandler;
  final String answerText;

  Answer(this.answerHandler,this.answerText);

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child:RaisedButton(
        color: Colors.blueGrey,
        child: Text(answerText),
        onPressed: answerHandler,
      ),
    );
  }
}
