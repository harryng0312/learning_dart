import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:learning_dart/test_grpc/gen/helloworld.pbgrpc.dart';

late ClientChannel channel;
late HelloworldServiceClient stub;
final host = "localhost";
final port = 9443;

void init() {
  channel = ClientChannel(
    host,
    port: port,
    options: ChannelOptions(
      credentials: ChannelCredentials.secure(
        onBadCertificate: (certificate, host) {
          return true;
        },
      ),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  stub = HelloworldServiceClient(channel);
}

void destroy() {
  channel.shutdown();
}

Future<void> getCurrentDate(List<String> args) async {
  final name = args.isNotEmpty ? args[0] : 'world';
  try {
    var req = GetCurrentDateRequest().createEmptyInstance();
    req.name = name;
    final response = await stub.getCurrentDate(
      req,
      options: CallOptions(compression: const GzipCodec()),
    );
    print('Client received:${response.name} - ${response.result}');
  } catch (e) {
    print('Caught error: $e');
  }
}

Future<void> sendMessageStream() async {
  int n = 10;
  var msg = ChatMessage.create();
  msg.id = "1";
  msg.message = utf8.encode("test message");
  msg.senderId = "me";
  msg.receiverId = "you";
  msg.state = MessageState.NOT_SEND;
  // var elems = List.of([msg]);
  // Stream<ChatMessage> request = Stream.fromIterable(elems);
  Stream<ChatMessage> createStream(ChatMessage msg) async* {
    for (int i = 0; i < n; i++) {
      var mess = ChatMessage.create();
      mess.id = msg.id;
      mess.senderId = msg.senderId;
      mess.receiverId = msg.receiverId;
      mess.state = msg.state;
      mess.message = utf8.encode("${utf8.decode(msg.message)}-${i + 1}");
      await Future.delayed(Duration(seconds: 2));
      print("create msg:$i");
      yield mess;
    }
  }

  Stream<ChatMessage> request = createStream(msg);
  try {
    Stream<ChatSignal> resultStream = await stub.sendChatStream(
      request,
      options: CallOptions(compression: const GzipCodec()),
    );
    await for (var signal in resultStream) {
      print("Signal:${signal.state}");
    }
  } catch (e) {
    print('Caught error: $e');
  }
  await Future.delayed(Duration(seconds: 2));
}

void main(List<String> args) {
  // http://{{ grpc server address}}/{{proto package}}.{{proto service}}/{{method}}
  init();
  // getCurrentDate(args).then((value) => destroy());
  sendMessageStream().then((value) => destroy());
  // destroy();
}
// GET /page HTTP/1.1
// Host: server.example.com
// Connection: Upgrade, HTTP2-Settings
// Upgrade: h2c 
// HTTP2-Settings: (SETTINGS payload) 

// HTTP/1.1 200 OK 
// Content-length: 243
// Content-type: text/html

// (... HTTP/1.1 response ...)

//           (or)

// HTTP/1.1 101 Switching Protocols 
// Connection: Upgrade
// Upgrade: h2c

// (... HTTP/2 response ...)