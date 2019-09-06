import 'package:flutter/material.dart';


class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
        centerTitle:true,
      ),
      body: new Center(
         child: Image.network('https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/homepage/header-illustration.png'),
      ),

    );
  }
}


class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
        centerTitle:true,
      ),
      body: new Center(
         child: Image.network('https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/homepage/header-illustration.png'),
      ),

    );
  }
}