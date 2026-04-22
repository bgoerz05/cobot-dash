import 'package:equatable/equatable.dart';

class MoveLogState extends Equatable {
  final List<String> moves;

  const MoveLogState({this.moves = const []});

  MoveLogState copyWith({final List<String>? moves}) {
    return MoveLogState(moves: moves ?? this.moves);
  }

  @override
  List<Object?> get props => [moves];
}
