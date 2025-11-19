import 'package:flutter/material.dart';

class MoveLogPanel extends StatelessWidget {
  const MoveLogPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: Text("Move Log")),
        body: const Placeholder(),
      ),
    );
  }
}
