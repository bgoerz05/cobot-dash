import 'package:cobot_dashboard/features/clock/clock_bloc.dart';
import 'package:cobot_dashboard/features/clock/clock_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockPanel extends StatelessWidget {
  const ClockPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: const Text("Game Clock")),
        body: BlocProvider(
          create: (context) => ClockBloc(),
          child: BlocBuilder<ClockBloc, ClockState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: Colors.yellow, width: 8),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          getFormattedTime(state.whiteTimeLeft),
                          style: TextStyle(fontSize: 44),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        getFormattedTime(state.blackTimeLeft),
                        style: TextStyle(color: Colors.white, fontSize: 44),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String getFormattedTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    if (seconds < 10) {
      return "$minutes:0$seconds";
    } else {
      return "$minutes:$seconds";
    }
  }
}
