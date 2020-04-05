import 'package:flutter_test/flutter_test.dart';
import 'package:word_wheels/wheels.dart';

// Tests the Wheels widget.
void main() {
  testWidgets('Wheels widget behaves as expected', (WidgetTester tester) async {

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
        Wheels([
          '你的中文在这里',
          '我的中文在这里',
          '她的中文在这里'
        ])
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
