import 'dart:async';

import 'package:cobot_dashboard/features/board/board_event.dart';
import 'package:cobot_dashboard/features/board/board_state.dart';
import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  late StreamSubscription<bool>? _starterListener;

  BoardBloc() : super(BoardState()) {
    on<MoveEvent>((event, emit) => _playMove(event, emit));
    on<CheckMovesEvent>((event, emit) => _checkMoves(event, emit));
    on<StartBoardEvent>((event, emit) => _startGame(event, emit));

    _init();
  }

  void _init() {
    _starterListener = ClockRepository
        .clockRepositoryInstance
        .clockStarterStream
        .listen((final value) {
          if (value) {
            add(StartBoardEvent());
          }
        });
  }

  void _checkMoves(CheckMovesEvent event, Emitter<BoardState> emit) {
    emit(state.copyWith(validMoves: makeLegalMoves(state.position)));
  }

  void _playMove(MoveEvent event, Emitter<BoardState> emit) {
    Position newPosition = state.position.play(event.move);
    ClockRepository.clockRepositoryInstance.switchPlayer();
    emit(
      state.copyWith(
        position: newPosition,
        fen: newPosition.fen,
        validMoves: makeLegalMoves(newPosition),
        sideToPlay: state.sideToPlay == Side.white ? Side.black : Side.white,
      ),
    );
  }

  void _startGame(StartBoardEvent event, Emitter<BoardState> emit) {
    emit(
      state.copyWith(
        active: true,
        position: Chess.initial,
        fen: Chess.initial.fen,
        sideToPlay: Side.white,
        validMoves: makeLegalMoves(Chess.initial),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _starterListener?.cancel();
    _starterListener = null;

    return super.close();
  }
}
