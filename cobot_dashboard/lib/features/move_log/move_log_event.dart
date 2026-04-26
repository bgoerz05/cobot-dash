import 'package:equatable/equatable.dart';

class MoveLogEvent extends Equatable {
  const MoveLogEvent();

  @override
  List<Object?> get props => [];
}

class StartLogEvent extends MoveLogEvent {}

class AddMoveEvent extends MoveLogEvent {
  final String move;
  const AddMoveEvent({required this.move});

  @override
  List<Object> get props => [move];
}
