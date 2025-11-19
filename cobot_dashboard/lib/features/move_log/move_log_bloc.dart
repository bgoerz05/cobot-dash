import 'package:cobot_dashboard/features/move_log/move_log_event.dart';
import 'package:cobot_dashboard/features/move_log/move_log_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveLogBloc extends Bloc<MoveLogEvent, MoveLogState> {
  MoveLogBloc() : super(MoveLogState());
}
