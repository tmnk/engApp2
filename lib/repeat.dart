import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './io.dart';
import './classes.dart';
import 'dart:math';

class Repeat extends StatefulWidget {
  final CounterStorage storage;
  final int repeatNum;
  Collection jsonData;
  Repeat({Key key, @required this.storage, @required this.repeatNum, @required this.jsonData}) : super(key: key);


  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}


class _FlutterDemoState extends State<Repeat> {
  int _currNum = 0;
  String _text = 'w';
  String _firstWord = "English";
  String _secondWord = "Руcский";
  String _mode;
  Word _currWord;
  List data, succesData;
//  Collection _data = new Collection(0, [], DateTime.now());
  @override
  void initState() {
    super.initState();
//    widget.storage.readText().then((List value) {
      setState(() {
        data = widget.jsonData.data;
        succesData = new List();
        _currWord =  data.removeLast();
        _firstWord = _currWord.en;
        _secondWord = '';
        _mode = "EN";
        _currNum = 0;
//        if (widget.repeatNum == 0) Navigator.pop(context, null);
      });
//      print(_currWord.ru);
//    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repeat')),
      body: Column(
        children: <Widget>[
          Center(
            child : Text(
              "${data.length + 1} / ${data.length + succesData.length + 1}"
            )
          ),
          Padding(
            child : SizedBox(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(child:
              RaisedButton(
                color : Colors.lightGreenAccent,
                onPressed: (_mode != "EN" && _mode != "RU")  ? null : () {
                      setState(() {
                        if (_mode == "EN") {
                          _secondWord = " - " + _currWord.ru;
                          _mode = "-e";
                        }
                        else {
                          _secondWord = " - " + _currWord.en;
                          _mode = "-r";

                        }
                      });
                },
                child:
                      Center(child: Text('\t$_firstWord  $_secondWord')),
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
                onPressed: (_mode != "-e" && _mode != "-r")  ? null : () {
                  _chooseNum(5);
                },
                child:
                Center(child: Text('Не повторять')),
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
                color : Colors.yellowAccent,
                onPressed: (_mode != "-e" && _mode != "-r")  ? null : () {
                  _chooseNum(3);
                },
                child:
                Center(child: Text('Повторить разок')),
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
                onPressed: (_mode != "-e" && _mode != "-r")  ? null : () {
                  _chooseNum(1);
                },
                child:
                Center(child: Text('Плохо')),
              ),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
        ],
      )

    );
  }
  _chooseNum(int n) {
    _currWord.add(n);

    stdout.write('<' + data.length.toString() + ' ');
    if (n == 5) succesData.add(_currWord);
    else if (n == 3) {
      if (_currWord.last3() == 1) {
        if (_currWord.mark.last == 3) {
          _currWord.mark.last = 4;
        }
        succesData.add(_currWord);
      }
      else {
        if (data.length == 0) succesData.add(_currWord);
        else data.insert(0, _currWord);
      }

    }
    else {
      if (data.length == 0) succesData.add(_currWord);
      else {
        double pl = data.length / 2;
        data.insert(pl.floor(), _currWord);
      }
    }


    stdout.write(' ' + data.length.toString() + '>');
    setState(() {
      if (data.length == 0 && _mode == "-e") { //Конец половины обхода, надо поменять на русский
        data = succesData;
        data.shuffle();
        succesData = new List();
        _mode = "RU";
        _currWord = data.removeLast();
        _firstWord = _currWord.ru;
        _secondWord = "";
      }
      else if (data.length == 0 && _mode == "-r") { // Конец целого обхода
        _currNum++;
        if (_currNum >= widget.repeatNum) { // Конец всех обходов
          Navigator.pop(context, new Collection(widget.jsonData.collectionId, succesData));
        }
        else {
          data = succesData;
          data.shuffle();
          succesData = new List();
          _mode = "EN";
          _currWord = data.removeLast();
          _firstWord = _currWord.en;
          _secondWord = "";
        }
      }
      else {
        _currWord = data.removeLast();
        if (_mode == "-r") {
          _mode = "RU";
          _firstWord = _currWord.ru;
          _secondWord = "";
        }
        else {
          _mode = "EN";
          _firstWord = _currWord.en;
          _secondWord = "";
        }
      }
    });
  }
}
