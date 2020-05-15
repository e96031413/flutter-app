import 'package:flutter/material.dart';
import 'package:MainCamera/splash_page.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照APP"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child:       SingleChildScrollView(
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
                    xs: 4,
                    md: 3,
                    child: new RaisedButton(
                      color: Colors.green,
                      child: Text("濾鏡", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {}, 
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 4,
                    md: 3,
                    child: new RaisedButton(
                      color: Colors.orange,
                      child: Text("挑版型", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {},
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 4,
                    md: 3,
                    child: new RaisedButton(
                      color: Colors.red,
                      child: Text("分享", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {},
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 4,
                    child: new RaisedButton(
                      color: Colors.yellowAccent,
                      child: Text("拍照", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {},
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: new RaisedButton(
                      color: Colors.blueGrey,
                      child: Text("列印", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {},
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


  