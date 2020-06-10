import 'dart:async';
import 'dart:io';

import 'package:MainCamera/GoogleDrive/secureStorage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

final flutterWebViewPlugin = FlutterWebviewPlugin();

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

const _clientId =
    "1062803653008-c6ugsupfv37m5e3l8u5g2np6cl8lfhuc.apps.googleusercontent.com";
const _clientSecret = "RwU67T9UBtOBc2rfHhxPDsAh";
const _scopes = [ga.DriveApi.DriveFileScope];

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
        // launch(url);    //會跳出Chrome要求登入，只需一次
        flutterWebViewPlugin.launch(
          url,
          userAgent: kAndroidUserAgent,
        );
      });
      await flutterWebViewPlugin.close();
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

  // 登入Google Drive
  Future login() async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    print("登入中...");
    var response = await drive.files.list();
    print("Result ${response.toJson()}");
  }

  // 上傳檔案到Google Drive
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
