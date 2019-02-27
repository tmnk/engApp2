import 'package:flutter/material.dart';
import './detail.dart';
import './repeat.dart';
import './learn.dart';
import './io.dart';
import './classes.dart';
import './search.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Returning Data',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('engApp'),

      ),
      body: Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Padding(
          child : SizedBox(
//            width: 100,
            height: 100,
            child: Center(child:
            RaisedButton(
              color : Colors.lightGreenAccent,
              onPressed: () {
                _navigateAndDisplaySelection(context);
              },
              child: Center(child: Text('Learn')),
            ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        Padding(
          child : SizedBox(
//            width: 100,
            height: 100,
            child: Center(child:
            RaisedButton(
              color : Colors.cyan,
              onPressed: () {
                _navigateToRepeat(context);
              },
              child: Center(child: Text('Repeat')),
            ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        Padding(
          child : SizedBox(
//            width: 100,
            height: 100,
            child: Center(child:
            RaisedButton(
              color : Colors.cyan,
              onPressed: () {
                _navigateToSearch(context);
              },
              child: Center(child: Text('Seach')),
            ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        Padding(
          child : SizedBox(
//            width: 100,
            height: 100,
            child: Center(child:
            RaisedButton(
              color : Colors.brown,
              onPressed: () {
                _navigateToSync(context);
              },
              child: Center(child: Text('Sunc')),
            ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ],

    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop!
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Learn(storage: CounterStorage())),
    );
    print(result.toString());
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!

  }
  _navigateToRepeat(BuildContext context) async {
    Word a = new Word("Easy", "Легко", 0, [4]);
    Word b = new Word("Normal", "Средне", 0, [4, 5]);
    Word c = new Word("Hard", "Сложно", 0, [4, 3 , 2]);
    Collection l = new Collection(0, [a,b,c]);
    print(l.jsonReturn());

    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Repeat(storage: CounterStorage(), repeatNum : 2, jsonData : l)), ///////////////////////Стору надо послать
    );
    if (result != null) print(result.jsonReturn());
  }
  _navigateToSearch(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Search(storage: CounterStorage())),
    );
    print(result.toString());
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!

  }
  _navigateToSync(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(storage: CounterStorage())),
    );
    print(result.toString());
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!

  }
}
