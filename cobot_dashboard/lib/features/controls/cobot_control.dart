import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:flutter/material.dart';

class CobotControlPanel extends StatelessWidget {
  const CobotControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(title: Text("Cobot Control Panel")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Replaced for testing without cobot.
              /*
              Text("Cobot Arm Toggling"),
              Row(
                children: [
                  TextButton(onPressed: () {}, child: Text("Toggle Cobot 0")),
                  TextButton(onPressed: () {}, child: Text("Toggle Cobot 1")),
                  TextButton(onPressed: () {}, child: Text("Regret Move")),
                ],
              ),
              Text("Set Arm Speed"),
              Row(
                children: [
                  Text("Cobot 0 Speed"),
                  Slider(value: 0.5, onChanged: (_) {}),
                ],
              ),
              Row(
                children: [
                  Text("Cobot 1 Speed"),
                  Slider(value: 0.5, onChanged: (_) {}),
                ],
              ), 
              */
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.start();
                },
                child: Text("Start Clock"),
              ),
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.stop();
                },
                child: Text("Stop Clock"),
              ),
              TextButton(onPressed: () {}, child: Text("Switch Player")),
            ],
          ),
        ),
      ),
    );
  }
}
