// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Word Wheels App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('starts game', () async {
      final kaishi = find.byValueKey("开始！");

      await driver.tap(kaishi);
    });

    test('test wheel1', () async {
      final wheel1 = find.byValueKey('wheel1');

      await driver.tap(wheel1);
    });

    scrollWheelToCharacter(
        final FlutterDriver driver,
        final String wheelKey,
        final String characterSought) async {
      // Create two SerializableFinders and use these to locate specific
      // widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys provided to the widgets in step 1.
      final wheel = find.byValueKey(wheelKey);
      final character = find.byValueKey('$wheelKey.$characterSought');

      await driver.scrollUntilVisible(
        // Scroll through the list
        wheel,
        // Until finding this item
        character,
        // To scroll down the list, provide a negative value to dyScroll.
        // Ensure that this value is a small enough increment to
        // scroll the item into view without potentially scrolling past it.
        //
        // To scroll through horizontal lists, provide a dxScroll
        // property instead.
        dyScroll: -10.0,
      );

      // Verify that the item contains the correct text.
      final text = find.byValueKey('$wheelKey.$characterSought.text');
      expect(
        await driver.getText(text),
        characterSought,
      );
    }

    test('Verify can scroll first wheel to last character', () async {
      await scrollWheelToCharacter(driver, 'wheel1', '里');
    });

    test('Verify can scroll second wheel to last character', () async {
      await scrollWheelToCharacter(driver, 'wheel2', '里');
    });

    test('Verify can scroll third wheel to last character', () async {
      await scrollWheelToCharacter(driver, 'wheel3', '里');
    });

  });

}
