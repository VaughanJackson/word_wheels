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
  int selectitem = 1;

  Widget customPicker() {
    return CupertinoPicker(
      magnification: 1.5,
      backgroundColor: Colors.black87,
      children: <Widget>[
        MaterialButton(
          child: Text(
            "你",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        MaterialButton(
          child: Text(
            "好",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        MaterialButton(
          child: Text(
            "吗",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        MaterialButton(
          child: Text(
            "？",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
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
                child: Text("开始！"),
                color: Colors.blueAccent,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Scaffold(
                            appBar: AppBar(
                              title: Text(
                                "水车",
                                textAlign: TextAlign.right,
                              ),
                              backgroundColor: Colors.amber,
                              actions: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.replay),
                                  tooltip: "再玩一次！",
                                  onPressed: () {},
                                )
                              ],
                            ),
                            body: Container(
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: customPicker()
                                  ),
                                  Expanded(
                                      child: customPicker()
                                  ),
                                  Expanded(
                                      child: customPicker()
                                  ),
                                  Expanded(
                                      child: customPicker()
                                  ),
                                  Expanded(
                                      child: customPicker()
                                  ),
                                ])
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