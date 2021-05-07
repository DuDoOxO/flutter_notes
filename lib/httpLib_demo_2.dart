import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  // fetchGet().then((value) => print(utf8.decode(value.bodyBytes)));
  _loadDataGet();
  _loadDataPost();
}

// Future object version
Future<http.Response> fetchGet() {
  var fakeUri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  return http.get(fakeUri);
}

// async-await version
_loadDataGet() async {
  final client = http.Client();
  var fakeUri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  http.Response response = await client.get(fakeUri);
  print(utf8.decode(response.bodyBytes));
  client.close();
}

// header : content-type setting ?
_loadDataPost() async {
  final client = http.Client();
  Map<String, String> headerMap = {"userId": "123"};
  var fakeUri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  http.Response response =
      await client.post(fakeUri, headers: headerMap, body: {});
  print(utf8.decode(response.bodyBytes));
  client.close();
}
