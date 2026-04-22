import 'package:equatable/equatable.dart';

class MoveLogState extends Equatable {
  final Set<String> moves;

  const MoveLogState({this.moves = const {}});

  MoveLogState copyWith({final Set<String>? moves}) {
    return MoveLogState(moves: moves ?? this.moves);
  }

  @override
  List<Object?> get props => [moves];
}
