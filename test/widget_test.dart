import 'package:flutter_test/flutter_test.dart';

import 'package:state_management_counter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}