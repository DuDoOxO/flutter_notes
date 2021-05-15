import 'dart:async';

import 'package:flutter/material.dart';

// create Stream method 1

// Stream.fromFuture(Future future) : single Future
final streamSingle =
    Stream.fromFuture(Future.delayed(Duration(seconds: 1), () => print(100)));

// Stream.fromFutures(Iterable<Future> futures) : List<Future<int>>...etc
List<Future<int>> generateListFutures() =>
    List<Future<int>>.generate(10, (index) => Future.value(100));
final streamFutureList = Stream.fromFutures(generateListFutures());

// Stream.fromIterable(Iterable element) : List<int>.generate()
final streamList =
    Stream.fromIterable(List<int>.generate(100, (index) => index * 10));

// create Stream method 2 : async* + yield
Stream<int> increaseStream() async* {
  for (int i = 0; i < 10; i++) {
    yield i;
  }
}


// create Stream method 3 : StreamController
class MyAppStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Test Stream",
      home: MyHomePageStream(),
    );
  }
}

class MyHomePageStream extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageStream> {
  int _count = 0;
  final StreamController<int> _controller = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: StreamBuilder<int>(
            stream: _controller.stream,
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              return asyncSnapshot.data == null
                  ? Text("0")
                  : Text("${asyncSnapshot.data}");
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.sink
              .add(++_count); //只是包裝了StreamController而已,底層還是呼叫add() func
          // or _controller.add(++count);
          // do anything you want
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}



// single stream
singleStream() {
  // 1. initial a controller
  StreamController controller = StreamController();

  // 2. patch a strem from controller
  Stream streamA = controller.stream;

  // 3. bind the stream on the controller by calling listen func
  streamA.listen((value) => print("A value is $value"));

  // 4. emit/add  the value on the controller
  controller.sink.add(123);
  controller.add(456);

  // 5. cancel the stream by calling controller.close func, avoid memory leak
  controller.close();
}

// Broadcast Stream
broadcastStream() {
  // 1. initial a controller
  StreamController controller = StreamController();

  // 2. patch a strem from controller
  Stream streamA = controller.stream.asBroadcastStream();

  // 3. bind the stream on the controller by calling listen func
  streamA.listen((value) => print("A value is $value"));
  streamA.listen((value) => print("BBB value is $value"));

  // 4. emit/add  the value on the controller
  controller.sink.add(123);
  controller.add(456);

  // 5. cancel the stream by calling controller.close func, avoid memory leak
  controller.close();
}

void main(List<String> args) {
  singleStream();
  // broadcastStream();
}
