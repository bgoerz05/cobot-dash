import 'package:cobot_dashboard/features/move_log/move_log_bloc.dart';
import 'package:cobot_dashboard/features/move_log/move_log_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveLogPanel extends StatelessWidget {
  const MoveLogPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: const Text("Move Log")),
        body: BlocProvider(
          create: (context) => MoveLogBloc(),
          child: BlocBuilder<MoveLogBloc, MoveLogState>(
            builder: (context, state) {
              return Text(state.moves, style: TextStyle(color: Colors.white));
            },
          ),
        ),
      ),
    );
  }
}
