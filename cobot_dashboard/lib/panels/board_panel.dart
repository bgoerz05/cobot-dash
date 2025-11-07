import 'package:flutter/material.dart';

class BoardPanel extends StatelessWidget {
  const BoardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: Text("Game Board")),
        body: const Placeholder(),
      ),
    );
  }
}
