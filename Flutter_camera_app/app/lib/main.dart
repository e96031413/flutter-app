import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context){
        return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.red,
          title: Text("Hello World"),
        ),
        body: TextINPUT(),
        ));
      }
}

// HomePage頁面在上方的body切換
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(          
          alignment:Alignment.center,
          child: Text('發大財'),
          color: Colors.amber,);
  }
}

// Box頁面在上方的body切換
class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(          
          alignment:Alignment.center,
          child: Text('韓國瑜\n2',maxLines: 2,

          style: TextStyle
          (
          fontSize: 30, 
          color: Colors.green,
          decoration: TextDecoration.lineThrough,
          fontWeight: FontWeight.bold
          )
          ),
          
          color: Colors.red,
          constraints: BoxConstraints(
            maxWidth: 300, maxHeight: 600),
          margin: EdgeInsets.all(50),
          );
  }
}

// NumberWithRow(Row包了Container)頁面在上方的body切換
class NumberWithRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.amber,
          child: Text('1', style: TextStyle(fontSize: 100)),
        ),
        Container(
          color: Colors.red,
          child: Text('2', style: TextStyle(fontSize: 100)),
        ),
        Container(
          color: Colors.green,
          child: Text('3\n\n2', style: TextStyle(fontSize: 100)),
        )
      ],
    );
  }
}

// LOGO頁面在上方的body切換
class LOGO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //↓↓↓更改此處程式碼↓↓↓
    return Center(
      child: FlutterLogo(size: 200, colors: Colors.red),
    );
  }
}

// BUTTON在上方的body切換
class BUTTON extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      child: Text('按鈕'),
      onPressed: btnClickEvent,
      color: Colors.red,
      textColor: Colors.yellow,
      elevation: 20,
    ));
  }

  void btnClickEvent() {
    print('韓國瑜...');
  }
}

// LocalImage在上方的body切換
class LocalImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}

// NetworkImage在上方的body切換
class NetworkImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(child: Image.network('https://i.imgur.com/ZX0PtRb.png')),
    );
  }
}

// TextINPUT在上方的body切換
class TextINPUT extends StatelessWidget {
  final TextEditingController myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            controller: myController,
            decoration: InputDecoration(hintText: '請輸入...'),
          ),
          RaisedButton(
            child: Text('印出輸入框內容'),
            onPressed: btnEvent,
          )
        ],
      ),
    );
  }
  void btnEvent() {
    print(myController.text);
  }
}