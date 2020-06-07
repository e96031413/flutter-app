import 'package:flutter/material.dart';
import 'package:MainCamera/LoginAuth/sign_in.dart';
import 'package:get_mac/get_mac.dart'; // 取得mac地址
import 'package:flutter/services.dart';

// 1. 主畫面(登入Google帳號)
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState(); // 渲染此頁面時，執行取得Mac Address的函數
  }

  // 1-2 取得Mac Address的主函示
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  // 1-3 Sign In功能，當登入完成後，進入登入狀態頁面
  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          // 1-2-3 在Terminal顯示 Mac Address 的資訊
          print('MAC Address : $_platformVersion');
          // 1-3-1 登入成功後，進入DefaultPage頁面，並刪除之前的所有路由，該頁面變成第一層(使用者無法再回到登入頁面)
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/DefaultPage', (Route<dynamic> route) => false);
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '使用Google登入',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
