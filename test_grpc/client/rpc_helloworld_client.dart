import 'package:grpc/grpc.dart';
import 'package:learning_dart/test_grpc/gen/helloworld.pbgrpc.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    '127.0.0.1',
    port: 50051,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = HelloworldServiceClient(channel);

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
  await channel.shutdown();
}
