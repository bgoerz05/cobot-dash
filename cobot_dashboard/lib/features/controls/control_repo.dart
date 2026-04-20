import 'dart:async';

import 'package:cobot_dashboard/services/websocket_service.dart';

class ControlRepo {
  late StreamSubscription? _socketListener;

  static ControlRepo? _controlRepoInstance;
  ControlRepo._() {
    _socketListener = WebsocketService.channel.stream.listen((final value) {
      addData(value);
    });
  }

  static ControlRepo get controlRepoInstance =>
      _controlRepoInstance ??= ControlRepo._();

  final StreamController _channel = StreamController.broadcast();
  Stream get channelStream => _channel.stream;

  Future<void> addData(dynamic data) async {
    _channel.add(data);
  }

  Future<void> dispose() async {
    _channel.close();

    await _socketListener?.cancel();
    _socketListener = null;
  }
}
