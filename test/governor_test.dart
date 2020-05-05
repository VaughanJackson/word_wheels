import 'package:test/test.dart';
import 'package:word_wheels/governor.dart';
import 'test_module_container.dart';

// Unit tests the Governor class.
void main() {

  // The delay currently configured within the Governor.
  const delay = Duration(milliseconds: 100);

  // Delay only slightly shorter than that configured in the Governor.
  // Seems accurate at least down to 1ms. Not tested beyond that.
  const less_than_delay = Duration(milliseconds: 99);

  // TODO Are these tests actually made more effective by using async and await,
  // or just more complex? Experimenting with async coding here. May be
  // inappropriate given that the code called does not currently return
  // future?
  test('Reports the only character selected', () async {
    final Governor governor = injector.get<Governor>(additionalParameters: { "_onCharacterSelected" : (character) {
      print('checking character is 汉');
      expect(character, '汉');
    }});

    governor.onCharacterSelected('汉');
    await Future.delayed(delay, (){});

  });

  test('Reports the last character selected in a quick fire sequence',
          () async {
    final Governor governor = injector.get<Governor>(additionalParameters: { "_onCharacterSelected" : (character) {
      print('checking character is 试');
      expect(character, '试');
    }});

    governor.onCharacterSelected('汉');
    governor.onCharacterSelected('语');
    governor.onCharacterSelected('水');
    governor.onCharacterSelected('平');
    governor.onCharacterSelected('考');
    governor.onCharacterSelected('试');
    await Future.delayed(delay, (){});

  });

  test('Reports any character selected that remains so for at least delay',
          () async {

    final List<String> expectedCharacters = ['汉', '水', '考'];

    final Governor governor = injector.get<Governor>(additionalParameters: { "_onCharacterSelected" : (character) {
      print('checking character ' + character + ' is in ' +
          expectedCharacters.toString());
      expect(expectedCharacters.contains(character), true);
      expectedCharacters.remove(character);
    }});

    governor.onCharacterSelected('汉');
    await Future.delayed(delay, (){});
    governor.onCharacterSelected('语');
    governor.onCharacterSelected('水');
    await Future.delayed(delay, (){});
    governor.onCharacterSelected('平');
    governor.onCharacterSelected('考');
    await Future.delayed(delay, (){});
    governor.onCharacterSelected('试');

    expect(expectedCharacters.isEmpty, true);

  });

  test('Does not report any character selected that remains so for less than delay',
          () async {

    final List<String> expectedCharacters = ['汉'];

    final Governor governor = injector.get<Governor>(additionalParameters: { "_onCharacterSelected" : (character) {
      print('checking character ' + character + ' is in ' +
          expectedCharacters.toString());
      expect(expectedCharacters.contains(character), true);
      expectedCharacters.remove(character);
    }});

    governor.onCharacterSelected('汉');
    await Future.delayed(delay, (){});
    governor.onCharacterSelected('语');
    governor.onCharacterSelected('水');
    await Future.delayed(less_than_delay, (){});
    governor.onCharacterSelected('平');
    governor.onCharacterSelected('考');
    await Future.delayed(less_than_delay, (){});
    governor.onCharacterSelected('试');

    expect(expectedCharacters.isEmpty, true);

  });

}