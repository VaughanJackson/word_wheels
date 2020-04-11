
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuple/tuple.dart';
import 'package:word_wheels/wheel.dart';

// Tests the Wheel widget.
void main() {

  const int tokenWheelIndex = 5;
  const a = const Tuple2(tokenWheelIndex, 'a');
  const b = const Tuple2(tokenWheelIndex, 'b');
  const c = const Tuple2(tokenWheelIndex, 'c');

  Tuple2<int, String> selection;
  final testController = FixedExtentScrollController();

  testWidgets('Wheel widget displays characters and reports their selection',
              (WidgetTester tester) async {

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
        Wheel.withTestController(
            5,
            'testKey',
            'abc',
            (character) { selection = character;
                          print('selection = ' + selection.toString() ); },
            testController));

    // Verify characters are displayed on the wheel
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);
    expect(find.text('d'), findsNothing);

    // Verify characters presented in the expected order and that their selection
    // is reported correctly.
    testController.jumpToItem(1);
    expect(selection, b);

    // TODO Why does this not work if it is the first item jumped to?
    testController.jumpToItem(0);
    expect(selection, a);

    testController.jumpToItem(2);
    expect(selection, c);

    testController.jumpToItem(0);
    expect(selection, a);

  });
}
