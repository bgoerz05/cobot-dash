import 'dart:core';

import 'package:equatable/equatable.dart';

class ClockState extends Equatable {
  final bool running;
  final bool whiteToPlay;
  final Duration whiteTimeLeft;
  final Duration blackTimeLeft;

  const ClockState({
    this.running = false,
    this.whiteToPlay = true,
    this.whiteTimeLeft = const Duration(minutes: 5),
    this.blackTimeLeft = const Duration(minutes: 5),
  });

  ClockState copyWith({
    final bool? running,
    final bool? whiteToPlay,
    final Duration? whiteTimeLeft,
    final Duration? blackTimeLeft,
  }) {
    return ClockState(
      running: running ?? this.running,
      whiteToPlay: whiteToPlay ?? this.whiteToPlay,
      whiteTimeLeft: whiteTimeLeft ?? this.whiteTimeLeft,
      blackTimeLeft: blackTimeLeft ?? this.blackTimeLeft,
    );
  }

  @override
  List<Object?> get props => [
    running,
    whiteToPlay,
    whiteTimeLeft,
    blackTimeLeft,
  ];
}
