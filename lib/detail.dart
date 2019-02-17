import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './io.dart';
import './classes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DetailScreen extends StatefulWidget {
  final CounterStorage storage;
  DetailScreen({Key key, @required this.storage}) : super(key: key);


  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}


class _FlutterDemoState extends State<DetailScreen> {
  String _text = 'w';
  List data;
  String learning;

  int counter = 0, _len = 0;
  Future getData(String data, String lr, int cnt) {
    Firestore.instance.collection("backup").add({"data" : data});
    Firestore.instance.collection("backup").add({"learning" : lr});
    Firestore.instance.collection("backup").add({"cnt" : cnt});
    Firestore.instance.collection("backup").add({"success" : jsonEncode([])});
  }
//  Collection _data = new Collection(0, [], DateTime.now());
  void initState() {
    super.initState();
    widget.storage.readJson().then((String value) {
      widget.storage.readText().then((List CNT){
        setState(() {
          data = jsonDecode(value);
          counter = CNT[0];
          learning = CNT[1];
          _len = data.length;
        });
        print(CNT);
      });
      print(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sync')),
        body: Column(
          children: <Widget>[
            Center(
                child : Text("Выучено : 0")
            ),

            Center(
                child : Text("Слова в процессе : ${_len - counter}")
            ),
            Center(
                child : Text("Осталось : ${_len}")
            ),
            Padding(
              child : SizedBox(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(child:
                RaisedButton(
                  color : Colors.lightGreenAccent,
                  onPressed: () => getData(jsonEncode(data), jsonEncode(learning), counter),
                  child:  Text('Сохранить текущие данные'),
                ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),

          ],
        )

    );
  }

}
