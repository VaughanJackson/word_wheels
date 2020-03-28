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

class Wheel extends StatefulWidget {
  final String wheelKey;
  final String characters;

  Wheel(this.wheelKey, this.characters);

  @override
  State<StatefulWidget> createState() => _WheelState();

}

class _WheelState extends State<Wheel> {
  int selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [];
    widget.characters.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      buttons.add(MaterialButton(
        key: Key('$widget.wheelKey.$character'),
        child: Text(
          character,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ));
    });
    return CupertinoPicker(
      key: Key(widget.wheelKey),
      magnification: 1.5,
      backgroundColor: Colors.black87,
      children: buttons,
      itemExtent: 50, //height of each item
      looping: false,
      onSelectedItemChanged: (int index) {
        selectedItem = index;
      },
    );
  }
}