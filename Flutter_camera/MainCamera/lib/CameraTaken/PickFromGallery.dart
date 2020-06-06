import 'dart:io';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:MainCamera/CameraTaken/BackGroundRemove.dart';
import 'package:MainCamera/CameraTaken/DefaultPage.dart';

// 2-2 從手機取得照片
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
  String albumName ='Media';     //圖片保存到本地時的資料夾名稱
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: DefaultPage());
  }

  @override
  
  // 2-2 從手機挑選照片Function
  void afterFirstLayout(BuildContext context) {    // 載入此畫面後，立即執行_pickPhoto()
    // Calling the same function "after layout" to resolve the issue.
    _pickPhoto();
  }

  void _pickPhoto() async {
    ImagePicker.pickImage(source: ImageSource.gallery)    // 2-2-1從手機儲存空間挑選照片
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        setState(() {
          firstButtonText = '保存圖片中...';
        });
        GallerySaver.saveImage(recordedImage.path, albumName: albumName)  // 2-2-2保存照片至本地
            .then((bool success) {
          setState(() {
            firstButtonText = '圖片保存成功';
          });
          // 3. 進入到預覽畫面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewImageScreen(imagePath: recordedImage.path), // 2-2-3將照片傳送至預覽畫面
            ),
          );
        });
      }
    });
  }
}