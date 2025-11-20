import 'package:cobot_dashboard/features/clock/clock_event.dart';
import 'package:cobot_dashboard/features/clock/clock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(ClockState());
}
