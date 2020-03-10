import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(CupertinoExample());
}

class CupertinoExample extends StatefulWidget {
  @override
  _CupertinoExampleState createState() => _CupertinoExampleState();
}

class _CupertinoExampleState extends State<CupertinoExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ExamplePage());
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  DateTime _setDate = DateTime.now();
  Duration initialtimer = new Duration();
  int selectitem = 1;

  Widget customPicker() {
    return CupertinoPicker(
      magnification: 1.5,
      backgroundColor: Colors.black87,
      children: <Widget>[
        Text(
          "TextWidget",
          style: TextStyle(
              color: Colors.white, fontSize: 20),
        ),
        MaterialButton(
          child: Text(
            "Button Widget",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.redAccent,
        ),
        IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          iconSize: 40,
          onPressed: () {},
        )
      ],
      itemExtent: 50, //height of each item
      looping: true,
      onSelectedItemChanged: (int index) {
        selectitem = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                child: Text("CustomPicker"),
                color: Colors.blueAccent,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Scaffold(
                            appBar: AppBar(
                              title: Text(
                                "CupertinoPicker",
                                textAlign: TextAlign.justify,
                              ),
                              backgroundColor: Colors.teal,
                              actions: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            body: Container(
                              child: customPicker()
                            ));
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}