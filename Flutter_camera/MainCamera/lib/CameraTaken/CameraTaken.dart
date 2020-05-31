import 'dart:io';

import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:MainCamera/CameraTaken/preview_screen.dart';
import 'package:responsive_grid/responsive_grid.dart';

void main() => runApp(new CameraScreen());

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'After Layout - Good Example',
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
  String firstButtonText = '點我進行拍照';
  double textSize = 20;
  String albumName ='Media';
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: MyApp());
  }

  @override
  
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    _takePhoto();
  }

  void _takePhoto() async {
    ImagePicker.pickImage(source: ImageSource.camera)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        setState(() {
          firstButtonText = '保存圖片中...';
        });
        GallerySaver.saveImage(recordedImage.path, albumName: albumName)
            .then((bool success) {
          setState(() {
            firstButtonText = '圖片保存成功';
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewImageScreen(imagePath: recordedImage.path),
            ),
          );
        });
      }
    });
  }
}


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
  // final keyIsFirstLoaded = 'is_first_loaded';
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context)); // 提示權限允許
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child:SingleChildScrollView(
        child: Container(
        child: 
        ResponsiveGridRow(
                children: [ResponsiveGridCol(
                    lg: 12,
                    child: Container(
                      height: 600,
                      alignment: Alignment.center,
                      color: Colors.purpleAccent,
                      child: Text('廣告頁', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      child: Container(
                        height: 85,
                      child: new RaisedButton(
                      color: Colors.yellowAccent,
                      child: Text("拍照", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100)),
                      onPressed: () {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => new CameraScreen()),
                        );
                      },
                    ),
                    ),
                  ),
        )]),
        
    ),
      ),
        ),

    );
    
  }
}