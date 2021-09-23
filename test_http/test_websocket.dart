import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void testWebSocketStream() {
  WebSocketChannel channel = WebSocketChannel.connect(
    // var channel = IOWebSocketChannel.connect(
    Uri.parse('ws://localhost:8080/ws'),
  );
  channel.stream.listen((msg) {
    print("${msg.runtimeType}\n${msg}");
  });
  channel.sink.add("Hello!");
  channel.sink.close(status.goingAway);
}

Future<void> testWebSocket() async {
  String url = "ws://localhost:8080/ws";
  // WebSocket webSocket = await WebSocket.connect(url, headers: {
  //   "connection": "upgrade",
  //   "upgrade": "websocket",
  //   "sec-websocket-protocol": "subprotocols"
  // });
  WebSocket webSocket =
      await WebSocket.connect(url, headers: {"sec-websocket-key": "11111"});
  webSocket.listen((msg) {
    print("Received data:${msg}");
  });
  String data = "hello";
  if (webSocket.readyState == WebSocket.open) {
    webSocket.add(data);
    webSocket.close();
  } else {
    print('WebSocket not connected, message ${data} not sent');
  }
}

void main(List<String> args) {
  // testWebSocket().then((value) => null);
  testWebSocketStream();
  // testSocketIO();
}
