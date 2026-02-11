import 'package:cobot_dashboard/features/home.dart';
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
