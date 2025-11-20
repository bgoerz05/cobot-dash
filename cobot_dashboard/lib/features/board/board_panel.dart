import 'dart:math';

import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';

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
              return Chessboard.fixed(
                size: min(constraints.maxHeight, constraints.maxWidth),
                orientation: Side.white,
                fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR',
              );
            },
          ),
        ),
      ),
    );
  }
}
