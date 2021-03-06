import 'package:tuple/tuple.dart';

// Builds a phrase from the character selections it is provided with.
class PhraseBuilder {

  final Map<int, String> _selections = Map();

  // A character has been selected on a wheel, capture it for later rendering
  // in phrase.
  void addCharacterSelection(final Tuple2<int, String> characterSelection) {
    print('PhraseBuilder: Adding: [' + characterSelection.item1.toString() +
        '] = ' + characterSelection.item2 );
    _selections[characterSelection.item1] = characterSelection.item2;
    print('PhraseBuilder: _selections = ' + _selections.toString());
  }

  // Builds a phrase from the character selections it has been provided with.
  String buildPhrase() {
    final disposableSelectionsSnapshot = new Map<int, String>.from(_selections);
    final List<int> keys = _selections.keys.toList();
    keys.sort();
    final String phrase = keys.map((key) =>
        disposableSelectionsSnapshot.remove(key)).reduce((phrase, character) {
      print('PhraseBuilder: phrase = ' + phrase + ', character = ' + character);
      phrase += character;
      return phrase; } );
    print('PhraseBuilder: phrase = ' + phrase);
    return phrase;
  }
}