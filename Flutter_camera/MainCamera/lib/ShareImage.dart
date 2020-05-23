import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class ShareImageScreen extends StatefulWidget {
  @override
  _ShareImageScreenState createState() => _ShareImageScreenState();
}

class _ShareImageScreenState extends State<ShareImageScreen> {
  File _image;

  Future<void> _shareImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Directory directory  = await getApplicationDocumentsDirectory();
    String bgPath = directory.uri.resolve('IMG_20200515_075806.jpg').path;
    
    setState(() {
      _image = image;
    });

    try {
      final ByteData bytes = image as ByteData;
      await Share.file(
          'image', bgPath, bytes.buffer.asUint8List(), 'image/jpg',);
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          onPressed: () async => await _shareImage(),
          child: Text('分享照片'),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        )
      ],
      ),
      body: Center(
        child: _image == null
            ? Text('請選擇相片')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shareImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
      );
  }
  //   Future<ByteData> getBytesFromFile() async {
  //   Uint8List bytes = File(imagePath).readAsBytesSync() as Uint8List;
  //   return ByteData.view(bytes.buffer);
  // }
}

