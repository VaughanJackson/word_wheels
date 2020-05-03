import 'package:test/test.dart';
import 'package:tuple/tuple.dart';
import 'package:word_wheels/phrase_builder.dart';
import 'test_module_container.dart';

// Unit tests the PhraseBuilder class.
void main() {

  test('Builds a phrase with characters ordered according to the wheel numbers, not order of addition', () {

    final PhraseBuilder builder = injector.get<PhraseBuilder>();

    builder.addCharacterSelection(Tuple2<int, String>(5, '试'));
    builder.addCharacterSelection(Tuple2<int, String>(0, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(1, '语'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '考'));
    builder.addCharacterSelection(Tuple2<int, String>(2, '水'));
    builder.addCharacterSelection(Tuple2<int, String>(3, '平'));

    expect(builder.buildPhrase(), '汉语水平考试');
    
  });

  test('Building a phrase multiple times does not reset phrase', () {

    final PhraseBuilder builder = injector.get<PhraseBuilder>();

    builder.addCharacterSelection(Tuple2<int, String>(5, '试'));
    builder.addCharacterSelection(Tuple2<int, String>(0, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(1, '语'));
    expect(builder.buildPhrase(), '汉语试');
    builder.addCharacterSelection(Tuple2<int, String>(4, '考'));
    builder.addCharacterSelection(Tuple2<int, String>(2, '水'));
    builder.addCharacterSelection(Tuple2<int, String>(3, '平'));

    expect(builder.buildPhrase(), '汉语水平考试');

  });

  test('Latest character for a selection (ie wheel)  is that seen in phrase', () {

    final PhraseBuilder builder = injector.get<PhraseBuilder>();

    builder.addCharacterSelection(Tuple2<int, String>(5, '试'));
    expect(builder.buildPhrase(), '试');
    builder.addCharacterSelection(Tuple2<int, String>(5, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(5, '语'));
    expect(builder.buildPhrase(), '语');

  });

}