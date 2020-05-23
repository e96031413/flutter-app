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
        child:SingleChildScrollView(
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
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                ]),
        
    ),
      ),
        ),

    );
  }
}