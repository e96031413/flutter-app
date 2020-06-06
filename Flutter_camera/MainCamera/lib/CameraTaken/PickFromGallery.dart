import 'dart:io';
import 'package:MainCamera/main.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:MainCamera/CameraTaken/preview_screen.dart';


void main() => runApp(new FromGalleryScreen());

class FromGalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
    return new MaterialApp(home: MyAppMain());
  }

  @override
  
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    _takePhoto();
  }

  void _takePhoto() async {
    ImagePicker.pickImage(source: ImageSource.gallery)
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