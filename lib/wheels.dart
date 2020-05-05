import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_wheels/phrase_builder.dart';
import 'package:word_wheels/wheel.dart';
import 'module_container.dart';

class Wheels extends StatelessWidget {
  final List<String> characters;
  // TODO At some point an evaluation of this will be displayed by some widget.
  final Map<int, String> selections = Map();

  // Callback for when a character is selected.
  final ValueSetter<String> _onCharacterSelected;

  Wheels(this.characters, this._onCharacterSelected);

  @override
  Widget build(BuildContext context) {

    final PhraseBuilder phraseBuilder = injector.get<PhraseBuilder>();

    final List<Widget> wheels = [];
    int index = 0;
    characters.forEach((chars) {
      wheels.add(Expanded(
          child: Wheel(
              index,
              'wheel$index',
              chars,
              (selection) {
                print('Wheels: @selection = ' + selection.toString());
                phraseBuilder.addCharacterSelection(selection);
                print('Wheels: Accumulated phrase = ' + phraseBuilder.buildPhrase());
                this._onCharacterSelected(phraseBuilder.buildPhrase());
              })
      ));
      index++;
    });
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
        key: Key('wheels'),
        child: Row(children: wheels)
    ));
  }
}
