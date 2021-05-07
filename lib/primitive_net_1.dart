import 'dart:convert';
import 'dart:io';

void main() {
  // _loadDataGet();
  _loadDataPost();
}

// Future object version (primitive)
// HttpClient client = HttpClient();
// client
//     .getUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
//     .then((HttpClientRequest request) => request.close())
//     .then((HttpClientResponse response) {
//   print('Response status: ${response.statusCode}');
//   response.transform(Utf8Decoder()).listen((contents) {
//     print('${contents}');
// client.close();
//   });
// });

_loadDataGet() async {
  try {
    HttpClient client = HttpClient();
    const String fakeUrl = "https://jsonplaceholder.typicode.com/posts";
    HttpClientRequest clientRequest = await client.getUrl(Uri.parse(fakeUrl));
    HttpClientResponse response = await clientRequest.close();
    String _responseText = await response.transform(Utf8Decoder()).join();
    print(_responseText);
    client.close(); // 使用後，一定要用close方法關閉
  } catch (error) {
    print("Request exception:${error}");
  }
}

_loadDataPost() async {
  try {
    HttpClient client = HttpClient();
    const String fakeUrl = "https://jsonplaceholder.typicode.com/posts";

    //get client request
    HttpClientRequest clientRequest = await client.postUrl(Uri.parse(fakeUrl));

    // set the header
    clientRequest.headers.set("Content-Type", "application/json");

    // init a map
    Map jsonMap = {"userId": 105};

    clientRequest.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await clientRequest.close();
    String _responseText = await response.transform(Utf8Decoder()).join();
    print(_responseText);
    client.close(); // 使用後，一定要用close方法關閉
  } catch (error) {
    print("post error: ${error}");
  }
}
