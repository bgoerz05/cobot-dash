import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class BoardState extends Equatable {
  final Position position;
  final String fen;
  final ValidMoves validMoves;
  final NormalMove? promotionMove;
  final Side sideToPlay;
  const BoardState({
    this.position = Chess.initial,
    this.fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR',
    this.validMoves = const IMap.empty(),
    this.promotionMove,
    this.sideToPlay = Side.white,
  });

  BoardState copyWith({
    final Position? position,
    final String? fen,
    final ValidMoves? validMoves,
    final NormalMove? promotionMove,
    final Side? sideToPlay,
  }) {
    return BoardState(
      position: position ?? this.position,
      fen: fen ?? this.fen,
      validMoves: validMoves ?? this.validMoves,
      promotionMove: promotionMove ?? this.promotionMove,
      sideToPlay: sideToPlay ?? this.sideToPlay,
    );
  }

  @override
  List<Object?> get props => [
    position,
    fen,
    validMoves,
    promotionMove,
    sideToPlay,
  ];
}
