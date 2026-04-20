import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/controls/control_repo.dart';
import 'package:cobot_dashboard/services/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CobotControlPanel extends StatelessWidget {
  CobotControlPanel({super.key});
  final WebSocketChannel channel = WebsocketService.channel;

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
              // Original UI Controls.
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
                  channel.sink.add('Start Game');
                },
                child: Text("Start Game"),
              ),
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.stop();
                  channel.sink.add('Stop Game');
                },
                child: Text("Stop Game"),
              ),
              TextButton(
                onPressed: () {
                  ClockRepository.clockRepositoryInstance.switchPlayer();
                },
                child: Text("Switch Player"),
              ),
              // Card for debugging Websocket
              Card(
                child: Column(
                  children: [
                    Text("FOR DEBUGGING"),
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
