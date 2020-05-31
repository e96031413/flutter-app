import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/PrintingImage/PrintingImage.dart';

void main() => runApp(new MaterialApp(home: LayoutDefaultScreen()));

class LayoutDefaultScreen extends StatefulWidget  {
  final String imagePath;
  LayoutDefaultScreen({this.imagePath});
  @override
  _LayoutDefaultScreenState createState() => _LayoutDefaultScreenState();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
      ),
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("原圖"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
    body: new Center(
        child: Container(
            padding: new EdgeInsets.all(25.0),
            color: Colors.green,
            child:ResponsiveGridRow(
                children: [
                    ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: Container(
                      height: 220,
                      alignment: Alignment.center,
                      child: Image.file(File(widget.imagePath)),
                    ),
                  ),
                ResponsiveGridCol(
                    xs: 6,
                    md: 6,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
                      child: new RaisedButton(
                      color: Colors.cyanAccent,
                      child: Text("分享", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: _shareImage,
                    ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 6,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
                      child: new RaisedButton(
                      color: Colors.lightGreenAccent,
                      child: Text("列印", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed:(){
                        Navigator.push(context,new MaterialPageRoute(
                          builder: (context) => new PrintingApp(imagePath: widget.imagePath)
                        ));
                      }
                    ),
                    ),
                  ),
                ]
          ),
  ),

    ));
  }
}