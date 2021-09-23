import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';
import 'package:intl/intl.dart';
import 'package:learning_dart/test_grpc/gen/helloworld.pbgrpc.dart';

class RpcHelloworldService extends HelloworldServiceBase {
  static DateFormat _dateFormat = DateFormat("yyyy/MM/dd HH:mm:ss");
  @override
  Future<GetCurrentDateResponse> getCurrentDate(
      ServiceCall call, GetCurrentDateRequest request) async {
    GetCurrentDateResponse res = GetCurrentDateResponse.create();
    res.name = request.name;
    res.result = _dateFormat.format(DateTime.now());
    return res;
  }
}

Future<void> main(List<String> args) async {
  final server = Server(
    [RpcHelloworldService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
