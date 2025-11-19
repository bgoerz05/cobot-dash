import 'package:flutter/material.dart';

class ClockPanel extends StatelessWidget {
  const ClockPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: const Text("Game Clock")),
        body: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.yellow, width: 8),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text("5:00", style: TextStyle(fontSize: 44)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "5:00",
                  style: TextStyle(color: Colors.white, fontSize: 44),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
