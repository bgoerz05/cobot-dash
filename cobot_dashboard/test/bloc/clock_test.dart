import 'package:bloc_test/bloc_test.dart';
import 'package:cobot_dashboard/features/clock/clock_bloc.dart';
import 'package:cobot_dashboard/features/clock/clock_event.dart';
import 'package:cobot_dashboard/features/clock/clock_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ClockBloc bloc;

  setUp(() {
    bloc = ClockBloc();
  });

  test("Initial Clock State", () {
    expect(bloc.state.running, equals(false));
    expect(bloc.state.whiteToPlay, equals(true));
    expect(bloc.state.whiteTimeLeft, equals(Duration(minutes: 5)));
    expect(bloc.state.blackTimeLeft, equals(Duration(minutes: 5)));
  });

  group("Event Tests", () {
    blocTest<ClockBloc, ClockState>(
      'Starting Clock',
      build: () => ClockBloc(),
      act: (bloc) => bloc.add(StartEvent()),
      expect: () => const <ClockState>[ClockState(running: true)],
    );

    blocTest<ClockBloc, ClockState>(
      'Stopping Clock',
      build: () => ClockBloc(),
      seed: () => ClockState(running: true),
      act: (bloc) => bloc.add(StopEvent()),
      expect: () => const <ClockState>[ClockState(running: false)],
    );

    blocTest<ClockBloc, ClockState>(
      'Ticking Players',
      build: () => ClockBloc(),
      act: (bloc) => bloc
        ..add(TickWhiteEvent())
        ..add(TickBlackEvent()),
      expect: () => const <ClockState>[
        ClockState(whiteTimeLeft: Duration(minutes: 4, seconds: 59)),
        ClockState(
          whiteTimeLeft: Duration(minutes: 4, seconds: 59),
          blackTimeLeft: Duration(minutes: 4, seconds: 59),
        ),
      ],
    );

    blocTest<ClockBloc, ClockState>(
      'Switching Players',
      build: () => ClockBloc(),
      act: (bloc) => bloc
        ..add(SwitchPlayerEvent())
        ..add(SwitchPlayerEvent()),
      expect: () => const <ClockState>[
        ClockState(whiteToPlay: false),
        ClockState(whiteToPlay: true),
      ],
    );
  });
}
