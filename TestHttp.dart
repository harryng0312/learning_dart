import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

void testHttpGet() {
  String url = "https://vnexpress.net";
  Uri uri = Uri.parse(url);
  http.get(uri).then((value) {
    print("${value.body}");
  });
}

void testDioGet() async {
  String url = "https://vnexpress.net";
  Dio dio = Dio();
  Response res = await dio.get(url);
  print("${res.data}");
}

void main(List<String> args) {
  // testHttpGet();
  testDioGet();
}
