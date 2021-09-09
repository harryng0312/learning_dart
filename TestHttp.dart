import 'package:http/http.dart' as http;

void testHttpGet() {
  String url = "https://vnexpress.net";
  Uri uri = Uri.parse(url);
  http.get(uri).then((value) {
    print("${value.body}");
  });
}

void main(List<String> args) {
  testHttpGet();
}
