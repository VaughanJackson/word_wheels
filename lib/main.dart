import 'package:flutter/material.dart';
import 'package:word_wheels/wheel.dart';

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
                                      child: Wheel("wheel1", '你的中文在这里')
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

