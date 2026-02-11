import 'dart:async';

class ClockRepository {
  static ClockRepository? _clockRepositoryInstance;
  ClockRepository._();

  static ClockRepository get clockRepositoryInstance =>
      _clockRepositoryInstance ??= ClockRepository._();

  final StreamController<bool> _statusController =
      StreamController<bool>.broadcast();
  Stream<bool> get statusStream => _statusController.stream;

  Future<void> start() async {
    _statusController.add(true);
  }

  Future<void> stop() async {
    _statusController.add(false);
  }

  void dispose() => _statusController.close();
}
