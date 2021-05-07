// 'dart:convert' 裡面有JSON的常數,負責處理從Server端傳回的JSON 資料
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Movie> fetchGet() async {
  // GET https://jsonplaceholder.typicode.com/posts/1 HTTP/1.1
  var fakeUri = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
  final response = await http.get(fakeUri);

  if (response.statusCode == 200) {
    return Movie.fromJson(json.decode(response.body));// String -> json
  } else {
    throw Exception("Failed to load request");
  }
}

class Movie {
  final String title;

  // constructor
  // {} :可選的具體參數,填入時候要給key
  Movie({this.title});

  // 透過factory關鍵字,可以控制在使用建構子時,並不是永遠都是去創建一個新的該類object
  // 可以從快取return 已有的instance or instance of subclass
  // 使用場景:
  // 1. 避免創建過多的重複instance,如果已有instance,則從快取中拿出
  // 2. invoke subclass的建構子(factory pattern)
  // 3. 實現singleton pattern
  // User.fromJson()建構子:為了從map structure中來建構出一個新的User instance
  // toJson():用來轉換一個User instance to Map 的func
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(title: json["title"]);
  }
}

class MyAppJSON extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Test Json Data",
      home: HomePageJSON(),
    );
  }
}

class HomePageJSON extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(movie: fetchGet());
}

class _HomePageState extends State<HomePageJSON> {
  final Future<Movie> movie;
  _HomePageState({Key key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Movie>(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            //default show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
