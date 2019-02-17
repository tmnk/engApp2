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
  Future getData() {
    var fire = Firestore.instance.collection("backup").add({"data" : "hrrll"});
  }
//  Collection _data = new Collection(0, [], DateTime.now());
  @override
  void initState() {
    super.initState();
    widget.storage.readText().then((String value) {
      setState(() {

      });
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
        appBar: AppBar(title: Text('Sync')),
        body: Column(
          children: <Widget>[
            Padding(
              child : SizedBox(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(child:
                RaisedButton(
                  color : Colors.lightGreenAccent,
                  onPressed: () => getData(),
                  child:
                  Center(child: Text('\tHi')),
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
