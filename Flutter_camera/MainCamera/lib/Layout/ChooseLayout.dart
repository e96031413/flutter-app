import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:MainCamera/Layout/Layout_one.dart';
import 'package:MainCamera/Layout/Layout_two.dart';
import 'package:MainCamera/Layout/Layout_three.dart';
import 'package:MainCamera/Layout/Layout_default.dart';

// 6. 挑版型主頁
void main() => runApp(ChooseLayoutScreen());

class ChooseLayoutScreen extends StatefulWidget {
  final String imagePath;
  ChooseLayoutScreen({this.imagePath});
  @override
  _ChooseLayoutScreenState createState() => _ChooseLayoutScreenState();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("拍照APP"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent),
    );
  }
}

// 6-1 挑版型主頁(靜態UI)
class _ChooseLayoutScreenState extends State<ChooseLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("挑版型"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            child: ResponsiveGridRow(children: [
              ResponsiveGridCol(
                xs: 12,
                md: 12,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(800)),
                  child: new RaisedButton(
                      color: Colors.cyanAccent,
                      child: Text("1吋",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LayoutOneScreen(
                                  imagePath:
                                      widget.imagePath)), // 6-1-1 進入1吋版型頁面
                        );
                      }),
                ),
              ),
              ResponsiveGridCol(
                xs: 12,
                md: 12,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(800)),
                  child: new RaisedButton(
                      color: Colors.cyanAccent,
                      child: Text("2吋",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LayoutTwoScreen(
                                  imagePath:
                                      widget.imagePath)), // 6-1-2 進入2吋版型頁面
                        );
                      }),
                ),
              ),
              ResponsiveGridCol(
                xs: 12,
                md: 12,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(800)),
                  child: new RaisedButton(
                      color: Colors.cyanAccent,
                      child: Text("1吋+2吋",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LayoutThreeScreen(
                                  imagePath:
                                      widget.imagePath)), // 6-1-3 進入1吋+2吋版型頁面
                        );
                      }),
                ),
              ),
              ResponsiveGridCol(
                xs: 12,
                md: 12,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(800)),
                  child: new RaisedButton(
                      color: Colors.cyanAccent,
                      child: Text("合成照",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ColorChange(
                                imagePath:
                                      widget.imagePath)), // 6-1-4 進入合成照版型頁面
                        );
                      }),
                ),
              ),
            ]),
          )),
        ));
  }
}
