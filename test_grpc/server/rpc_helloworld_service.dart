import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';
import 'package:intl/intl.dart';
import 'package:learning_dart/test_grpc/gen/helloworld.pbgrpc.dart';
import 'package:logging/logging.dart';

late Logger logger;

class RpcHelloworldService extends HelloworldServiceBase {
  static DateFormat _dateFormat = DateFormat("yyyy/MM/dd HH:mm:ss");
  @override
  Future<GetCurrentDateResponse> getCurrentDate(
      ServiceCall call, GetCurrentDateRequest request) async {
    GetCurrentDateResponse res = GetCurrentDateResponse.create();
    res.name = request.name;
    res.result = _dateFormat.format(DateTime.now());
    logger.info("Client:${call.headers}");
    return res;
  }
}

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

Future<void> main(List<String> args) async {
  // http://{{ grpc server address}}/{{proto package}}.{{proto service}}/{{method}}
  initLogger();
  final server = Server(
    [RpcHelloworldService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
