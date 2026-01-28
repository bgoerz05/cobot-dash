import 'dart:async';

enum Player { white, black }

class ClockRepository {
  final _statusController = StreamController<bool>();

  Future<void> start() async {
    _statusController.add(true);
  }

  Future<void> stop() async {
    _statusController.add(false);
  }

  void dispose() => _statusController.close();
}
