import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/CameraTaken/CameraTaken.dart';
import 'package:MainCamera/CameraTaken/PickFromGallery.dart';

// 1. 首頁畫面(靜態)

class DefaultPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
        '/CameraScreen': (BuildContext context) => new CameraScreen(),
        '/FromGalleryScreen': (BuildContext context) => new FromGalleryScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. 首頁畫面(靜態)
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key:key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  // final keyIsFirstLoaded = 'is_first_loaded';

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;



  @override
  Widget build(BuildContext context) {
    // 1-5 避免使用者跳出(跳出Dialog讓使用者選擇)
    return WillPopScope(
        onWillPop: () async => showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(title: Text('你確定要退出嗎？'), actions: <Widget>[
                  RaisedButton(
                      child: Text('退出'),
                      onPressed: () => Navigator.of(context).pop(true)),
                  RaisedButton(
                      child: Text('取消'),
                      onPressed: () => Navigator.of(context).pop(false)),
                ])),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Container(
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                    lg: 12,
                    child: Container(
                      height: 562,
                      alignment: Alignment.center,
                      color: Colors.purpleAccent,
                      child: Text('廣告頁',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      child: Container(
                        height: 60,
                        child: new RaisedButton(
                          color: Colors.blueAccent,
                          child: Text("拍照",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w100)),
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, '/CameraScreen'); // 1-6-1 跳頁至拍照畫面
                          },
                        ),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      child: Container(
                        height: 60,
                        child: new RaisedButton(
                          color: Colors.yellowAccent,
                          child: Text("從手機取得圖片",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w100)),
                          onPressed: () {
                            Navigator.popAndPushNamed(context,
                                '/FromGalleryScreen'); // 1-6-2 跳頁至從手機取得圖片
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}