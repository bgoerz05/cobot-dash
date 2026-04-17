import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  static WebsocketService? _serviceInstance;
  WebsocketService._();

  static WebsocketService get websocketService => _serviceInstance ??= WebsocketService._();

  // Using echo server for testing, real websocket should be ws://localhost:8080
  static WebSocketChannel channel = WebSocketChannel.connect(Uri.parse("wss://echo.websocket.org"));

  void dispose() {
    channel.sink.close();
  }
  
}