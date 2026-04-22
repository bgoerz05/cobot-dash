import 'package:flutter/material.dart';
import 'package:cobot_dashboard/features/board/board_panel.dart';
import 'package:cobot_dashboard/features/clock/clock_panel.dart';
import 'package:cobot_dashboard/features/controls/cobot_control.dart';
import 'package:cobot_dashboard/features/move_log/move_log.dart';

class DashHomePage extends StatelessWidget {
  const DashHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 2, child: BoardPanel()),
                Expanded(flex: 1, child: CobotControlPanel()),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 2, child: MoveLogPanel()),
                Expanded(flex: 1, child: ClockPanel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
