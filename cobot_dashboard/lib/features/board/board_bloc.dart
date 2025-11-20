import 'package:cobot_dashboard/features/board/board_event.dart';
import 'package:cobot_dashboard/features/board/board_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState());
}
