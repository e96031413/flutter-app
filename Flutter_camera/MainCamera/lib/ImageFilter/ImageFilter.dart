import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:MainCamera/PreviewImage/PreviewImage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:after_layout/after_layout.dart';
import 'package:MainCamera/Layout/ChooseLayout.dart';

// 4. 預覽畫面暨濾鏡功能頁
void main() => runApp(new MaterialApp(home: ImageFilterScreen()));

class ImageFilterScreen extends StatefulWidget {
  final String imagePath;
  ImageFilterScreen({this.imagePath});

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<ImageFilterScreen>
    with AfterLayoutMixin<ImageFilterScreen> {
  String fileName;
  String albumName = 'Media';
  List<Filter> filters = presetFiltersList;
  File imageFile; // image picked from gallery.
  File imagePath; // image taken from previous screen.

// 4-1 濾鏡功能主Function
  Future getImage(context) async {
    imageFile = File(widget.imagePath); // 4-1-1 將圖片路徑以檔案方式開啟
    fileName = basename(imageFile.path); // 4-1-2 取得圖片檔案路徑(包含檔名)
    var image = imageLib
        .decodeImage(imageFile.readAsBytesSync()); // 4-1-3 用bytes的格式讀取圖片
    image = imageLib.copyResize(image, width: 600); // 4-1-4 複製原本的圖片，建立新圖
    Map imagefile = await Navigator.push(
      // 4-1-5 將該圖片跟濾鏡頁面map在一起，執行濾鏡功能
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("濾鏡效果調整"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
        GallerySaver.saveImage(imageFile.path,
            albumName: albumName); // 4-1-6 保存套用濾鏡後的圖片到本地
      });
      print(imageFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageLayoutScreen(
              imagePath: imageFile.path), // 4-1-7 將濾鏡圖片傳送到「分享or挑版型」頁面
        ),
      );
    }
  }

  // 4-2 預覽畫面暨濾鏡功能頁內容(靜態)
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('圖片預覽'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
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
                    color: Colors.green,
                    child: Text("濾鏡",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ImageFilterScreen(
                                imagePath:
                                    widget.imagePath)), // 4-2-1 將取得的圖片進行濾鏡功能
                      );
                    },
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
                    color: Colors.orange,
                    child: Text("挑版型",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ChooseLayoutScreen(
                                imagePath:
                                    widget.imagePath)), // 4-2-2 不選擇濾鏡，直接挑版型
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

  @override
  void afterFirstLayout(BuildContext context) {
    getImage(context); // 4-1 執行getImage函數
  }
}
