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
import './time/time.dart';

class Search extends StatefulWidget {
  final CounterStorage storage;
  Search({Key key, @required this.storage}) : super(key: key);
  @override
  _SearchAndMove createState() => _SearchAndMove();
}
class _SearchAndMove extends State<Search> {
  TextEditingController editingController = TextEditingController();
  List _data;
  List items = new List();

  List duplicateItems;
  @override
  void initState() {
    super.initState();
    widget.storage.readPureJson().then((List value) {
    setState(() {
      _data = value;
      print('!!!');
      duplicateItems = List.generate(value.length, (i) => {"index" : i, "str" : value[i]["en"] + " " + value[i]["ru"].toString()});
      items.addAll(duplicateItems);

      print(items[0]);
    });
  });
  }


  void filterSearchResults(String query) {
    List dummySearchList = new List();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List dummyListData = new List();
      dummySearchList.forEach((item) {
        if(item["str"].contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]["str"]}'),
                    onTap: ()  {
                      _moveData(items[index]["index"], _data);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  _moveData(int index, List data) {
    print(index);
    var a = data[index];
    data.removeAt(index);
    data.insert(0, a);
    setState(() {
      duplicateItems = List.generate(data.length, (i) => {"index" : i, "str" : data[i]["en"] + " " + data[i]["ru"].toString()});
      items.clear();
      items.addAll(duplicateItems);
      widget.storage.writePureJson(data);
    });
  }
}