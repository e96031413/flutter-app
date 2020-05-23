import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ShareImageScreen extends StatefulWidget {
  @override
  _ShareImageScreenState createState() => _ShareImageScreenState();
}

class _ShareImageScreenState extends State<ShareImageScreen> {
  File _image;
  var image;
  Directory directory;
  String bgPath;

  Future<void> _shareImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    directory  = await getApplicationDocumentsDirectory();
    bgPath = directory.uri.resolve('IMG_20200515_075806.jpg').path;
    
    setState(() {
      _image = image;
    });

    try {
      final ByteData bytes = image as ByteData;
      await Share.file(
          'Share via:', bgPath, bytes.buffer.asUint8List(), 'image/png',);
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
          onPressed: () {
                    getBytesFromFile().then((bytes) {
                      Share.file('Share via:', bgPath,
                          bytes.buffer.asUint8List(), 'image/png');
                    });
                  },
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
  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(bgPath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }
}

