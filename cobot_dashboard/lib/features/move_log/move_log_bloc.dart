import 'dart:async';

import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/move_log/move_log_event.dart';
import 'package:cobot_dashboard/features/move_log/move_log_repo.dart';
import 'package:cobot_dashboard/features/move_log/move_log_state.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveLogBloc extends Bloc<MoveLogEvent, MoveLogState> {
  late StreamSubscription<bool>? _starterListener;
  late StreamSubscription<Move>? _moveListener;

  MoveLogBloc() : super(MoveLogState()) {
    on<StartLogEvent>((event, emit) => _clearLog(event, emit));
    on<AddMoveEvent>((event, emit) => _addMove(event, emit));

    _init();
  }

  void _init() {
    _starterListener = ClockRepository
        .clockRepositoryInstance
        .clockStarterStream
        .listen((final value) {
          if (value) {
            add(StartLogEvent());
          }
        });

    _moveListener = MoveLogRepository.moveLogRepoInstance.newMoveStream.listen((
      final value,
    ) {
      add(AddMoveEvent(move: value));
    });
  }

  void _clearLog(event, emit) {
    emit(state.copyWith(moves: ''));
  }

  void _addMove(event, emit) {
    String moves = state.moves;
    moves += event.move.uci + " ";
    emit(state.copyWith(moves: moves));
  }

  @override
  Future<void> close() async {
    await _starterListener?.cancel();
    _starterListener = null;
    await _moveListener?.cancel();
    _moveListener = null;

    return super.close();
  }
}
