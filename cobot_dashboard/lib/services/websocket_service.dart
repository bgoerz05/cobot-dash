import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  static WebsocketService? _serviceInstance;
  WebsocketService._();

  static WebsocketService get websocketService =>
      _serviceInstance ??= WebsocketService._();

  static WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse("ws://localhost:8080"),
  );

  void dispose() {
    channel.sink.close();
  }
}
