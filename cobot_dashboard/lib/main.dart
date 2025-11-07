import 'package:cobot_dashboard/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  // This widget is the root of your application.
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
      body: Center(),
    );
  }
}
