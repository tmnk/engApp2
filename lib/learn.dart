import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './io.dart';
import './classes.dart';
import 'dart:math';
import './repeat.dart';

class Learn extends StatefulWidget {
  final CounterStorage storage;
  Learn({Key key, @required this.storage}) : super(key: key);
  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}


class _FlutterDemoState extends State<Learn> {
  String _text = 'w';
  String _firstWord = "En", _secondWord = "RU";
  int _currCount = 0;
  int count;
  List data, trash = new List(), _d3ata = new List(), _d9ata = new List(), _d27ata = new List();
//  Collection _data = new Collection(0, [], DateTime.now());
  @override
  void initState() {
    super.initState();
    widget.storage.readJson().then((String value) {
      setState(() {
          data = jsonDecode(value);
          _currCount = data.length - 1;
          _firstWord = data[_currCount]["en"];
          _secondWord = data[_currCount]["ru"];
          count = 0;
      });
      print(data.length);
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
                  onPressed: ()  {
                    setState(()  {
                      count++;
                      if (count == 3) {
                        _d3ata.add(new Word(_firstWord, _secondWord, 0, []));
                        if (_d9ata.length == 6) {
                          _d9ata += _d3ata;
                           _navigateToRepeat(context, _d9ata, 9);
                          _d27ata += _d9ata;
                          //if _d27 == 18 ...
                          _d9ata = new List();
                        }
                        else {
                           _navigateToRepeat(context, _d3ata, 3);
                          _d9ata += _d3ata;
                        }
                        _d3ata = new List();
                        count = 0;

                      }
                      else {
                        _d3ata.add(new Word(_firstWord, _secondWord, 0, []));
                      }
                      _currCount--;
                      _firstWord = data[_currCount]["en"];
                      _secondWord = data[_currCount]["ru"];
                    });
                    print(_currCount);
                  },

                  child:
                  Center(child: Text('\t$_firstWord - $_secondWord')),
                ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),


            Padding(
              child : SizedBox(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height / 4 ,
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
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ],
        )

    );
  }
  _navigateToRepeat(BuildContext context, List d, int r) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Repeat(storage: CounterStorage(), repeatNum : 1, jsonData : new Collection(0, d, DateTime.now()))), ///////////////////////Стору надо послать
    );
    if (result != null) {
      print(result.jsonReturn());
    }
    else {
      setState((){
        _currCount += r;
        count = 0;
        _firstWord = data[_currCount]["en"];
        _secondWord = data[_currCount]["ru"];
      });
    }
  }
}

