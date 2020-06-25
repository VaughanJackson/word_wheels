import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  // cached result from REST call
  String _vocabulary;
  // re-jigged from _vocabulary each time user starts new 'game'
  List<String> _buckets;

  void _handleSelection(selection) {
    setState(() {
      _phrase = selection;
      print('_phrase = ' + _phrase);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
          future: getVocabulary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print('>>>' + snapshot.connectionState.toString());
              if (snapshot.hasData) {
                print('Got data!: ' + snapshot.data);
              } else if (snapshot.hasError) {
                print('Got error!:' + snapshot.error);
              }
              _vocabulary = snapshot.data;
              print('1> ' + snapshot.data);
              return Container(
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
                          // TODO DI?
                          final CharacterFeeder feeder = new CharacterFeeder();
                          _buckets = feeder.provideCharacters(3, 7, _vocabulary);
                          print('2> ' + _buckets.toString());
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
                                                    _buckets,
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
              );
            } else {
              return CircularProgressIndicator();
            }
          }
      ),

    );
  }
}
