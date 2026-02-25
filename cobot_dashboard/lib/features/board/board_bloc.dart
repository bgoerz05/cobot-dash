import 'package:cobot_dashboard/features/board/board_event.dart';
import 'package:cobot_dashboard/features/board/board_state.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState()) {
    on<MoveEvent>((event, emit) => _playMove(event, emit));
    on<CheckMovesEvent>((event, emit) => _checkMoves(event, emit));
    on<StartBoardEvent>((event, emit) => _startGame(event, emit));

    _init();
  }

  void _init() {
    add(CheckMovesEvent());
  }

  void _checkMoves(CheckMovesEvent event, Emitter<BoardState> emit) {
    emit(state.copyWith(validMoves: makeLegalMoves(state.position)));
  }

  void _playMove(MoveEvent event, Emitter<BoardState> emit) {
    Position newPosition = state.position.play(event.move);
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
}
