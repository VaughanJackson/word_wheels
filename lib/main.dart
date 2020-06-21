import 'package:flutter/material.dart';
import 'wheels.dart';
import 'package:word_wheels/backend/services/vocabulary_service.dart';

void main() {
  runApp(WordWheels());
}

class WordWheels extends StatefulWidget {
  @override
  _WordWheelsState createState() => _WordWheelsState();
}

class _WordWheelsState extends State<WordWheels> {
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

  String _phrase = '';

  void _handleSelection(selection) {
    setState(() {
      _phrase = selection;
      print('_phrase = ' + _phrase);
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO Do this properly
    getVocabulary().then((vocab) => print(vocab));

    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppBar(title: Text('句词：$_phrase', textAlign: TextAlign.start)),
              Spacer(),
              MaterialButton(
                key: Key("开始！"),
                child: Text("开始！"),
                color: Colors.blueAccent,
                onPressed: () {
                  _handleSelection(''); // reset
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Scaffold(
                            appBar: AppBar(
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
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Wheels(
                                              [
                                                '你的中文在这里',
                                                '我的中文在这里',
                                                '她的中文在这里'
                                              ],
                                              (selection) {
                                                print('_ExamplePageState selection = ' + selection);
                                                _handleSelection(selection);
                                              }
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                            ));
                      });
                },
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
