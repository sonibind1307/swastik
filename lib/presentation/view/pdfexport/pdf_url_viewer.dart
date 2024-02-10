import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfUrlView extends StatelessWidget {
  final String url;
  const PdfUrlView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: SfPdfViewer.network(url));
  }
}
