import 'package:cobot_dashboard/features/clock/clock_event.dart';
import 'package:cobot_dashboard/features/clock/clock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(ClockState()) {
    on<StartEvent>((event, emit) => _startClock(event, emit));
    on<StopEvent>((event, emit) => _stopClock(event, emit));
    _init();
  }

  void _init() {}

  void _startClock(StartEvent event, Emitter<ClockState> emit) {
    return emit(state.copyWith(running: true));
  }

  void _stopClock(StopEvent event, Emitter<ClockState> emit) {
    return emit(state.copyWith(running: false));
  }
}
