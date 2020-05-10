import 'package:flutter_test/flutter_test.dart';
import 'package:word_wheels/character_feeder.dart';

// Unit tests the CharacterFeeder class.
void main() {

  final CharacterFeeder _feederUnderTest = new CharacterFeeder();

  test('Feeder rejects vocabulary that contains duplicates', () async {
    expect(() => _feederUnderTest.provideCharacters(1, 2, '里外里面的'),
        throwsA(isA<VocabularyContainsDuplicates>()));
  });

  test('Feeder rejects vocabulary that is too small', () async {
    expect(() => _feederUnderTest.provideCharacters(5, 10, '这里只有七个字'),
        throwsA(isA<VocabularyTooSmall>()));
  });

  test('Feeder produces the correct number of lists', () async {
    final List<String> characters =
      _feederUnderTest.provideCharacters(2, 3, '这里只有七个字');
    expect(characters.length, 2);
  });

  test('Feeder produces lists of the correct length', () async {
    final List<String> characters =
      _feederUnderTest.provideCharacters(2, 3, '这里只有七个字');
    characters.forEach((final String row) => { expect(row.length, 3) });
  });

  test('Feeder gets selection correctly', () async {
    final Selection selection =
      _feederUnderTest.getSelection('这里只有七个字', 3);

    // selection contains number of characters specified
    expect(selection.selectedCharacters.length, 3);

    // remaining vocabulary is original length - length removed
    expect(selection.remainingVocabulary.length, '这里只有七个字'.length - 3);

    // selection characters are unique
    expect(
        _feederUnderTest.containsDuplicateCharacters(selection.selectedCharacters),
        false);

  });

  test('Feeder produces lists that contain no duplicates', () async {
    final List<String> characters =
    _feederUnderTest.provideCharacters(2, 3, '这里只有七个字');

    print('++++' + characters.toString());
    final String concatenatedCharacters = characters.reduce((a, b) => a + b);
    print('>>>' + concatenatedCharacters);
    expect(_feederUnderTest.containsDuplicateCharacters(concatenatedCharacters),
        false);
  });

  test('Feeder produces lists containing only characters from the vocabulary',
          () async {

    final String vocabulary = '这里只有七个字';

    final List<String> characters =
      _feederUnderTest.provideCharacters(2, 3, vocabulary);

    final String charactersProvided = characters.reduce((a, b) => a + b);
    final Set<String> charactersProvidedSet =
      _feederUnderTest.getUniqueCharacters(charactersProvided);
    final Set<String> vocabularySet =
      _feederUnderTest.getUniqueCharacters(vocabulary);
    expect(vocabularySet.containsAll(charactersProvidedSet), true);
  });

  // This may occasionally fail?
  test('Each feeder feed differs from those that came before it', () async {
    final List<String> characters1 =
    _feederUnderTest.provideCharacters(2, 3, '这里只有七个字');
    final List<String> characters2 =
    _feederUnderTest.provideCharacters(2, 3, '这里只有七个字');
    final List<String> characters3 =
    _feederUnderTest.provideCharacters(2, 3, '这里只有七个字');
    print(characters1);
    print(characters2);
    print(characters3);
    expect(characters1 != characters2, true);
    expect(characters1 != characters3, true);
  });

}