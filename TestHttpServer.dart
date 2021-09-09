import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as s;
import 'package:shelf/shelf_io.dart' as sIo;
import 'package:shelf_router/shelf_router.dart' as sR;
import 'package:shelf_static/shelf_static.dart' as sS;
import 'package:shelf_web_socket/shelf_web_socket.dart' as sWs;
import 'package:web_socket_channel/web_socket_channel.dart';

// late HttpServer server;

late Logger logger;

s.Handler registerStaticResources() {
  s.Handler staticHandler =
      sS.createStaticHandler('static', defaultDocument: 'index.html');
  return staticHandler;
}

s.Handler createWebSocketHandler() {
  s.Handler handler = sWs.webSocketHandler((WebSocketChannel wsChannel) {
    wsChannel.stream.listen((msg) {
      logger.info("/ws: ${msg}");
      wsChannel.sink.add("/ws reply ${msg}");
    });
  });
  return handler;
}

s.Handler createWebSocketHandler2() {
  s.Handler handler = sWs.webSocketHandler((WebSocketChannel wsChannel) {
    wsChannel.stream.listen((msg) {
      logger.info("/ws2: ${msg}");
      wsChannel.sink.add("/ws1 reply ${msg}");
    });
  });
  return handler;
}

s.Handler createHttpRouter() {
  // s.Handler websocketHandler = createWebSocketHandler();
  // s.Handler websocketHandler2 = createWebSocketHandler2();
  sR.Router router = sR.Router(
      notFoundHandler: (request) =>
          s.Response.notFound('Default router is not found'));
  sR.Router subRouter = sR.Router();
  router.get('/rs/sum/<a|[0-9]+>/<b|[0-9]+>', (request, String a, String b) {
    final aNum = int.parse(a);
    final bNum = int.parse(b);
    return s.Response.ok(
      const JsonEncoder.withIndent(' ')
          .convert({'a': aNum, 'b': bNum, 'sum': aNum + bNum}),
      headers: {
        'content-type': 'application/json',
        // 'Cache-Control': 'public, max-age=0',
      },
    );
  });
  router.get('/rs/hello/<param>',
      (request, String param) => s.Response.ok("Hello ${param}"));
  // router.get('/ws', websocketHandler);
  // router.get('/ws2', websocketHandler2);
  router.get('/hello-world', (request) => s.Response.ok("Hello World!!!"));
  router.get('/time',
      (request) => s.Response.ok(DateTime.now().toUtc().toIso8601String()));
  // router.get('/rs', subRouter);
  // router.all("/<*>", (request) => s.Response.notFound('Default Not found'));
  return router;
}

s.Handler createWsRouter() {
  s.Handler websocketHandler = createWebSocketHandler();
  s.Handler websocketHandler2 = createWebSocketHandler2();
  sR.Router handler = sR.Router(
      notFoundHandler: (request) =>
          s.Response.notFound('Websocket router is not found'));
  handler.get('/ws', websocketHandler);
  handler.get('/ws2', websocketHandler2);
  return handler;
}

Future<void> createHttpServer() async {
  int port = int.parse(Platform.environment['PORT'] ?? '8080');
  s.Handler httpRouter = createHttpRouter();
  s.Handler staticResourcesHandler = registerStaticResources();
  s.Handler websocketRouter = createWsRouter();
  // s.Handler websocketHandler = createWebSocketHandler();

  s.Cascade cascade = s.Cascade()
      .add(staticResourcesHandler)
      .add(websocketRouter)
      .add(httpRouter);

  // Shelf.Handler pipeline = Shelf.Pipeline()
  //     // .addMiddleware((innerHandler) => websocketHandler)
  //     .addMiddleware((innerHandler) => router)
  //     .addMiddleware((innerHandler) => staticResourcesHandler)
  //     // .addHandler(router);
  //     .addHandler(websocketHandler);
  // Shelf.Cascade cascade = Shelf.Cascade().add(hackyRouterHandler);
  // .add(websocketHandler);

  s.Handler handler = s.logRequests().addHandler(cascade.handler);
  // Shelf.Handler handler = pipeline;

  sIo
      .serve(
        handler,
        InternetAddress.anyIPv4, // Allows external connections
        port,
      )
      .then((server) =>
          print('Serving at http://${server.address.host}:${server.port}\n'
              'Serving at ws://${server.address.host}:${server.port}\n'));
}

void initLogger() {
  Logger.root.level = Level.INFO;
  logger = Logger("TestHttpServer");
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

void main(List<String> args) {
  initLogger();
  createHttpServer();
  logger.info("Starting...");
}
