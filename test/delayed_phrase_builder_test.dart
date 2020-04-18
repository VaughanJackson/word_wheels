
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';
import 'package:word_wheels/delayed_phrase_builder.dart';

// Unit tests the DelayedPhraseBuilder class.
void main() {

  const delay = Duration(milliseconds: 100);

  // TODO Are these tests actually made more effective by using async and await,
  // or just more complex?

  // NB experimenting with async coding here. May be inappropriate given that the code called
  // does not currently return a future.
  // The main difficulty right now I think is this test does NOT wait on the DelayedPhraseBuilder
  // callback.
  test('Builds a phrase with characters ordered according to the wheel numbers', () async {
    // TODO Use DI?
    final builder = DelayedPhraseBuilder((phrase) {
      print('checking phrase is 汉语水平考试');
      expect(phrase, '汉语水平考试');
    });

    print(Tuple2<int, String>(0, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(0, '汉'));
    //sleep(delay);
//    print('delay 0.1 seconds');
//    await Future.delayed(delay, (){ print('end');});
    builder.addCharacterSelection(Tuple2<int, String>(1, '语'));
    print('delay 0.1 seconds');
    await Future.delayed(delay, (){});
    builder.addCharacterSelection(Tuple2<int, String>(2, '水'));
    print('delay 0.1 seconds');
    await Future.delayed(delay, (){});
    builder.addCharacterSelection(Tuple2<int, String>(3, '平'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '考'));
    builder.addCharacterSelection(Tuple2<int, String>(5, '试'));

    print('delay 2 seconds');
    await Future.delayed(const Duration(seconds: 2), (){});

  });

  test('Builds a phrase of the last character for selections for a single wheeel', () async {
    // TODO Use DI?
    final builder = DelayedPhraseBuilder((phrase) {
      print('checking phrase is 试');
      expect(phrase, '试');
    });

    builder.addCharacterSelection(Tuple2<int, String>(4, '汉'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '语'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '水'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '平'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '考'));
    builder.addCharacterSelection(Tuple2<int, String>(4, '试'));

    print('delay 2 seconds');
    await Future.delayed(const Duration(seconds: 2), (){});
    print('delay elapsed');

  });

}