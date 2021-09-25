import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:intl/intl.dart';
import 'package:learning_dart/test_grpc/gen/helloworld.pbgrpc.dart';
import 'package:logging/logging.dart';

late Logger logger;

void initLogger() {
  Logger.root.level = Level.INFO;
  logger = Logger("TestHelloworldService");
  // File file = File("log/http_server.log");
  // if (!file.existsSync()) {
  //   file.createSync(recursive: true);
  // }
  logger.onRecord.listen((record) {
    // file.writeAsString(
    //     "${record.level.name}: ${record.time}: ${record.message}\n",
    //     mode: FileMode.append);
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class RpcHelloworldService extends HelloworldServiceBase {
  static DateFormat _dateFormat = DateFormat("yyyy/MM/dd HH:mm:ss");
  static var sessionMap = Map.of(<String, User>{});
  static var streamMap = Map.of(<String, Stream<ChatMessage>>{});
  @override
  Future<GetCurrentDateResponse> getCurrentDate(
      ServiceCall call, GetCurrentDateRequest request) async {
    GetCurrentDateResponse res = GetCurrentDateResponse.create();
    res.name = request.name;
    res.result = _dateFormat.format(DateTime.now());
    logger.info("Client:${call}");
    return res;
  }

  @override
  Future<AuthResponse> logoutChat(ServiceCall ctx, AuthRequest request) async {
    sessionMap.remove(request.user.id);
    streamMap.remove(request.user.id);
    var res = AuthResponse.create();
    res.result = 1;
    return res;
  }

  @override
  Future<AuthResponse> loginChat(ServiceCall ctx, AuthRequest request) async {
    sessionMap[request.user.id] = request.user;
    var res = AuthResponse.create();
    res.result = 1;
    return res;
  }

  @override
  Stream<ChatSignal> sendChatStream(
      ServiceCall call, Stream<ChatMessage> request) async* {
    // ignore: unnecessary_null_comparison
    // late var rsStream;

    if (request != null) {
      // var chatSignals = <ChatSignal>[];
      // await request.forEach((msg) {});
      await for (var msg in request) {
        logger.info("Client send ${msg.state} msg:${utf8.decode(msg.message)}");
        msg.state = MessageState.SENDING;
        ChatSignal chatSignal = ChatSignal.create();
        chatSignal.state = msg.state;
        yield chatSignal;
      }
    } else {
      logger.severe("request is null");
    }
  }
}

Future<void> startServer() async {
  final server = Server(
    [RpcHelloworldService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}

void main(List<String> args) {
  // http://{{ grpc server address}}/{{proto package}}.{{proto service}}/{{method}}
  initLogger();
  startServer();
}
