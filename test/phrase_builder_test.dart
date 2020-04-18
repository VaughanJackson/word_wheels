import 'package:test/test.dart';
import 'package:tuple/tuple.dart';
import 'package:word_wheels/phrase_builder.dart';


// Unit tests the PhraseBuilder class.
void main() {

  test('Builds a phrase with characters ordered according to the wheel numbers, not order of addition', () {
    // TODO Use DI?
    final PhraseBuilder builder = PhraseBuilder();

    print(Tuple2<int, String>(0, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(5, '试'));
    builder.addCharacterSelection(Tuple2<int, String>(0, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(1, '语'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '考'));
    builder.addCharacterSelection(Tuple2<int, String>(2, '水'));
    builder.addCharacterSelection(Tuple2<int, String>(3, '平'));

    expect(builder.buildPhrase(), '汉语水平考试');
    
  });

}