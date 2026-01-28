import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/home.dart';
import 'package:cobot_dashboard/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: RepositoryProvider(
        create: (context) => ClockRepository(),
        dispose: (repo) => repo.dispose(),
        child: const DashHomePage(title: 'Dashboard'),
      ),
    );
  }
}
