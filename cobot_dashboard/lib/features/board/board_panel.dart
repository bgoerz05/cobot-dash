import 'dart:math';

import 'package:chessground/chessground.dart';
import 'package:cobot_dashboard/features/board/board_bloc.dart';
import 'package:cobot_dashboard/features/board/board_event.dart';
import 'package:cobot_dashboard/features/board/board_state.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardPanel extends StatelessWidget {
  const BoardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(title: Text("Game Board")),
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BlocProvider(
                create: (context) => BoardBloc(),
                child: BlocBuilder<BoardBloc, BoardState>(
                  builder: (context, state) {
                    return Chessboard(
                      size: min(constraints.maxHeight, constraints.maxWidth),
                      orientation: Side.white,
                      fen: state.fen,
                      game: GameData(
                        playerSide: PlayerSide.both,
                        sideToMove: state.sideToPlay,
                        validMoves: state.validMoves,
                        promotionMove: state.promotionMove,
                        onMove: (NormalMove move, {bool? isDrop}) => context
                            .read<BoardBloc>()
                            .add(MoveEvent(move: move)),
                        onPromotionSelection: (_) {},
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
