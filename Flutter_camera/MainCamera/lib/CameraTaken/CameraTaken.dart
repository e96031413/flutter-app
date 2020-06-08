import 'dart:io';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:MainCamera/CameraTaken/BackGroundRemove.dart';
import 'package:MainCamera/CameraTaken/DefaultPage.dart';

void main() => runApp(new CameraScreen());

// 2-1 拍照

class CameraScreen extends StatelessWidget {
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

class HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  String firstButtonText = '點我進行拍照';
  double textSize = 20;
  String albumName = 'Media'; // 圖片保存到本地時的資料夾名稱
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: DefaultPage());
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    _takePhoto();
  }

  // 2-1 用相機拍照Function
  void _takePhoto() async {
    ImagePicker.pickImage(source: ImageSource.camera) // 2-1-1從相機挑選照片(拍照)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        setState(() {
          firstButtonText = '保存圖片中...';
        });
        GallerySaver.saveImage(recordedImage.path,
                albumName: albumName) // 2-1-2保存照片至本地
            .then((bool success) {
          setState(() {
            firstButtonText = '圖片保存成功';
          });
          // 3. 進入到預覽畫面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewImageScreen(
                  imagePath: recordedImage.path), // 2-1-3將照片傳送至預覽畫面
            ),
          );
        });
      }
    });
  }
}