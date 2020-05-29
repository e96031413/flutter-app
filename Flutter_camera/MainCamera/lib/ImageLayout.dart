import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:MainCamera/ChooseLayout.dart';


class ImageLayoutScreen extends StatefulWidget {
  final String imagePath; 

  ImageLayoutScreen({this.imagePath});

  @override
  _ImageLayoutScreenState createState() => _ImageLayoutScreenState();
}

class _ImageLayoutScreenState extends State<ImageLayoutScreen> {
    Future<void> _shareImage() async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd--hh-mm-ss');    
      String formattedDate = formatter.format(now);
      String ext = ".jpg";
      String fileName = formattedDate+ext;
      File Image2share = File(widget.imagePath);
      List<int> bytes = await Image2share.readAsBytes();
      Uint8List ubytes = Uint8List.fromList(bytes);
      await Share.file(
          '分享圖片', fileName, ubytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圖片預覽'),
        backgroundColor: Colors.blueAccent,
      ),
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
                      color: Colors.indigoAccent,
                      child: Text("分享", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: _shareImage,
                    ),
                  ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 6,
                    child: ButtonTheme(
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                      color: Colors.cyanAccent,
                      child: Text("挑版型", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(context,new MaterialPageRoute(
                          builder: (context) => new ChooseLayoutScreen(imagePath: widget.imagePath)
                        ));
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
}
