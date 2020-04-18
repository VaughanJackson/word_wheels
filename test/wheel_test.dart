import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuple/tuple.dart';
import 'package:word_wheels/wheel.dart';

// Tests the Wheel widget.
void main() {

  // The delay currently configured within the Governor.
  const delay = Duration(milliseconds: 100);

  const int tokenWheelIndex = 5;
  const a = const Tuple2(tokenWheelIndex, 'a');
  const b = const Tuple2(tokenWheelIndex, 'b');
  const c = const Tuple2(tokenWheelIndex, 'c');

  Tuple2<int, String> selection;
  final testController = FixedExtentScrollController();

  // Jumps to item indicated by index and expects the selection specified.
  // TODO IDE warns us that the await used to invoke and wait on this method
  // means this method really should return a future?
  void expectScrollToSelects(final WidgetTester tester,
                             final int selectionIndex,
                             final Tuple2<int, String> expectedSelection) async {
    await tester.runAsync(() async {
      testController.jumpToItem(selectionIndex);
      await Future.delayed(delay, (){});
      expect(selection, expectedSelection);
    });
  }

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
    await expectScrollToSelects(tester, 1, b);

    // TODO Why does index 0 not work if it is the first item jumped to?
    await expectScrollToSelects(tester, 0, a);
    await expectScrollToSelects(tester, 2, c);
    await expectScrollToSelects(tester, 0, a);

  });

}
