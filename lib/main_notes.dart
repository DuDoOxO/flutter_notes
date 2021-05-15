import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


// void main() => runApp(MaterialApp(
//       home: new HomePage(),
//     )); // 開始產生 Material Widget tree

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Test",
      home: HomePage(),
    );
  }
}

// 不會變動狀態(state)的widget
class HomePage extends StatelessWidget {
  // 必須要implement a build
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: Text("My App Demo123"),
        ),
        body: Row(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: 100.0,
              height: 100.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              color: Colors.blue,
              width: 100.0,
              height: 100.0,
            ),
          ],
        ));
  }
}

class HomePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //Widget
    // TODO: implement createState
    return HomePage2State();
  }
}

// 該StatefulWidget會去監控State是否有改變
class HomePage2State extends State<HomePage2> {
  //提供state
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // 一個整個screen page的Widget
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.forward),
          onPressed: () {
            setState(() {});
          },
        ),
        appBar: new AppBar(
          title: Text("My App Demo123"),
        ),
        body: Row(
          children: <Widget>[
            Container(
              color: getColor(),
              width: 100.0,
              height: 100.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              color: getColor(),
              width: 100.0,
              height: 100.0,
            ),
          ],
        ));
  }

  Color getColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }
}
//----------------------------------------

// Container widget : combine painting, sizing,positioning, 繼承於statelesswidget
// StatelessWidget : 畫完之後就不會隨便改動其資料了,所以不需要有state
class HomePage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "My Test App"), // 有些component會受到parent的影響,所以直接使用的話,很有可能就直接繼承parent的設定
      ),
      body: Row(
        // default : 寬度有限,高度unbound <-> Column() default: 高度有限,寬度unbound
        children: <Widget>[
          Text(
            "Demo",
            style: TextStyle(
                // style 或 decoration都是可以用來定義物件的屬性或參數,每個有style的,都有自己的class來做描述
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.green,
                fontStyle: FontStyle.italic),
          ),
          Container(
            // margin: EdgeInsets.all(20.0),
            // padding: EdgeInsets.all(20.0),
            // child: Text("My container Demo"),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.greenAccent, shape: BoxShape.circle), //外框為圓型的設定
            //decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(10.0)),// 有使用decoration時, 外面的color就不能被使用,要移到decoration裡面做使用
          ) // 沒設定長寬時候會去fit child,反之則fit 設定的長寬, 如果沒有child時,constraints 就會是unbound => 極大化來fit parent
        ],
      ),
    );
  }
}

// Card 包含內容和action的單一物件,不能夠層層包Card,但是可以包含其他的compoent elements
// Card Default : 裡面是一個Container widget再包著Material widget(沒有width, height)
// SizeBox : 提供Card裡面的Container額外的條件,讓Card裡面的Cotainer可以去fit外面的SizeBox的物件屬性
class HomePage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo test"),
      ),
      // body:Card(child: Text("test 123"),) // Card內部的Container會以child Text widget為單位來撐大小且padding:4的預設值
      // body : Card(child:Container(child: Text("Test123"),width: 40,height: 40,) ,) // 在child部分再塞一個Container來撐大小,因為Container可以設定width & height
      body: SizedBox(
          width: 100,
          height: 50,
          child: Card(
            child: Text("Text 123"),
          )),
    );
  }
}

class HomePage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(); // onEdittingComplete controoler setitng 1
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Text test"),
        ),
        body: TextField(
          controller: controller, // onEdittingComplete controoler  setting 2
          onChanged: (text) {
            print(text);
          },
          onEditingComplete: () {
            // 因為onEdittingCompelte 沒有辦法拿到所輸入的文字(default參數沒有半個):常用於如果textfield有button要取得該string的話,就很方便
            // 所以要用TextEdittingController的設定 1&2
            print("onEdittingComplete");
            print((controller.text));
          },
          onSubmitted: (text) {
            print(text);
          },
          decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Date",
              // suffix: Icon(
              // Icons.remove), // focus on this textfield時, 才會show出來這個icon
              // suffixIcon: Icon(Icons.close), // 沒有focus on  就會show出這個icon了
              // focusedBorder: InputBorder.none // focus on 底下那條線會不見,所以不能修改其顏色
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              helperText: "Input Date",
              hintText: "Input Date",
              suffix: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // FocusScope.of(Context) :取得該text field的focus
                  // .requestFocus(FocusNode()) : 要求一個foucs來設定,但至focus是被給予一個新的focus node
                },
              )), // focus on時候會跑出hint text在textfield中
        ));
  }
}

// lLayout Widget :
// ListView 很像 Column, Column可是沒有捲軸的(scroll)
class HomePage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPaintSizeEnabled = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("text listview"),
      ),
      body: ListView(
        // 他會全部資料Render出來,且有時候也會不知道resource資料為幾筆-->比較適合已知陣列大小可以搭配List.generate來產生
        children: List.generate(10, (idx) {
          return Card(
              child: Container(
            height: 150,
            color: Colors.green,
            child: Text("$idx"),
          )); // Card widget defalut 沒大小,return會沒東西看不到,要用child撐開
        }),
      ),
    );
  }
}

// ListView 進階版
class HomePage7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPaintSizeEnabled = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("advaced ListView"),
      ),
      body: ListView.builder(
          //用這個的好處就是顯示的cell數會是螢幕上的再加上一兩個cell數量,對比上面的用法則是會將全部render出來 -->比較適合從網路上抓下來資料RENDER的用法
          itemCount: 10, // 可以指定子元素為１０個
          itemBuilder: (context, idx) {
            return Card(
                child: Container(
              height: 150,
              color: Colors.yellow,
              child: Text('$idx'),
            ));
          }),
    );
  }
}

// GridView :可以在裡面放各式各樣的Widget來當作裡面的內容
// 而且是縱向排列
class HomePageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final title = "Grid Text";
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        // body: GridView.count(
        //   // GridView.count is like ListView parameter will be array in children
        //   crossAxisCount: 2, // 寬度是由切幾分作決定的
        //   childAspectRatio: 2/3, // 寬長比:1.5,長度由這邊做設定,主要也是透過該值得寬長比來設定
        //   children: List.generate(100, (idx) {
        //     //List.generate 生成陣列
        //     return Card(
        //     child: Container(
        //       // width: 500, 不能改GridView裡面元素的的大小
        //       // height: 500,
        //       color: Colors.blue,
        //       child: Text("index:$idx"),
        //     ));
        //   }),
        // ), // crossAxisCount : 因為是縱向排列,該設定為橫向要幾個元素
        body: GridView.builder(
            gridDelegate: // 提供更加彈性的設定方式
                // SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2, // 因為寬度是固定的,所以沒辦法更改,所以可以使用以下的設定
                //     childAspectRatio: 2 / 3), // 跟上面的crossAxisCount設定一樣
                SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100, // 設定元素寬度的最大值像素
                    childAspectRatio: 2 / 3),
            itemBuilder: (
              // 跟ListView.builder 中的itemBuilder 一樣,builder or render 每一個元素的一些設定
              context,
              idx,
            ) {
              return Card(
                  child: Container(
                // width: 500, 不能改GridView裡面元素的的大小
                // height: 500,
                color: Colors.blue,
                child: Text("index:$idx"),
              ));
            }));
  }
}

// img from internet and assets
// 1. image.network : extends StatefulWidget :非原生的widget, parameter : url
// 主要是使用NetworkImage to imeplement our demand, and actually it's a Image Provider
// 2. image.assset 內部也是呼叫AssetImage
// AssetImage
// NetworkImage and AssetImage are primitive class, and described the methods of rendering/drwaing the picture
// But in View field, we have to return Widget class , so we have to wrap them(NetworkImage & AssetImage) to be Widget type
// network image version
class HomePage8 extends StatelessWidget {
  final String fakeUrl = "https://picsum.photos/200";
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = true; // 可開啟debug模式來看到圖片或者邊界線在模擬手機上呈現
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Demo"),
      ),
      body: Image.network(
        fakeUrl,
        height: 200,
        alignment: Alignment.topCenter, // 圖片對齊的方式
        fit: BoxFit.cover,
      ), // 他是個Box
    );
  }
}

// asset image version
// 1. make a new directory images or assets
// 2. go pubspec.yaml to find `flutter` and add
// assets:
//  - lib/assets/
class HomePage9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Demo"),
      ),
      body: Image.asset('lib/assets/test.png'), // 這部分不能Hot Reload
    );
  }
}

// BottomNavigationBar
// ignore: must_be_immutable
class HomePageBottomNavigationBar extends StatelessWidget {
  // 因為是StatelessWidet不會動,所以要改用StatefulWidget,下面示例
  int index;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // 通常BottoemNavigationBar會跟Scaffold一起使用
      appBar: AppBar(
        title: Text("BottomNavigationBar"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // 這樣每個icon下面就會有text出現了,預設是只有點到icon才會有
        currentIndex: index,
        onTap: (int index) {
          // onTap:為點擊該icon時才能夠觸發或者跳頁
          index = index;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Add"),
        ],
      ),
    );
  }
}

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
  // 也可以寫成下面那種
  // State<StatefulWidget> createState() {
  // //Widget
  // // TODO: implement createState
  // return _BottomNavigationBarPageState();
  // }
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int index = 0;
  List<Widget> pages = [
    Container(
      color: Colors.red,
    ),
    Container(color: Colors.blue),
    Container(color: Colors.black),
    Container(color: Colors.yellow)
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // 通常BottoemNavigationBar會跟Scaffold一起使用
      appBar: AppBar(
        title: Text("BottomNavigationBar"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // 這樣每個icon下面就會有text出現了,預設是只有點到icon才會有
        currentIndex: index,
        onTap: (int index) {
          // onTap:為點擊該icon時才能夠觸發或者跳頁
          index = index;
          setState(() {
            // re-render index
            index = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Add"),
        ],
      ),
      body: pages[index],
    );
  }
}

// 頁面切換 : Navigator + Route class
// 1. page簡單切換
class SwitchPage extends StatefulWidget {
  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("page1"),
      ),
      body: Container(
        color: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, "/page2"); // 這只能當純設定路徑且只有一個String的parameter
          //因為在main裡面設定的route預設就是return 一個沒有輸入值Page2 class,// 所以我們要自己在這設定MaterialPageRoute,其設定跟main中的Materail route相同
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            // cuz Navigator is a Future object -> async
            return Page2(
              textData: "abcdefg",
            );
          })).then((value) => print(
              value)); // 這邊可以用.then方法取得由Page2 傳來的資料, 因為Navigator是一Future物件,是一個async的程式
        },
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final String textData;
  Page2({Key key, @required this.textData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("page2"),
      ),
      body: SizedBox.expand(
          child: Container(
        //會用SizedBox原因是因為要讓這個Container to fit body大小
        color: Colors.blue,
        child: Text(textData), // 在child地方放入建構子定義的textData
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, "123456789"); // 回傳資料給上一個頁面
        },
      ),
    );
  }
}

// 需要在main func 裡面設定routes
// void main() => runApp(
//       MaterialApp(
//         initialRoute: "/",
//         routes: {
//           "/": (context) {
//             return MyApp();
//           },
//           "/page2": (context) {
//             return Page2();
//           },
//         },
//       ),
//     );
