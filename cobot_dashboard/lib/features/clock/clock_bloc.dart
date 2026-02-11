import 'dart:async';

import 'package:cobot_dashboard/features/clock/clock_event.dart';
import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/clock/clock_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  late StreamSubscription<bool>? _statusListener;
  Timer? clockUpdater;

  ClockBloc() : super(ClockState()) {
    on<StartEvent>((event, emit) => _startClock(event, emit));
    on<StopEvent>((event, emit) => _stopClock(event, emit));
    on<TickWhiteEvent>((event, emit) => _tickWhite(event, emit));
    on<TickBlackEvent>((event, emit) => _tickBlack(event, emit));
    _init();
  }

  void _init() {
    _statusListener = ClockRepository.clockRepositoryInstance.statusStream
        .listen((final value) {
          if (value) {
            add(StartEvent());
          } else {
            add(StopEvent());
          }
        });
  }

  void _startClock(StartEvent event, Emitter<ClockState> emit) {
    clockUpdater = Timer.periodic(const Duration(seconds: 1), (
      final Timer timer,
    ) {
      if (state.whiteToPlay) {
        add(TickWhiteEvent());
      } else {
        add(TickBlackEvent());
      }
    });
    return emit(state.copyWith(running: true));
  }

  void _stopClock(StopEvent event, Emitter<ClockState> emit) {
    clockUpdater?.cancel;
    return emit(state.copyWith(running: false));
  }

  @override
  Future<void> close() async {
    await _statusListener?.cancel();
    _statusListener = null;

    return super.close();
  }

  void _tickWhite(TickWhiteEvent event, Emitter<ClockState> emit) {
    return emit(
      state.copyWith(whiteTimeLeft: state.whiteTimeLeft - Duration(seconds: 1)),
    );
  }

  void _tickBlack(TickBlackEvent event, Emitter<ClockState> emit) {
    return emit(
      state.copyWith(blackTimeLeft: state.blackTimeLeft - Duration(seconds: 1)),
    );
  }
}
