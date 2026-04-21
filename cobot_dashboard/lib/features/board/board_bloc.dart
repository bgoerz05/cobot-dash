import 'dart:async';

import 'package:cobot_dashboard/features/board/board_event.dart';
import 'package:cobot_dashboard/features/board/board_state.dart';
import 'package:cobot_dashboard/features/clock/clock_repo.dart';
import 'package:cobot_dashboard/features/controls/control_repo.dart';
import 'package:cobot_dashboard/features/move_log/move_log_repo.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final log = Logger('Board Bloc');

  late StreamSubscription<bool>? _starterListener;
  late StreamSubscription? _socketListener;

  RegExp fenDetector = RegExp(
    r'\w{1,8}/\w{1,8}/\w{1,8}/\w{1,8}/\w{1,8}/\w{1,8}/\w{1,8}/\w{1,8}',
  );

  BoardBloc() : super(BoardState()) {
    on<MoveEvent>((event, emit) => _playMove(event, emit));
    on<CheckMovesEvent>((event, emit) => _checkMoves(event, emit));
    on<StartBoardEvent>((event, emit) => _startGame(event, emit));
    on<FenEvent>((event, emit) => _updateFen(event, emit));

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

    _socketListener = ControlRepo.controlRepoInstance.channelStream.listen((
      final value,
    ) {
      final msg = value.toString();
      if (fenDetector.hasMatch(msg)) {
        log.fine('[BoardBloc] FEN detected, adding FenEvent: ${msg.substring(0, msg.length.clamp(0, 40))}...');
        add(FenEvent(fen: msg));
      }
    });
  }

  void _checkMoves(CheckMovesEvent event, Emitter<BoardState> emit) {
    emit(state.copyWith(validMoves: makeLegalMoves(state.position)));
  }

  void _playMove(MoveEvent event, Emitter<BoardState> emit) {
    Position newPosition = state.position.play(event.move);
    ClockRepository.clockRepositoryInstance.switchPlayer();
    MoveLogRepository.moveLogRepoInstance.addMove(event.move);
    emit(
      state.copyWith(
        position: newPosition,
        fen: newPosition.fen.split(' ').first,
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
        fen: Chess.initial.fen.split(' ').first,
        sideToPlay: Side.white,
        validMoves: makeLegalMoves(Chess.initial),
      ),
    );
    log.info('Game started');
  }

  void _updateFen(FenEvent event, Emitter<BoardState> emit) {
    log.fine('_updateFen called with: ${event.fen.substring(0, event.fen.length.clamp(0, 50))}');
    try {
      final setup = Setup.parseFen(event.fen);
      log.fine('Setup parsed OK, turn=${setup.turn}');
      final newPosition = Chess.fromSetup(setup);
      log.fine('Position created OK, emitting state');
      final boardFen = event.fen.split(' ').first;
      emit(state.copyWith(position: newPosition, fen: boardFen));
      log.fine('State emitted with boardFen: $boardFen');
    } catch (e, st) {
      log.shout('ERROR in _updateFen: $e\n$st');
    }
  }

  @override
  Future<void> close() async {
    await _starterListener?.cancel();
    _starterListener = null;
    await _socketListener?.cancel();
    _socketListener = null;

    return super.close();
  }
}
