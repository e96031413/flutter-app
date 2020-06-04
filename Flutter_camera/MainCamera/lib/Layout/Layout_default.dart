import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:MainCamera/PrintingImage/PrintingImage.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

void main() => runApp(new MaterialApp(home: LayoutDefaultScreen()));

class LayoutDefaultScreen extends StatefulWidget  {
  final String imagePath;
  LayoutDefaultScreen({this.imagePath});
  @override
  _LayoutDefaultScreenState createState() => _LayoutDefaultScreenState();

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold()
    );
  }
}
class _LayoutDefaultScreenState extends State<LayoutDefaultScreen> {
  
  Future<void> _shareImage() async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd--hh-mm-ss');    
      String formattedDate = formatter.format(now);
      String ext = ".jpg";
      String fileName = formattedDate+ext;
      File imageShare = File(widget.imagePath);
      List<int> bytes = await imageShare.readAsBytes();
      Uint8List ubytes = Uint8List.fromList(bytes);
      await Share.file(
          '分享圖片', fileName, ubytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
    key: _globalKey,
    child: Scaffold(

    body: OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 4,
          childAspectRatio: 2,
          children: <Widget>[
                    Center(
                    child: Stack(
                      children:<Widget>[
                        Container(
                          width: 500.0 ,
                          height: 800.0 ,
                          child: Container(
                            color: Colors.red,
                            child: Text('合成照', style: TextStyle(fontSize: 100, color: Colors.white)),
                          )
                        ),
                        Container(
                          child: Image.file(File(widget.imagePath))
                          ),
                      ]
                      )
                      ),
                    Center(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      onPressed: _shareImage,
                      color: Colors.cyanAccent,
                      child: Text("分享", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                      )
                    ),
                    Center(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      onPressed:(){
                      Navigator.push(context,new MaterialPageRoute(
                        builder: (context) => new PrintingApp(imagePath: widget.imagePath)
                      ));
                      },
                      color: Colors.cyanAccent,
                      child: Text("列印", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                      )
                    ),
                    Center(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      onPressed:_capturePng,
                      color: Colors.cyanAccent,
                      child: Text("截圖", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                      )
                    ),
                    Center(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      onPressed: () {
                          Navigator.pop(context);
                      },
                      color: Colors.cyanAccent,
                      child: Text("回上頁", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                      )
                    ),
          ]
      );
      })
          ),
  );
}
Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();

      ui.Image image = await boundary.toImage(
        pixelRatio: 10.0,
      );

      ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      Uint8List uint8list = byteData.buffer.asUint8List();

      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return Scaffold(
              appBar: AppBar(title: Text('查看页面'), centerTitle: true),
              body: ListView(
                children: <Widget>[
                  Image.memory(
                    uint8list,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            );
          }),
        );
      });

    return uint8list;
    } catch (e) {
      print(e);
    }
    return null;
  }
}