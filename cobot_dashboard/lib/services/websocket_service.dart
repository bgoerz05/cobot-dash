import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  static const String _url = 'ws://localhost:8080';
  static const Duration _reconnectDelay = Duration(seconds: 3);

  static final StreamController<dynamic> _controller =
      StreamController.broadcast();

  static WebSocketChannel? _channel;
  static bool _started = false;

  static Stream<dynamic> get stream {
    if (!_started) {
      _started = true;
      _connectLoop();
    }
    return _controller.stream;
  }

  static void send(dynamic message) {
    _channel?.sink.add(message);
  }

  static void _connectLoop() async {
    while (true) {
      try {
        _channel = WebSocketChannel.connect(Uri.parse(_url));
        await for (final msg in _channel!.stream) {
          _controller.add(msg);
        }
      } catch (_) {}
      _channel = null;
      await Future.delayed(_reconnectDelay);
    }
  }
}
