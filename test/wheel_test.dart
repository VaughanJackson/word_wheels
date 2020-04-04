
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_wheels/wheel.dart';


// Tests the Wheel widget.
void main() {

  testWidgets('Wheel widget behaves as expected', (WidgetTester tester) async {

    // Build our widget and trigger a frame.
    // TODO To avoid 'Failed assertion: line 530 pos 12: 'direction != null':
    //  is not true' here had to wrap the Wheel widget under test in a
    //  Directionality element. Found this suggestion here:
    // https://github.com/flutter/flutter/issues/21266. Does this really mean
    // the Wheel widget itself should incorporate a Directionality element or
    // similar?
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Wheel('testKey', 'abc'))
    );

    // TODO Assert more than widget can be rendered without blowing up!
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
  });
}
