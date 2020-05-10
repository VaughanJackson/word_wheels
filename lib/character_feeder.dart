import 'dart:math';

import 'package:characters/characters.dart';

// Responsible for the generation of a list of strings of characters randomly
// selected from the vocabulary provided by the client.
class CharacterFeeder {

  final Random _random = new Random();

  List<String> provideCharacters(final int numberOfLists,
                                 final int listLength,
                                 final String vocabulary) {

    _validateArguments(numberOfLists, listLength, vocabulary);

    final List<String> characters = List<String>();
    String remainingVocabulary = vocabulary;
    for (int i = 0; i < numberOfLists; i++) {
      final Selection selection = getSelection(remainingVocabulary, listLength);
      characters.insert(i, selection.selectedCharacters);
      remainingVocabulary = selection.remainingVocabulary;
    }
    return characters;
  }

  bool containsDuplicateCharacters(final String vocabulary) {
    return getUniqueCharacters(vocabulary).length < vocabulary.length;
  }

  Set<String> getUniqueCharacters(final String vocabulary) {
    return vocabulary.split('').getRange(0, vocabulary.length).toSet();
  }

  Selection getSelection(final String vocabulary, final int selectionSize) {
    int noOfCharactersToSelect = selectionSize;
    final List<String> characters = vocabulary.characters.toList();
    String remainingVocabulary = vocabulary;
    String selectedCharacters = '';
    while (noOfCharactersToSelect > 0) {
      final String characterSelected =
        characters.elementAt(_random.nextInt(characters.length));
      selectedCharacters += characterSelected;
      characters.remove(characterSelected);
      remainingVocabulary = characters.reduce((a, b) => a + b);
      noOfCharactersToSelect--;
    }
    return new Selection(remainingVocabulary, selectedCharacters);
  }

  void _validateArguments(final int numberOfLists,
      final int listLength,
      final String vocabulary) {

    if (numberOfLists * listLength > vocabulary.length) {
      throw new VocabularyTooSmall(vocabulary);
    }

    if (containsDuplicateCharacters(vocabulary)) {
      throw new VocabularyContainsDuplicates(vocabulary);
    }

  }

}

class Selection {
  final String remainingVocabulary;
  final String selectedCharacters;

  const Selection(this.remainingVocabulary, this.selectedCharacters);
}

class VocabularyTooSmall implements Exception {
  final String _vocabulary;

  const VocabularyTooSmall(this._vocabulary);
}

class VocabularyContainsDuplicates implements Exception {
  final String _vocabulary;

  const VocabularyContainsDuplicates(this._vocabulary);
}

