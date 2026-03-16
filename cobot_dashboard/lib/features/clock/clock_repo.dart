import 'dart:async';

class ClockRepository {
  static ClockRepository? _clockRepositoryInstance;
  ClockRepository._();

  static ClockRepository get clockRepositoryInstance =>
      _clockRepositoryInstance ??= ClockRepository._();

  final StreamController<bool> _clockStarter =
      StreamController<bool>.broadcast();
  Stream<bool> get clockStarterStream => _clockStarter.stream;

  final StreamController<int> _playerUpdater =
      StreamController<int>.broadcast();
  Stream<int> get playerUpdateStream => _playerUpdater.stream;

  Future<void> start() async {
    _clockStarter.add(true);
  }

  Future<void> stop() async {
    _clockStarter.add(false);
  }

  Future<void> switchPlayer() async {
    _playerUpdater.add(1);
  }

  void dispose() {
    _clockStarter.close();
    _playerUpdater.close();
  }
}
