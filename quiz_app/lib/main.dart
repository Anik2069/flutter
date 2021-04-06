//Import Apps
import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

//starting form scatch
void main() {
  //run code
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //Global Question

  final questions = const [
    {
      'questionText': 'Whats is Favt P L name?',
      'answer': [
        {'text': 'C', 'Score': 10},
        {'text': 'C++', 'Score': 10},
        {'text': 'Dart', 'Score': 10},
        {'text': 'PHP', 'Score': 10}],
    },
    {
      'questionText': 'what\'s is ur favt color?',
      'answer': [
        {'text': 'Red', 'Score': 5},
        {'text': 'Black', 'Score': 10},
        {'text': 'White', 'Score': 9},
        {'text': 'Yellow', 'Score': -2}],
    },
    {
      'questionText': 'what\'s is ur favt Car?',
      'answer': [
        {'text': 'None', 'Score': 0},
        {'text': 'Bike', 'Score': 7},
        {'text': 'Car', 'Score': 10},
        {'text': 'None', 'Score': 0}],
    },
  ];

  var questionIndex = 0;
  var totalScore = 0;

  void answerQuestion(int score) {
    //Function
    totalScore = totalScore + score;
    if (questionIndex < questions.length) {
      print("we have for question");
    }
    setState(() {
      questionIndex = questionIndex + 1;
    });
    print("Answer Choosen");
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
    });
  }

  // user underscode( _ ) for making private class or variable
  Widget build(BuildContext context) {
    /* var questions = ['1. Whats is ur name?', '2. what\'s is ur favt color?'];*/
    //adding Maps
/*    var questions = [
      {
        'questionText': 'Whats is Favt P L name?',
        'answer': ['C','C++','Dart','PHP'],
      },
      {
        'questionText': 'what\'s is ur favt color?',
        'answer': ['Red','Blue','White','None'],
      },
      {
        'questionText': 'what\'s is ur favt Car?',
        'answer': ['None','Bike','Dart','None'],
      },
    ];*/

    //Adding Const Concept

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
        ),
        /*body: Text("Deafult Text"),*/
        body: questionIndex < questions.length
            ? Column(
          children: [
            /*Text(
              */ /* questions.elementAt(0),*/ /*
              questions[questionIndex],
            ),*/
            Question(
              questions[questionIndex]['questionText'],
            ),
            // RaisedButton(child: Text('Answer 1'), onPressed: answerQuestion),
            // RaisedButton(
            //   child: Text('Answer 2'),
            //   onPressed: () => print("Answer 2 Select"),
            // ),
            // RaisedButton(
            //     child: Text('Answer 4'),
            //     onPressed: () {
            //       print("Answer 3 select");
            //     }),
            /* Answer(answerQuestion),
                      Answer(answerQuestion),
                      Answer(answerQuestion),*/
            //dYNAMIC pART without Score
            /*...(questions[questionIndex]['answer'] as List<String>)
                      .map((answer) {
                    return Answer(answerQuestion, answer);
                  }).toList()*/
            //With Score or object
            ...(questions[questionIndex]['answer'] as List<Map<String, Object>>)
                .map((answer) {
              return Answer(() => answerQuestion(answer['Score']),
                  answer['text']);
            }).toList()
          ],
        )
            : Center(
          child:
          Column(
            children: <Widget>[
              Text(
                'Your Final Score :' + totalScore.toString(),
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              FlatButton(child: Text('Restart Quiz!'), onPressed: resetQuiz,)
            ],
          ),
        ),
      ),
    );
  }
}
