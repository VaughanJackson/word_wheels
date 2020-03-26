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

  Widget wheel(final String key) {
    return CupertinoPicker(
      key: Key(key),
      magnification: 1.5,
      backgroundColor: Colors.black87,
      children: <Widget>[
        MaterialButton(
          key: Key(/*key + ".你"*/"wheel1.你"),
          child: Text(
            "你",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        MaterialButton(
          key: Key(key + '.好'),
          child: Text(
            "好",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        MaterialButton(
          key: Key(key + '.吗'),
          child: Text(
            "吗",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        MaterialButton(
          key: Key('$key.?'),
          child: Text(
            "?",
            key: Key('$key.?.text'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
      itemExtent: 50, //height of each item
      looping: false,
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
                key: Key("开始！"),
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
                              key: Key('wheels'),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: wheel("wheel1")
                                  ),
//                                  Expanded(
//                                      child: wheel('wheel2')
//                                  ),
//                                  Expanded(
//                                      child: wheel('wheel3')
//                                  ),
//                                  Expanded(
//                                      child: wheel('wheel4')
//                                  ),
//                                  Expanded(
//                                      child: wheel('wheel5')
//                                  ),
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