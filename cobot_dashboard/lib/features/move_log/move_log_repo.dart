import 'dart:async';

import 'package:dartchess/dartchess.dart';

class MoveLogRepository {
  static MoveLogRepository? _moveLogRepositoryInstance;
  MoveLogRepository._();

  static MoveLogRepository get moveLogRepoInstance =>
      _moveLogRepositoryInstance ??= MoveLogRepository._();

  final StreamController<String> _newMoves = StreamController<String>.broadcast();
  Stream<String> get newMoveStream => _newMoves.stream;

  Future<void> addMove(String move) async {
    _newMoves.add(move);
  }

  void dispose() {
    _newMoves.close();
  }
}
