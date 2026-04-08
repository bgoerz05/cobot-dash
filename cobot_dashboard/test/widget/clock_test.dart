import 'package:cobot_dashboard/features/clock/clock_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Widget widget;

  setUp(() {
    widget = MaterialApp(home: Scaffold(body: ClockPanel()));
  });
  testWidgets('Clock Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    // Expect both clocks to read 5:00 by default.
    expect(find.text("5:00"), findsExactly(2));
  });
}
