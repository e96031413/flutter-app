import 'dart:convert';
import 'dart:io';

import 'package:MainCamera/ImageFilter/ImageFilter.dart';
import 'package:MainCamera/Layout/ChooseLayout.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

// 3. 去背功能+去背後預覽
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

  // 3-1 去背Function
  _asyncMethod() async {
    var list = ['VxKqFUekZdothbQtz5YyC4JS ']; // 可申請多個API Key做成list
    var apikey = randomChoice(list); // 隨機選擇API Key
    List<int> imageBytes =
        File(widget.imagePath).readAsBytesSync(); // 用bytes格式讀取照片
    String base64Image = base64Encode(imageBytes); // 加密成base64碼
    final body = {
      "image_file_b64": base64Image,
      "size": "auto"
    }; //圖片路徑即為base64碼
    final headers = {"X-API-Key": apikey}; // 加入API Key
    final response = await http.post(
        'https://api.remove.bg/v1.0/removebg', // 用http套件post到remove.bg網站
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      print("API Key Used:" + apikey); // 顯示使用的API Key是哪一個
      var documentDirectory =
          await getApplicationDocumentsDirectory(); // 取得APP的路徑位置
      var firstPath = documentDirectory.path + "/images";
      var filePathAndName = documentDirectory.path + '/images/pic.jpg';
      await Directory(firstPath).create(recursive: true); // 建立資料夾
      File file2 =
          new File(filePathAndName); // 新建file2檔案，檔名用filePathAndName變數產生的檔名
      file2.writeAsBytesSync(response.bodyBytes); //將API回傳的Bytes檔案寫入到file2

      setState(() {
        // 當上述程式執行成功：
        imageData = filePathAndName; // 令 imageData = filePathAndName
        dataLoaded = true; // 設定圖片回傳 = true
      });
    } else {
      throw Exception(
          'Failed to do network requests: Error Code: ${response.statusCode}\nBody: ${response.body}');
    }
  }

  String imageData;
  bool dataLoaded = false; // 圖片回傳預設 = false，代表初始還沒去背狀態

  Widget build(BuildContext context) {
    if (dataLoaded) {
      // 3-1-1 假設回傳 = true，顯示以下UI畫面(去背圖片效果顯示)
      return Scaffold(
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
                        child: Image.file(File(imageData),
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
                                  imagePath: imageData)), //進入濾鏡功能頁面
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
                                  imagePath: imageData)), // 進入挑版型頁面
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
    } else {
      // 3-1-2 假設回傳 = false，顯示以下UI畫面(圓形進度條呈現)
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
          child: CircularProgressIndicator(
            // 呈現進度條
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ));
  }
}
