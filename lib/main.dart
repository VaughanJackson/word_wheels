import 'package:flutter/material.dart';
import 'package:word_wheels/character_feeder.dart';
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

    // TODO Do this properly - not here, but once on app start up...or when user
    // asks
    // TODO DI?
    final CharacterFeeder feeder = new CharacterFeeder();
    List<String> buckets;
    getVocabulary().then((vocabulary) =>
    { print('1> ' + vocabulary),
      buckets = feeder.provideCharacters(3, 7, vocabulary),
      print('2> ' + buckets.toString())
    });

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
                                              buckets,
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
