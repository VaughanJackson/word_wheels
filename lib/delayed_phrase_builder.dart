import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

// Builds a phrase from the character selections it is provided with, but waits
// for a certain interval of inactivity following a selection before accepting
// the selection as 'confirmed'.
class DelayedPhraseBuilder {

  final delay = const Duration(milliseconds: 100);
  final Map<int, String> _selections = Map();
  Timer _timer;
  // Callback for when a character is added to the phrase.
  final ValueSetter<String> _onCharacterSelected;

  DelayedPhraseBuilder(this._onCharacterSelected);

  // A character has been selected on a wheel, if it remains selected for long
  // enough, then this character is added to the selections and the phrase
  // reported to the client
  void addCharacterSelection(final Tuple2<int, String> characterSelection) {
    if (_timer != null && _timer.isActive) {
      print('Cancelling timer');
      _timer.cancel();
    }
    print('DelayedPhraseBuilder: considering adding: [' + characterSelection.item1.toString() + '] = ' + characterSelection.item2 );
    _timer = new Timer(delay, () {
      print('DelayedPhraseBuilder: Adding: [' + characterSelection.item1.toString() + '] = ' + characterSelection.item2 );
      _selections.putIfAbsent(characterSelection.item1, () => characterSelection.item2);
      _onCharacterSelected(_buildPhrase());
    });

  }

  // Builds a phrase from the character selections it has been provided with.
  String _buildPhrase() {
    return _selections.isEmpty ? '' : _selections.values.reduce((phrase, character) {
      print('DelayedPhraseBuilder: phrase = ' + phrase + ', character = ' + character);
      phrase += character;
      return phrase; } );
  }
}