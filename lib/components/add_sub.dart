import 'package:flutter/material.dart';
import 'dart:math';

class AddSubView extends StatefulWidget {
  AddSubView({Key key, this.title, this.operation}) : super(key: key);

  final String title;
  final String operation;

  @override
  _AddSubViewState createState() => new _AddSubViewState(operation: operation);
}

class _AddSubViewState extends State<AddSubView> {
  _AddSubViewState({this.operation});

  final String operation;

  num numberA, numberB, answer, totalQuestions = 30;
  String question = "";
  double correctSoFar = 0.00;
  List<num> answers = <num>[1, 2, 3];

  void initState() {
    super.initState();
    setUpQuestion();
  }

  setUpQuestion() {
    var rnm = new Random();
    numberA = rnm.nextInt(10);

    if (operation == 'Addition') {
      numberB = rnm.nextInt(10);
      question = " What is ${numberA} + ${numberB}";
      answer = numberA + numberB;
    } else if (operation == 'Subtraction') {
      do {
        numberB = rnm.nextInt(10);
      } while (numberB > numberA);
      answer = numberA - numberB;
      question = " What is ${numberA} - ${numberB}";
    }

    answers = [];
    answers.add(rnm.nextInt(10));
    answers.add(rnm.nextInt(10));
    answers.add(rnm.nextInt(10));
    answers.add(rnm.nextInt(10));

    answers[rnm.nextInt(3)] = answer;
    setState(() => {});
  }

  List<RaisedButton> createAnswerButtons() {
    var list = [];
 
    for (final item in answers) {
      list.add(new RaisedButton(
        child: new Text(item.toString()),
        onPressed: (){checkAnswer(item);},
      ));
      print(list);
    }
    return list;

    // return [ new RaisedButton( child: new Text("data"),),new RaisedButton( child: new Text("data"),)];
  }

  createOperation() {
    if (operation == 'Addition') {
      return new Text("This is gonna be an addition question");
    } else if (operation == 'Subtraction') {
      return new Text(" this is gonna be a subtraction");
    }
  }

  checkAnswer(givenAnswer) {
    print( "The answer is ${givenAnswer} and the real answer is ${answer}");
    if(givenAnswer == answer){
      print("correct");
      correctSoFar += 0.03;
      setUpQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white10,
        child: new Column(
          children: <Widget>[
            new Text(
              question,
              style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 40.00),
            ),
            new Container(child: new Row(children: createAnswerButtons())),
            new Container(
              child: new Text("progress bar"),
            ),
            new LinearProgressIndicator(value: correctSoFar,)
          ],
        ));
  }
}
