
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_wheels/wheel.dart';

// Tests the Wheel widget.
void main() {

  String selectedCharacter = '';

  final FixedExtentScrollController controller =
  FixedExtentScrollController();

  testWidgets('Wheel widget displays characters and reports their selection',
              (WidgetTester tester) async {

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
        Wheel.withTestController(
            'testKey',
            'abc',
            (character) { selectedCharacter = character;
                          print('selected character = ' + selectedCharacter ); },
            controller));

    // Verify characters are displayed on the wheel
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);
    expect(find.text('d'), findsNothing);

    // Verify characters presented in the expected order and that their selection
    // is reported correctly.
    controller.jumpToItem(1);
    expect(selectedCharacter, 'b');

    // TODO Why does this not work if it is the first item jumped to?
    controller.jumpToItem(0);
    expect(selectedCharacter, 'a');

    controller.jumpToItem(2);
    expect(selectedCharacter, 'c');

    controller.jumpToItem(0);
    expect(selectedCharacter, 'a');

  });
}
