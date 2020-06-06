import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/CameraTaken/CameraTaken.dart';
import 'package:MainCamera/CameraTaken/PickFromGallery.dart';
import 'dart:async';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'package:MainCamera/LoginAuth/login_page.dart';
// import 'package:shared_preferences/shared_preferences.dart'; 如需要alert對話窗(首次啟動顯示，再uncomment)

void main() => runApp(MyAppMain());

class MyAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
          '/MyHomePage': (BuildContext context) => new MyHomePage(),
          '/CameraScreen' : (BuildContext context) => new CameraScreen(),
          '/FromGalleryScreen' : (BuildContext context) => new FromGalleryScreen(),
        },
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatelessWidget {
  // final keyIsFirstLoaded = 'is_first_loaded';
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context)); // 提示權限允許
    checkPermissions(context);  // 確認權限
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child:SingleChildScrollView(
        child: Container(
        child: 
        ResponsiveGridRow(
                children: [ResponsiveGridCol(
                    lg: 12,
                    child: Container(
                      height: 562,
                      alignment: Alignment.center,
                      color: Colors.purpleAccent,
                      child: Text('廣告頁', style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      child: Container(
                        height: 60,
                      child: new RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("拍照", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return CameraScreen();
                            },
                          ),
                        );
                      },
                    ),
                    ),
                  ),
                  ),
                  ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      child: Container(
                        height: 60,
                      child: new RaisedButton(
                      color: Colors.yellowAccent,
                      child: Text("從手機取得圖片", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FromGalleryScreen();
                            },
                          ),
                        );                      },
                    ),
                    ),
                  ),
                  )
                  ]
        ),
        
    ),
      ),
        ),

    );
  }
  
  // 確認權限
  Future<void> checkPermissions(BuildContext context) async {

    final PermissionState aks = await PermissionsPlugin.isIgnoreBatteryOptimization;

    PermissionState resBattery;
    if(aks != PermissionState.GRANTED)
      resBattery = await PermissionsPlugin.requestIgnoreBatteryOptimization;

    print(resBattery);
    
    Map<Permission, PermissionState> permission = await PermissionsPlugin
        .checkPermissions([
      Permission.CAMERA,
      Permission.READ_EXTERNAL_STORAGE,
      Permission.WRITE_EXTERNAL_STORAGE
    ]);

    if( permission[Permission.CAMERA] != PermissionState.GRANTED || 
        permission[Permission.READ_EXTERNAL_STORAGE] != PermissionState.GRANTED ||
        permission[Permission.WRITE_EXTERNAL_STORAGE] != PermissionState.GRANTED){

      try {
        permission = await PermissionsPlugin
            .requestPermissions([
          Permission.CAMERA,
          Permission.READ_EXTERNAL_STORAGE,
          Permission.WRITE_EXTERNAL_STORAGE
        ]);
      } on Exception {
        debugPrint("Error");
      }

      if( permission[Permission.CAMERA] == PermissionState.GRANTED &&
          permission[Permission.READ_EXTERNAL_STORAGE] == PermissionState.GRANTED &&
          permission[Permission.WRITE_EXTERNAL_STORAGE] == PermissionState.GRANTED
          )
        print("授權成功");
      else
        permissionsDenied(context);

    } else {
      print("授權成功");
    }
  }

  void permissionsDenied(BuildContext context){
    showDialog(context: context, builder: (BuildContext _context) {
      return SimpleDialog(
        title: const Text("權限授權失敗"),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
            child: const Text(
              "請重新啟動APP，再次確認應用權限，確保APP功能運作正常",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54
              ),
            ),
          )
        ],
      );
    });
  }

//   // AlertDialog對話框
//   showDialogIfFirstLoaded(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
//     if (isFirstLoaded == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           // return object of type Dialog
//           return AlertDialog(
//             title: new Text("注意事項："),
//             content: new Text("首次使用，請先啟動所有APP使用權限，再重啟APP執行。"),
//             actions: <Widget>[
//               // usually buttons at the bottom of the dialog
//               new FlatButton(
//                 child: new Text("了解！"),
//                 onPressed: () {
//                   // Close the dialog
//                   prefs.setBool(keyIsFirstLoaded, false);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// 
}