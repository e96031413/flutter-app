import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/CameraTaken.dart';
import 'package:MainCamera/preview_screen.dart';
import 'package:MainCamera/ShareImage.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照APP"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child:       SingleChildScrollView(
        child: Container(
          
        child: 
        ResponsiveGridRow(
                children: [ResponsiveGridCol(
                    lg: 12,
                    child: Container(
                      height: 300,
                      alignment: Alignment.center,
                      color: Colors.purpleAccent,
                      child: Text('廣告頁', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 4,
                    md: 3,
                    child: ButtonTheme(
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      color: Colors.green,
                      child: Text("濾鏡", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {}, 
                    ),
                  ),
                  ),
                  ResponsiveGridCol(
                    xs: 4,
                    md: 3,
                    child: ButtonTheme(
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      color: Colors.orange,
                      child: Text("挑版型", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {},
                    ),
                  ),
                  ),
                  ResponsiveGridCol(
                    xs: 4,
                    md: 3,
                    child: ButtonTheme(
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      color: Colors.red,
                      child: Text("分享", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => new ShareImageScreen()),
                        );
                      },
                    ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 4,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      child: new RaisedButton(
                      color: Colors.yellowAccent,
                      child: Text("拍照", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => new CameraScreen()),
                        );
                      },
                    ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      child: RaisedButton(
                      color: Colors.blueGrey,
                      child: Text("列印", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {},
                    ),
                    ),
                  ),
                ]
          ),
        
    ),
      ),
        ),

    );
  }
}