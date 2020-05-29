import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/PrintingImage.dart';


void main() => runApp(new MaterialApp(home: LayoutThreeScreen()));

class LayoutThreeScreen extends StatefulWidget  {
  final String imagePath;
  LayoutThreeScreen({this.imagePath});
  @override
  _LayoutThreeScreenState createState() => _LayoutThreeScreenState();
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold()
    );
  }
}
class _LayoutThreeScreenState extends State<LayoutThreeScreen> {
    Future<void> _shareImage() async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd--hh-mm-ss');    
      String formattedDate = formatter.format(now);
      String ext = ".jpg";
      String fileName = formattedDate+ext;

      final ByteData bytes = await rootBundle.load(widget.imagePath);
      await Share.file(
          '分享圖片', fileName, bytes.buffer.asUint8List(), 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
        return new Scaffold(
      appBar: new AppBar(
        title: new Text("1吋+2吋"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
    ), 
    body: Center(      
        child: Container(
            padding: new EdgeInsets.all(25.0),
            color: Colors.redAccent,
            child:ResponsiveGridRow(
                children: [
                    ResponsiveGridCol(
                    xs: 6,
                    md: 2,
                    child: Container(
                      height: 220,
                      alignment: Alignment.center,
                      child: Image.file(File(widget.imagePath)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 2,
                    child: Container(
                      height: 220,
                      alignment: Alignment.center,
                      child: Image.file(File(widget.imagePath)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 2,
                    child: Container(
                      height: 180,
                      alignment: Alignment.center,
                      child: Image.file(File(widget.imagePath)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 2,
                    child: Container(
                      height: 180,
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