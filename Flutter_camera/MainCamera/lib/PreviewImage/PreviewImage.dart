import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:MainCamera/Layout/ChooseLayout.dart';

// 5. 分享or挑版型頁面
class ImageLayoutScreen extends StatefulWidget {
  final String imagePath;

  ImageLayoutScreen({this.imagePath});

  @override
  _ImageLayoutScreenState createState() => _ImageLayoutScreenState();
}

class _ImageLayoutScreenState extends State<ImageLayoutScreen> {
  // 5-1分享圖片功能
  Future<void> _shareImage() async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd--hh-mm-ss');
      String formattedDate = formatter.format(now);
      String ext = ".jpg";
      String fileName = formattedDate + ext;
      File imageShare = File(widget.imagePath); // 5-1-1 讀取要被分享的圖片路徑
      List<int> bytes = await imageShare.readAsBytes(); // 5-1-2 以bytes格式讀取
      Uint8List ubytes = Uint8List.fromList(bytes); // 5-1-3 轉換成Uint8List的格式
      await Share.file(
          '分享圖片', fileName, ubytes, 'image/jpg'); // 5-1-4 分享圖片主要Function
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  //  5-2 分享or挑版型頁面(靜態UI)
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圖片預覽'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Container(
            child: ResponsiveGridRow(children: [
              ResponsiveGridCol(
                  xs: 12,
                  md: 12,
                  child: ButtonTheme(
                      child: Image.file(File(widget.imagePath),
                          height: 550, fit: BoxFit.fitWidth))),
              ResponsiveGridCol(
                xs: 6,
                md: 6,
                child: ButtonTheme(
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80)),
                    color: Colors.indigoAccent,
                    child: Text("分享",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500)), // 5-2-1 分享圖片按鈕
                    onPressed: _shareImage,
                  ),
                ),
              ),
              ResponsiveGridCol(
                xs: 6,
                md: 6,
                child: ButtonTheme(
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80)),
                    color: Colors.cyanAccent,
                    child: Text("挑版型",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ChooseLayoutScreen(
                                  imagePath: widget.imagePath) // 5-2-2 進行版型挑選
                              ));
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
