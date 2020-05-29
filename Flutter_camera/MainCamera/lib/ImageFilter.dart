import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:MainCamera/ImageLayout.dart';
void main() => runApp(new MaterialApp(home: ImageFilterScreen()));

class ImageFilterScreen extends StatefulWidget {
  
  final String imagePath;
  ImageFilterScreen({this.imagePath});

  @override
    _MyAppState createState() => new _MyAppState();
  
}

class _MyAppState extends State<ImageFilterScreen> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;  // image picked from gallery.
  File imagePath;  // image taken from previous screen.
  
  Future getImage(context) async {
    imageFile = File (widget.imagePath);  // 將路徑以檔案方式開啟
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    Map imagefile = await Navigator.push(
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
      });
      print(imageFile.path);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageLayoutScreen(imagePath: imageFile.path),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('濾鏡效果調整'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Center(
                  child: new Text('點擊右下角按鈕開始使用濾鏡'),
                )
              : Image.file(imageFile),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}