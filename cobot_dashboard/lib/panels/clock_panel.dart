import 'package:flutter/material.dart';

class ClockPanel extends StatelessWidget {
  const ClockPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: const Text("Game Clock")),
        body: const Placeholder(),
      ),
    );
  }
}
