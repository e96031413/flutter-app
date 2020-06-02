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

void main() => runApp(new MaterialApp(home: ImageFilterScreen()));

class ImageFilterScreen extends StatefulWidget {
  
  final String imagePath;
  ImageFilterScreen({this.imagePath});

  @override
    _MyAppState createState() => new _MyAppState();
  
}

class _MyAppState extends State<ImageFilterScreen> with AfterLayoutMixin<ImageFilterScreen> {
  
  String fileName;
  String albumName ='Media';
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
        GallerySaver.saveImage(imageFile.path, albumName: albumName);
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
      appBar: AppBar(
        title: Text('圖片預覽'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: Container(
        margin:EdgeInsets.all(0.0),
        child:SingleChildScrollView(
        child: Container(
        child: 
        ResponsiveGridRow(
                children: [ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                    child: Image.file(File(widget.imagePath), 
                                      height: 550,
                                      fit: BoxFit.fitWidth )) 
                    ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 6,
                    child: ButtonTheme(
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      color: Colors.green,
                      child: Text("濾鏡", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(context,new MaterialPageRoute(
                          builder: (context) => new ImageFilterScreen(imagePath: widget.imagePath)), //ImageFilterScreen
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      color: Colors.orange,
                      child: Text("挑版型", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                          Navigator.push(context,new MaterialPageRoute(
                          builder: (context) => new ChooseLayoutScreen(imagePath: widget.imagePath)), //ImageFilterScreen
                          );
                      },
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
  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    getImage(context);
  }
}