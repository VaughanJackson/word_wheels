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

  void _handleSelection(selection) {
    setState(() {
      _phrase = selection;
      print('_phrase = ' + _phrase);
    });
  }

  void _play(vocabulary) {
    // TODO DI?
    final CharacterFeeder feeder = new CharacterFeeder();
    final List<String>  buckets = feeder.provideCharacters(3, 7, vocabulary);
    print('2> ' + buckets.toString());
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
                          _play(snapshot.data);
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
