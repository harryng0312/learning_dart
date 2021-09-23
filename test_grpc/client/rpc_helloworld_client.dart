import 'package:grpc/grpc.dart';
import 'package:learning_dart/test_grpc/gen/helloworld.pbgrpc.dart';

Future<void> main(List<String> args) async {
  // http://{{ grpc server address}}/{{proto package}}.{{proto service}}/{{method}}
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