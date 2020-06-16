import 'dart:convert';
import 'dart:io';

import 'package:MainCamera/ImageFilter/ImageFilter.dart';
import 'package:MainCamera/Layout/ChooseLayout.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/GoogleDrive/googleDrive.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart'; // 取得mac地址

import 'package:firebase_auth/firebase_auth.dart';


// 3. 去背功能+去背後預覽
class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  var uuid = new Uuid();
  String _platformVersion = 'Unknown';

    final _auth = FirebaseAuth.instance;
    dynamic user;
    String userEmail;
    String userPhoneNumber;

  @override
  initState() {
    _asyncMethod();
    getCurrentUserInfo();
    initPlatformState(); // 渲染此頁面時，執行取得Mac Address的函數
    super.initState();
  }

  void getCurrentUserInfo() async {
    user = await _auth.currentUser();
    userEmail = user.email;
    userPhoneNumber = user.phoneNumber;
  }

    // 1-2 取得Mac Address的主函式
  Future<void> initPlatformState() async {
    String platformVersion;
    // 1-2-1 用try-except的方式來獲取 MAC Address
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = '無法取得Mac Address';
    }

    if (!mounted) return;

    setState(() {
      // 1-2-2 更新狀態，取得正式的 Mac Address
      _platformVersion = platformVersion;
      print('MAC Address : $_platformVersion');
    });
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
      var filePathAndName = documentDirectory.path + '/images/pic.png';
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

  // 3-2 Firebase上傳主函式
  void _startUpload() async {
    // 建立隨機名稱，避免圖片名稱重複
    // var name = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});

    // 使用Mac地址作為檔案名稱
    var email = userEmail.replaceAll(RegExp('@gmail.com'), '');   // 刪除@gmail.com(用空字串取代@gmail.com)
    var imageName = email+"_"+_platformVersion.replaceAll(':', '-')+"_"+uuid.v4(options: {'rng': UuidUtil.cryptoRNG});

    // 在Firebase建立路徑給去背後的圖片保存
    // final ref = FirebaseStorage.instance.ref().child('images/$name.jpg');   // 使用隨機名稱
    final ref = FirebaseStorage.instance.ref().child('images/$imageName.jpg');

    // url變數為上傳至Firebase後的圖片連結
    var url;

    // "putfile" 用來將圖片上傳到Firebase上
    await ref.putFile(File(imageData)).onComplete.then((value) async {
      url = await ref.getDownloadURL();
      print("圖片名稱:" + imageName + ".jpg");
      print("圖片連結:" + url);
      print("成功上傳到Firebase Storage");
    });
  }

  String imageData;
  bool dataLoaded = false; // 圖片回傳預設 = false，代表初始還沒去背狀態

  // 3-2 初始化GoogleDrive
  final drive = GoogleDrive();
  Widget build(BuildContext context) {
    if (dataLoaded) {
      // drive.upload(File(imageData));   // 3-2-1執行上傳動作
      _startUpload();
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
