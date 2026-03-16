import 'dart:async';

import 'package:dartchess/dartchess.dart';

class MoveLogRepository {
  static MoveLogRepository? _moveLogRepositoryInstance;
  MoveLogRepository._();

  static MoveLogRepository get moveLogRepoInstance =>
      _moveLogRepositoryInstance ??= MoveLogRepository._();

  final StreamController<Move> _newMoves = StreamController<Move>.broadcast();
  Stream<Move> get newMoveStream => _newMoves.stream;

  Future<void> addMove(Move move) async {
    _newMoves.add(move);
  }

  void dispose() {
    _newMoves.close();
  }
}
