import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:async';

class ReadingEx extends StatefulWidget {
  ReadingEx({Key key, this.title, this.operation}) : super(key: key);

  final String title;
  final String operation;

  @override
  _ReadingExState createState() => new _ReadingExState();
}

void rungetdata() {}

class _ReadingExState extends State<ReadingEx> {
  _ReadingExState();
  Stopwatch timer;
  Timer updater;
  List savedWords = [];
  num wordAt = 0;
  String status, wordDisplaying = "...";
  String display = " Timer";

  void initState() {
    super.initState();
  }

  void runthing() {
    _getBook();
    startTimer();
  }

  startTimer() {
    timer = new Stopwatch()..start();
    updater = new Timer.periodic(new Duration(seconds: 1), updateTimer);
  }

  void updateTimer(passedTimer) {
    String secondsString, minutesString;
    Duration thing = timer.elapsed;
    int secondsInt = thing.inSeconds % 60;
    secondsString = (secondsInt < 10)
        ? "0" + secondsInt.toString()
        : secondsString = secondsInt.toString();
    int minutesInt = thing.inMinutes % 60;
    minutesString = (minutesInt < 10)
        ? minutesString = "0" + minutesInt.toString()
        : minutesString = minutesInt.toString();

    display = minutesString + ":" + secondsString;
    if (thing.inSeconds % 3 == 0) {
      if (savedWords.isNotEmpty && wordAt < 100) {
        wordDisplaying = savedWords[wordAt];
        wordAt++;
      } else if (wordAt >= 100) {
        wordDisplaying = "Yay you finished!";
      }
    }
    setState(() => {});
  }

  _getBook() async {
    wordAt = 0;
    status = "";
    var url =
        'https://firebasestorage.googleapis.com/v0/b/kevin-app-needlist.appspot.com/o/tresositos.txt?alt=media&token=c5188801-a770-4c14-ab3a-90ac1b78ae03';
    try {
      var httpClient = createHttpClient();
      var response = await httpClient.read(url);

      print(response);
      var rnm = new Random();

      List wordlist = response.split(" ");
      var ran;
      do {
        ran = rnm.nextInt(wordlist.length);
      } while (ran + 100 >= wordlist.length);
      wordDisplaying = "";
      savedWords = [];
      for (var t = ran; t < (ran + 100); t++) {
        if (wordlist[t] != null) {
          savedWords.add(wordlist[t]);
          // wordDisplaying += wordlist[t];
        }
      }
      setState(() => {});
    } catch (e) {
      print("seomthing went wrong" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle2 = const TextStyle(
        fontFamily: "Open sans", fontSize: 52.0, color: Colors.black);
    return new Container(
      color: Colors.white10,
      child: new Column(
        children: <Widget>[
          new Text(display),
          new RaisedButton(
            child: new Text("Press to start"),
            onPressed: runthing,
          ),
          new RichText(
            text: new TextSpan(
              text: wordDisplaying,
              style: textStyle2,
            ),
          )
        ],
      ),
    );
  }
}
