import 'package:MainCamera/CameraTaken/CameraTaken.dart';
import 'package:MainCamera/CameraTaken/PickFromGallery.dart';
import 'package:MainCamera/CameraTaken/BackGroundRemove.dart';
import 'package:MainCamera/ImageFilter/ImageFilter.dart';
import 'package:MainCamera/Layout/ChooseLayout.dart';
import 'package:MainCamera/Layout/Layout_default.dart';
import 'package:MainCamera/Layout/Layout_one.dart';
import 'package:MainCamera/Layout/Layout_three.dart';
import 'package:MainCamera/Layout/Layout_two.dart';
import 'package:MainCamera/PreviewImage/PreviewImage.dart';
import 'package:MainCamera/PrintingImage/PrintingImage.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'package:MainCamera/LoginAuth/login_page.dart';
import 'package:MainCamera/CameraTaken/DefaultPage.dart';
import 'package:MainCamera/routes.dart';

// import 'package:shared_preferences/shared_preferences.dart'; 如需要alert對話窗(首次啟動顯示，再uncomment)

// 1. 主畫面(登入Google帳號)
void main() => runApp(MyAppMain());

class MyAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkPermissions(context);  // 確認權限
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {       //建立Route
        MainCameraRoutes.loginPage: (context) => LoginPage(),
        MainCameraRoutes.deafultPage: (context) => DefaultPage(),
        MainCameraRoutes.cameraTaken: (context) => CameraScreen(),
        MainCameraRoutes.fromGallery: (context) => FromGalleryScreen(),
        MainCameraRoutes.previewImage: (context) => PreviewImageScreen(),
        MainCameraRoutes.imageFilter: (context) => ImageFilterScreen(),
        MainCameraRoutes.chooseLayout: (context) => ChooseLayoutScreen(),
        MainCameraRoutes.layoutDefault: (context) => LayoutDefaultScreen(),
        MainCameraRoutes.layoutOne: (context) => LayoutOneScreen(),
        MainCameraRoutes.layoutTwo: (context) => LayoutTwoScreen(),
        MainCameraRoutes.layoutThree: (context) => LayoutThreeScreen(),
        MainCameraRoutes.imageLayout: (context) => ImageLayoutScreen(),
        MainCameraRoutes.printApp: (context) => PrintingApp(),
      },
      onGenerateRoute: (settings) {    //預設進入LoginPage()
        switch (settings.name) {
          case MainCameraRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
            }
          },
        );
      }
  }
  // 1-1 確認APP權限Function
  Future<void> checkPermissions(BuildContext context) async {

    final PermissionState aks = await PermissionsPlugin.isIgnoreBatteryOptimization;

    PermissionState resBattery;
    if(aks != PermissionState.GRANTED)
      resBattery = await PermissionsPlugin.requestIgnoreBatteryOptimization;

    print(resBattery);
    
    // 1-1-1確定相機、外部儲存空間寫入權限
    Map<Permission, PermissionState> permission = await PermissionsPlugin
        .checkPermissions([
      Permission.CAMERA,
      Permission.READ_EXTERNAL_STORAGE,
      Permission.WRITE_EXTERNAL_STORAGE
    ]);

    // 1-1-2 假如權限設定不通過，再次設定權限
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
      // 1-1-3 假如權限設定通過，顯示授權成功；否則進入權限授權失敗Function
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
  // 1-1-3 APP權限授權失敗處理Function
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
