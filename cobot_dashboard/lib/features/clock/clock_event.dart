import 'package:equatable/equatable.dart';

class ClockEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartEvent extends ClockEvent {}

class StopEvent extends ClockEvent {}

class TickWhiteEvent extends ClockEvent {}

class TickBlackEvent extends ClockEvent {}
