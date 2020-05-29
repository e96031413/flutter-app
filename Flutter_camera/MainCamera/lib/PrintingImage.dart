import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';


void main() => runApp(PrintingApp());

class PrintingApp extends StatefulWidget {
  final String imagePath;

  PrintingApp({this.imagePath});

  @override
  _PrintingAppState createState() => _PrintingAppState();
}

class _PrintingAppState extends State<PrintingApp> {

  Future<void> _printDocument() async {
    final doc = pw.Document();
    Printing.layoutPdf(
      onLayout: (pageFormat) async {
        final PdfImage image = await pdfImageFromImageProvider(pdf: doc.document, image: FileImage(File(widget.imagePath)));
        doc.addPage(pw.Page(
            build: (pw.Context context) => pw.Center(
              child: pw.Image(image),
            ),
          ),
        );
        return doc.save();
      },
    );
    
  }
  @override
  Widget build(BuildContext context) {
    const title = '列印照片';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Center(
          child: RaisedButton(
            color: Colors.blueAccent,
            onPressed: _printDocument,
            child: Text("點我開始列印",
            style:
            TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
