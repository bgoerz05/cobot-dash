import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/controls/control_repo.dart';
import 'package:cobot_dashboard/services/websocket_service.dart';
import 'package:flutter/material.dart';

class CobotControlPanel extends StatelessWidget {
  const CobotControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(title: Text("Control Panel")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.start();
                  WebsocketService.send('Start Game');
                },
                child: Text("Start Game"),
              ),
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.stop();
                  WebsocketService.send('Stop Game');
                },
                child: Text("Stop Game"),
              ),
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.switchPlayer();
                },
                child: Text("Switch Player"),
              ),
              Card(
                child: Column(
                  children: [
                    Text("FOR DEBUGGING"),
                    TextField(
                      onSubmitted: (value) => WebsocketService.send(value),
                      decoration: InputDecoration(
                        labelText: 'Send to Channel.',
                      ),
                    ),
                    Row(
                      children: [
                        Text('Websocket Response: '),
                        StreamBuilder(
                          stream: ControlRepo.controlRepoInstance.channelStream,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.hasData ? '${snapshot.data}' : '',
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
