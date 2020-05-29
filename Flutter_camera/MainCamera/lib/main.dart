import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/CameraTaken.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatelessWidget {
  final keyIsFirstLoaded = 'is_first_loaded';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照APP"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child:SingleChildScrollView(
        child: Container(
        child: 
        ResponsiveGridRow(
                children: [ResponsiveGridCol(
                    lg: 12,
                    child: Container(
                      height: 300,
                      alignment: Alignment.center,
                      color: Colors.purpleAccent,
                      child: Text('廣告頁', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 12,
                    md: 12,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: new RaisedButton(
                      color: Colors.yellowAccent,
                      child: Text("拍照", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => new CameraScreen()),
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
  }
    showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("注意事項："),
            content: new Text("首次使用，請先啟動所有APP使用權限，再重啟APP執行。"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("了解！"),
                onPressed: () {
                  // Close the dialog
                  prefs.setBool(keyIsFirstLoaded, false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}