import 'dart:io';

import 'package:dio/dio.dart';

void main(List<String> args) {
  const fakeUrl = "https://jsonplaceholder.typicode.com/users";
  settingDioInterceptors(fakeUrl);
}

settingDioInterceptors(String url) async {
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    // do something before request is sent
    // return handler.next(options); // continue
    return handler.resolve(Response(requestOptions: options,data: "bad data")); // return some self-defined data(like `response` data)after finish the request,and it will be invoked by then()
    // (.then() will return your self-defined data `response`)
    // handler.reject(error); // like below case
  }, onResponse: (response, handler) {
    // do something with response data
    return handler.next(response); // continue
    // handler.reject(error);  // stop the request and trigger a error type of `DioError`, and will be invoked by catchError()
  }, onError: (DioError error, handler) {
    // do something when error
    return handler.next(error);
  }));

  Response response = await dio.get(url);
  print(response);
}
// above all case aren't involved in .then() or .catchError()