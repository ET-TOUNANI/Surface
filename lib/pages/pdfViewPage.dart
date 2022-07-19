import 'dart:io';
import 'package:exemple1/configs/AppBar.config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({
    required this.file,
  });

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GetAppBare(),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}