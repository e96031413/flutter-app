import 'dart:async';
import 'dart:io';

import 'package:MainCamera/Layout/ChooseLayout.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:after_layout/after_layout.dart';

// 7. 列印照片主頁
void main() => runApp(PrintingApp());

class PrintingApp extends StatefulWidget {

  final String imagePath;

  PrintingApp({this.imagePath});

  @override
  _PrintingAppState createState() => _PrintingAppState();
}

class _PrintingAppState extends State<PrintingApp> with AfterLayoutMixin<PrintingApp> {

  // 7-1 列印照片Function
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
    // 7-2 列印照片後，進入挑選版型頁面，並刪除之前的所有路由，挑版型頁面變成第一層
    Navigator.of(context).pushNamedAndRemoveUntil('/chooseLayout', (Route<dynamic> route) => false);
}
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: ChooseLayoutScreen(imagePath: widget.imagePath));
  }
  void afterFirstLayout(BuildContext context) {
  _printDocument();
  }
}
