import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './io.dart';
import './classes.dart';
import 'dart:math';

class Learn extends StatefulWidget {
  final CounterStorage storage;
  Learn({Key key, @required this.storage}) : super(key: key);
  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}


class _FlutterDemoState extends State<Learn> {
  String _text = 'w';
  String _firstWord = "En", _secondWord = "RU";
  String data;
//  Collection _data = new Collection(0, [], DateTime.now());
  @override
  void initState() {
    super.initState();
    widget.storage.readJson().then((String value) {
      setState(() {
          data = value;
      });
      print(jsonDecode(data).length);
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _text += 's';
    });
    return widget.storage.writeText(_text);
    // Write the variable as a string to the file.

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Learn')),
        body: Column(
          children: <Widget>[
            Padding(
              child : SizedBox(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(child:
                RaisedButton(
                  color : Colors.lightGreenAccent,
                  onPressed: () => {},

                  child:
                  Center(child: Text('\t$_firstWord \n\n\t $_secondWord')),
                ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),

            Padding(
              child : SizedBox(
                width: MediaQuery.of(context).size.width ,
                child: Center(child:
                RaisedButton(
                  color : Colors.green,
                  onPressed: () {

                  },
                  child:
                  Center(child: Text('Learn')),
                ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
            Padding(
              child : SizedBox(
                width: MediaQuery.of(context).size.width ,
                child: Center(child:
                RaisedButton(
                  color : Colors.red,
                  onPressed:  () {

                  },
                  child:
                  Center(child: Text('Not learn')),
                ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
          ],
        )

    );
  }

}

