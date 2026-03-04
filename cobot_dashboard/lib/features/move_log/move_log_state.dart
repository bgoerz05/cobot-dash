import 'package:equatable/equatable.dart';

class MoveLogState extends Equatable {
  final String moves;

  const MoveLogState({this.moves = ''});

  MoveLogState copyWith({final String? moves}) {
    return MoveLogState(moves: moves ?? this.moves);
  }

  @override
  List<Object?> get props => [moves];
}
