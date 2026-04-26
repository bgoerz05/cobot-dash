import 'package:cobot_dashboard/features/home.dart';
import 'package:cobot_dashboard/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.loggerName}: ${record.message}');
    }
  });

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
