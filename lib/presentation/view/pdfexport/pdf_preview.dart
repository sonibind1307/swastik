import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final List<MemoryImage> imageLogo;
  final List<File> imageList;
  PdfPreviewPage({Key? key, required this.imageLogo, required this.imageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => generatePdf(imageLogo, imageList),
      ),
    );
  }

  pw.Widget buildPdfImage(MemoryImage memoryImage) {
    final Uint8List imageData = memoryImage.bytes;
    final pdfImage = pw.MemoryImage(imageData);
    return pw.Image(pdfImage);
  }

  Future<Uint8List> generatePdf(
      List<MemoryImage> imageLogo, List<File> imageList) async {
    final pdf = pw.Document();
    for (var image in imageList) {
      var pdfImage = pw.MemoryImage(
        image!.readAsBytesSync(),
      );
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Stack(children: [
              pw.Image(pdfImage, fit: pw.BoxFit.contain),
              pw.Positioned(
                  bottom: 0,
                  right: 0,
                  child: pw.Text('Username: soni.b, Date: ${DateTime.now()}',
                      style: pw.TextStyle(fontSize: 16)))
            ]); // Center
          },
        ),
      );
    }
    return pdf.save();
  }
}
