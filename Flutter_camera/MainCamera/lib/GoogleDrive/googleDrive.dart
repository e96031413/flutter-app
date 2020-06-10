import 'dart:async';
import 'dart:io';

import 'package:MainCamera/GoogleDrive/secureStorage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

// 1-4 登入Google Drive的Function
final flutterWebViewPlugin = FlutterWebviewPlugin(); // 1-4-1建立WebView視窗

// 1-4-2 建立User Agent繞過Google封鎖
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

const _clientId =
    "1062803653008-c6ugsupfv37m5e3l8u5g2np6cl8lfhuc.apps.googleusercontent.com";
const _clientSecret = "RwU67T9UBtOBc2rfHhxPDsAh";
const _scopes = [ga.DriveApi.DriveFileScope];

// 1-4-3 建立一個GoogleDrive登入驗證的Class
class GoogleDrive {
  final storage = SecureStorage();
  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();
    if (credentials == null) {
      //Needs user authentication
      var authClient = await clientViaUserConsent(
          ClientId(_clientId, _clientSecret), _scopes, (url) {
        //Open Url in Browser
        flutterWebViewPlugin.launch(
          // 1-4-4 使用WebView開啟驗證頁面的url、搭配userAgent
          url,
          userAgent: kAndroidUserAgent,
        );
      });
      await flutterWebViewPlugin.close(); // 1-4-5 當驗證任務完成後，自動關閉WebView
      //Save Credentials
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken);
      return authClient;
    } else {
      print(credentials["expiry"]);
      //Already authenticated
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credentials["type"], credentials["data"],
                  DateTime.tryParse(credentials["expiry"])),
              credentials["refreshToken"],
              _scopes));
    }
  }

  // 1-4-6 登入Google Drive的Function
  Future login() async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    print("登入中...");
    var response = await drive.files.list();
    print("Result ${response.toJson()}");
  }

  // 1-4-7 上傳檔案到Google Drive的Function
  Future upload(File file) async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    print("上傳資料中...");
    var response = await drive.files.create(
        ga.File()..name = p.basename(file.absolute.path),
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

    print("Result ${response.toJson()}");
  }
}
