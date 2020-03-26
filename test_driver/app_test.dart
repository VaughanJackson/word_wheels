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
      // final kaishi = find.text('开始！'); // TODO not I18n compatible
      final kaishi = find.byValueKey("开始！");

      await driver.tap(kaishi);

    });

    test('test wheel1', () async {
      final wheel1 = find.byValueKey("wheel1");

      await driver.tap(wheel1);

    });

//    test('test wheel1.你', () async {
//      final ni1 = find.byValueKey("wheel1.你");
//
//      await driver.tap(ni1);
//
//    });

    test('verifies wheels contain a specific item', () async {
      // Create two SerializableFinders and use these to locate specific
      // widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys provided to the widgets in step 1.
//      final wheelsFinder = find.byValueKey('wheels');
      final wheel1 = find.byValueKey("wheel1");
//      final wheel1 = find.byType('CupertinoPicker');
//      final wheel2Finder = find.byValueKey('wheel2');
//      final wheel3Finder = find.byValueKey('wheel3');
//      final wheel4Finder = find.byValueKey('wheel4');
//      final wheel5Finder = find.byValueKey('wheel5');

//      final ni1 = find.byValueKey('你');
//      final hao1 = find.byValueKey('好');
//      final ma1 = find.byValueKey('吗');
//      final ni1 = find.byValueKey("wheel1.你");
      final q = find.byValueKey("wheel1.?");


      await driver.scrollUntilVisible(
        // Scroll through the list
        wheel1,
        // Until finding this item
        q,
        // To scroll down the list, provide a negative value to dyScroll.
        // Ensure that this value is a small enough increment to
        // scroll the item into view without potentially scrolling past it.
        //
        // To scroll through horizontal lists, provide a dxScroll
        // property instead.
        dyScroll: 10.0,
      );

      // Verify that the item contains the correct text.
      final text = find.byValueKey('wheel1.?.text');
      expect(
        await driver.getText(text),
        '?',
      );
    });
  });
}
