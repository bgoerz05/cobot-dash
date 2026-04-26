import 'dart:async';

import 'package:cobot_dashboard/features/clock/clock_event.dart';
import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/clock/clock_state.dart';
import 'package:cobot_dashboard/features/controls/control_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  late StreamSubscription<bool>? _starterListener;
  late StreamSubscription<int>? _playerSwitcher;
  late StreamSubscription? _wsListener;
  Timer? clockUpdater;

  ClockBloc() : super(ClockState()) {
    on<StartEvent>((event, emit) => _startClock(event, emit));
    on<StopEvent>((event, emit) => _stopClock(event, emit));
    on<TickWhiteEvent>((event, emit) => _tickWhite(event, emit));
    on<TickBlackEvent>((event, emit) => _tickBlack(event, emit));
    on<SwitchPlayerEvent>((event, emit) => _switchPlayer(event, emit));
    on<SyncTimeEvent>((event, emit) => _syncTime(event, emit));
    _init();
  }

  void _init() {
    _starterListener = ClockRepository
        .clockRepositoryInstance
        .clockStarterStream
        .listen((final value) {
          if (value) {
            add(StartEvent());
          } else {
            add(StopEvent());
          }
        });

    _playerSwitcher = ClockRepository.clockRepositoryInstance.playerUpdateStream
        .listen((final _) {
          add(SwitchPlayerEvent());
        });

    _wsListener = ControlRepo.controlRepoInstance.channelStream.listen((final value) {
      final msg = value.toString();
      if (msg.startsWith('clock:')) {
        final parts = msg.split(':');
        if (parts.length == 5) {
          add(SyncTimeEvent(
            whiteTimeLeft: Duration(milliseconds: int.tryParse(parts[1]) ?? 0),
            blackTimeLeft: Duration(milliseconds: int.tryParse(parts[2]) ?? 0),
            whiteToPlay: parts[3] == 'white',
            running: parts[4] == 'true',
          ));
        }
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
    clockUpdater?.cancel();
    return emit(state.copyWith(running: false));
  }

  void _tickWhite(TickWhiteEvent event, Emitter<ClockState> emit) {
    final next = state.whiteTimeLeft - const Duration(seconds: 1);
    return emit(state.copyWith(
      whiteTimeLeft: next.isNegative ? Duration.zero : next,
    ));
  }

  void _tickBlack(TickBlackEvent event, Emitter<ClockState> emit) {
    final next = state.blackTimeLeft - const Duration(seconds: 1);
    return emit(state.copyWith(
      blackTimeLeft: next.isNegative ? Duration.zero : next,
    ));
  }

  void _switchPlayer(SwitchPlayerEvent event, Emitter<ClockState> emit) {
    return emit(state.copyWith(whiteToPlay: !state.whiteToPlay));
  }

  void _syncTime(SyncTimeEvent event, Emitter<ClockState> emit) {
    // Only restart the timer when running state changes, not on every sync.
    if (event.running && !state.running) {
      clockUpdater?.cancel();
      clockUpdater = Timer.periodic(const Duration(seconds: 1), (final Timer timer) {
        if (state.whiteToPlay) {
          add(TickWhiteEvent());
        } else {
          add(TickBlackEvent());
        }
      });
    } else if (!event.running) {
      clockUpdater?.cancel();
      clockUpdater = null;
    }

    // Anti-oscillation: the bridge syncs at 1 Hz and can send a value 1 s ahead
    // of the GUI's own countdown, causing +1/-1 flicker. To prevent this, take
    // min(physical, GUI) — but ONLY for the active side (the one currently
    // counting down). The inactive side always takes the physical value so that
    // per-move time increments are applied immediately.
    // On a turn change or clock stop, snap both sides fully to the physical clock.
    final sameContext = event.running && state.running &&
        event.whiteToPlay == state.whiteToPlay;

    final Duration whiteTime;
    final Duration blackTime;
    if (!sameContext) {
      whiteTime = event.whiteTimeLeft;
      blackTime = event.blackTimeLeft;
    } else if (event.whiteToPlay) {
      // White is active: anti-oscillate white, sync black freely (may have increment).
      whiteTime = event.whiteTimeLeft < state.whiteTimeLeft
          ? event.whiteTimeLeft
          : state.whiteTimeLeft;
      blackTime = event.blackTimeLeft;
    } else {
      // Black is active: anti-oscillate black, sync white freely (may have increment).
      whiteTime = event.whiteTimeLeft;
      blackTime = event.blackTimeLeft < state.blackTimeLeft
          ? event.blackTimeLeft
          : state.blackTimeLeft;
    }

    return emit(state.copyWith(
      whiteTimeLeft: whiteTime,
      blackTimeLeft: blackTime,
      whiteToPlay: event.whiteToPlay,
      running: event.running,
    ));
  }

  @override
  Future<void> close() async {
    await _starterListener?.cancel();
    _starterListener = null;
    await _playerSwitcher?.cancel();
    _playerSwitcher = null;
    await _wsListener?.cancel();
    _wsListener = null;

    return super.close();
  }
}
