import 'package:cobot_dashboard/panels/board_panel.dart';
import 'package:cobot_dashboard/panels/clock_panel.dart';
import 'package:cobot_dashboard/panels/cobot_control.dart';
import 'package:cobot_dashboard/panels/move_log.dart';
import 'package:cobot_dashboard/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobot Control',
      theme: dashTheme,
      home: const DashHomePage(title: 'Dashboard'),
    );
  }
}

class DashHomePage extends StatelessWidget {
  const DashHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // body: GridView.count(
      //   crossAxisCount: 2,
      //   children: [
      //     BoardPanel(),
      //     CobotControlPanel(),
      //     MoveLogPanel(),
      //     ClockPanel(),
      //   ],
      // ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 2, child: BoardPanel()),
                Expanded(flex: 1, child: MoveLogPanel()),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 2, child: CobotControlPanel()),
                Expanded(flex: 1, child: ClockPanel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
