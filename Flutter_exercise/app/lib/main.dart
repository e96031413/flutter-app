import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}


//--------------------floatingActionButton 漂浮按鈕-----------------------
//                 floatingActionButton必須放在Scafold裡面
//--------------------floatingActionButton 漂浮按鈕-----------------------
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
        body: MultiDataPage(),                                     // body: XXX()決定畫面要顯示什麼內容
        //注意floatingActionButton是放在在 Scaffold 裡面喲!!
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          foregroundColor: Colors.amber,
          backgroundColor: Colors.red,
          child: Icon(Icons.add_a_photo),
          onPressed: () {
            print('高雄發大財...');
          },
        ),
      ),
    );
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

//--------------------------換頁功能--------------------------


// 換頁功能ToDifferentPage
class ToDifferentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('跳到 B 頁'),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BBPage()));
        },
      ),
    );
  }
}

// 跳到B頁
class BBPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是 B 頁'),
      ),
      body: __BPage(),      // B頁顯示_BPage中的內容
    );
  }
}

class __BPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('返回首頁'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

//--------------------------換頁功能--------------------------



//--------------------------從Ａ頁跳到Ｂ頁，並傳遞資料--------------------------
class DataToPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('跳到 B 頁'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BBBPage(intVal: 100, strVal: 'HKT線上教室')));
        },
      ),
    );
  }
}

class BBBPage extends StatelessWidget {
  int intVal;
  String strVal;

  BBBPage({Key key, this.intVal, this.strVal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是 B 頁'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('intVal: $intVal'),
              Text('strVal: $strVal')
            ]),
      ),
    );
  }
}
//--------------------------從Ａ頁跳到Ｂ頁，並傳遞資料--------------------------


//--------------------------從Ｂ頁返回Ａ頁並傳回資料--------------------------
class BtoAwithData extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BtoAwithData> {
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HKT 線上教室'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('跳到 B 頁'),
            onPressed: () {
              goToBPage(context);
            },
          ),
          Text('返回值：$result')
        ],
      ),
    );
  }

  void goToBPage(BuildContext context) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BAPage()),
    );
  }
}

class BAPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是 B 頁'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回首頁'),
          onPressed: () {
            Navigator.pop(context, 'B頁資料666666');
          },
        ),
      ),
    );
  }
}
//--------------------------從Ｂ頁返回Ａ頁並傳回資料--------------------------

//--------------------------從A頁傳大量資料到B頁--------------------------
class MultiDataPage extends StatelessWidget {
  Product product = new Product('產品名稱xxx', '產品內容xxx', 100, 66);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('跳到Ｂ頁'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SPage(product: product)),
          );
        },
      ),
    );
  }
}

class SPage extends StatelessWidget {
  final Product product;

  SPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.red,
        title: Text('我是 B 頁')
      ),
      body: Column(
        children: <Widget>[
          Text('產品名稱：${product.name}'),
          Text('產品描述：${product.desc}'),
          Text('產品售價：${product.price}'),
          Text('產品庫存：${product.stock}'),
          RaisedButton(
            child: Text('返回首頁'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class Product {
  //產品名稱
  String name;

  //產品描述
  String desc;

  //產品售價
  int price;

  //產品庫存
  int stock;

  Product(this.name, this.desc, this.price, this.stock);
}
//--------------------------從A頁傳大量資料到B頁--------------------------

