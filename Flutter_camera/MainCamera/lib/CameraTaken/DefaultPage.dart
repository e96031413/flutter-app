import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/CameraTaken/CameraTaken.dart';
import 'package:MainCamera/CameraTaken/PickFromGallery.dart';

// 1. 首頁畫面(靜態)

class DefaultPage extends StatelessWidget {
  // This widget is the root of your application.
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
class MyHomePage extends StatelessWidget {
  // final keyIsFirstLoaded = 'is_first_loaded';
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context)); // 提示權限允許
    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
                            context, '/CameraScreen'); // 1-4-1 跳頁至拍照畫面
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
                        Navigator.popAndPushNamed(
                            context, '/FromGalleryScreen'); // 1-4-2 跳頁至從手機取得圖片
                      },
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
