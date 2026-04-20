import 'package:dartchess/dartchess.dart';
import 'package:equatable/equatable.dart';

class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class CheckMovesEvent extends BoardEvent {}

class StartBoardEvent extends BoardEvent {}

class MoveEvent extends BoardEvent {
  final Move move;
  const MoveEvent({required this.move});

  @override
  List<Object> get props => [move];
}

class FenEvent extends BoardEvent {
  final String fen;
  const FenEvent({required this.fen});

  @override
  List<Object> get props => [fen];
}
