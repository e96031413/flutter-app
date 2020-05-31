import 'dart:io';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/ImageFilter/ImageFilter.dart';
import 'package:MainCamera/Layout/ChooseLayout.dart';


class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
