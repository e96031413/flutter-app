import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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
  initState() {
    _asyncMethod();
    super.initState();
  }
  _asyncMethod() async{
    List<int> imageBytes = File(widget.imagePath).readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    final body = {"image_file_b64": base64Image, "size": "auto"};
    final headers = {"X-API-Key": "daTcbirNP1BX2XUGQjh6RqWb "};
    final response = await http.post('https://api.remove.bg/v1.0/removebg', 
        body: body,
        headers: headers);

    if (response.statusCode == 200) {
      var documentDirectory = await getApplicationDocumentsDirectory();
      var firstPath = documentDirectory.path + "/images";
      var filePathAndName = documentDirectory.path + '/images/pic.jpg'; 
      await Directory(firstPath).create(recursive: true);
      File file2 = new File(filePathAndName);
      file2.writeAsBytesSync(response.bodyBytes);
      setState(() {
        imageData = filePathAndName;
        dataLoaded = true;
      });
      } else {
    throw Exception('Failed to do network requests: Error Code: ${response.statusCode}\nBody: ${response.body}');
      }
  }
  String imageData;
  bool dataLoaded = false;

  Widget build(BuildContext context) {
    if (dataLoaded){
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
                    child: Image.file(File(imageData), 
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
                          builder: (context) => new ImageFilterScreen(imagePath: imageData)), //濾鏡
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
                          builder: (context) => new ChooseLayoutScreen(imagePath: imageData)), //挑版型
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
  }else {
      return MaterialApp(
        home: Scaffold(
      body: HomePage(),
    ));
  }
}
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.blueAccent,
  body: Center(
      //↓↓↓更改此處程式碼↓↓↓
      child: Text('載入中請稍後......',
                  style:new TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,),
              ),
        )
    );
  }
}