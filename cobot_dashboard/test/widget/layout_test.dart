import 'package:cobot_dashboard/features/board/board_panel.dart';
import 'package:cobot_dashboard/features/clock/clock_panel.dart';
import 'package:cobot_dashboard/features/controls/cobot_control.dart';
import 'package:cobot_dashboard/features/move_log/move_log.dart';
import 'package:cobot_dashboard/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Layout Test', (WidgetTester tester) async {
    // Expect each panel to be present
    await tester.pumpWidget(const DashboardApp());
    expect(find.byType(BoardPanel), findsOne);
    expect(find.byType(ClockPanel), findsOne);
    expect(find.byType(CobotControlPanel), findsOne);
    expect(find.byType(MoveLogPanel), findsOne);
  });
}
