import 'dart:async';
import 'package:flutter/cupertino.dart';

// Relays any character selection reported to it on to its client, but only
// once that character has remain selected for at least 100ms.
class Governor {

  // Period of inactivity that must elapse before this will report the
  // latest character selection.
  final delay = const Duration(milliseconds: 100);

  Timer _timer;
  // Callback for when a character is added to the phrase.
  final ValueSetter<String> _onCharacterSelected;

  Governor(this._onCharacterSelected);

  // A character has been selected on a wheel, if it remains selected for long
  // enough, then this character is reported to the client.
  void onCharacterSelected(final String character) {
    print('Governor.onCharacterSelected(' + character + ')');
    if (_timer != null && _timer.isActive) {
      print('Governor: cancelling timer');
      _timer.cancel();
    }
    print('Governor: considering reporting: ' + character);
    _timer = new Timer(delay, () {
      print('Governor: reporting: ' + character);
      _onCharacterSelected(character);
    });

  }

  // Can be used by client widget code to make sure timer cancelled?
  void dispose() {
    print('Governor.dispose()');
    if (_timer != null && _timer.isActive) {
      print('Governor: cancelling timer');
      _timer.cancel();
    }
  }
}