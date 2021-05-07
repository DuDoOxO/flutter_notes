import 'dart:io';

import 'package:dio/dio.dart';

void main(List<String> args) {
  // _concurrentLoadData()();
  _loadDataGet();
  _loadDataPost();
  // _singletonDio();
}

_loadDataGet() async {
  try {
    var dio = Dio();
    Response response =
        await dio.get("https://jsonplaceholder.typicode.com/users");
    print(response);
  } catch (error) {
    print(error);
  }
}

_loadDataPost() async {
  try {
    var dio = Dio();
    Response response = await dio.post(
        "https://jsonplaceholder.typicode.com/users",
        data: {"id": 12, "name": "apple"});
    print(response);
  } catch (error) {
    print(error);
  }
}

_singletonDio() async {
  var dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com/users",
    connectTimeout: 5000,
    receiveTimeout: 120000,
    headers: {
      HttpHeaders.userAgentHeader: "dio",
      "api": "1.0.0",
    },
    contentType: Headers.jsonContentType,
    responseType: ResponseType.plain,
  ));
  try {
    Response response =
        await dio.get("https://jsonplaceholder.typicode.com/users");
    print(response);
  } catch (error) {
    print(error);
  }
}
