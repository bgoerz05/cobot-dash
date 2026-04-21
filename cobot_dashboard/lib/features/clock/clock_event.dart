import 'package:equatable/equatable.dart';

class ClockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartEvent extends ClockEvent {}

class StopEvent extends ClockEvent {}

class TickWhiteEvent extends ClockEvent {}

class TickBlackEvent extends ClockEvent {}

class SwitchPlayerEvent extends ClockEvent {}

class SyncTimeEvent extends ClockEvent {
  final Duration whiteTimeLeft;
  final Duration blackTimeLeft;
  final bool whiteToPlay;
  final bool running;

  SyncTimeEvent({
    required this.whiteTimeLeft,
    required this.blackTimeLeft,
    required this.whiteToPlay,
    required this.running,
  });

  @override
  List<Object?> get props => [whiteTimeLeft, blackTimeLeft, whiteToPlay, running];
}
