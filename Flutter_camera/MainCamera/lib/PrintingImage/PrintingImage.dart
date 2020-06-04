import 'dart:async';
import 'dart:io';

import 'package:MainCamera/Layout/ChooseLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:after_layout/after_layout.dart';
import 'package:MainCamera/CameraTaken/preview_screen.dart';


void main() => runApp(PrintingApp());

class PrintingApp extends StatefulWidget {

  final String imagePath;

  PrintingApp({this.imagePath});

  @override
  _PrintingAppState createState() => _PrintingAppState();
}

class _PrintingAppState extends State<PrintingApp> with AfterLayoutMixin<PrintingApp> {

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
    Navigator.push(context,new MaterialPageRoute(
      // builder: (context) => new ChooseLayoutScreen(imagePath: widget.imagePath)), //ImageFilterScreen
      // builder: (context) => new ImageFilterScreen(imagePath: widget.imagePath)), //ImageFilterScreen
      builder: (context) => new PreviewImageScreen(imagePath: widget.imagePath)), //ImageFilterScreen
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return new MaterialApp(home: ChooseLayoutScreen(imagePath: widget.imagePath));
  }
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
  _printDocument();
  }
}
