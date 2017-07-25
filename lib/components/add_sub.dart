import 'package:flutter/material.dart';

class AddSubView extends StatefulWidget {
  AddSubView({Key key, this.title, this.operation}) : super(key: key);

  final String title;
  final String operation;

  @override
  _AddSubViewState createState() => new _AddSubViewState( operation: operation);
}

class _AddSubViewState extends State<AddSubView> {
  _AddSubViewState({this.operation});

  final String operation;
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white10,
      child: new Text( operation),
    );
  }
}
