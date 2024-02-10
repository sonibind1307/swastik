import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:swastik/presentation/view/multipleImageScreen.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => generatePdf(),
      ),
    );
  }

  pw.Widget buildPdfImage(MemoryImage memoryImage) {
    final Uint8List imageData = memoryImage.bytes;
    final pdfImage = pw.MemoryImage(imageData);
    return pw.Image(pdfImage);
  }

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    for (MemoryImage memoryImage in imageLogo) {
      pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) => [
              // Header
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: const pw.EdgeInsets.only(top: 10.0),
                child: pw.Text('Header Text'),
              ),
              // Image
              pw.SizedBox(
                height: 10
              ),
              pw.Center(
                child: buildPdfImage(memoryImage),
              ),
              pw.SizedBox(
                  height: 10
              ),
              // Footer
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: const pw.EdgeInsets.only(bottom: 10.0),
                child: pw.Text('Date : ${DateTime.now()}',style: const pw.TextStyle(
                  fontSize: 20
                )),
              ),


            ],
          ),

      //     pw.Page(
      //   build: (context) => pw.Column(
      //     children: [
      //       pw.Center(
      //         child: buildPdfImage(memoryImage),
      //       ),
      //     ]
      //   )
      // )
      );
    }

    // Get temporary directory or application documents directory
    final directory = await getApplicationDocumentsDirectory();
    // final directory = await getApplicationDocumentsDirectory();

    // Create the path for the PDF file
    final path = '${directory.path}/example.pdf';

    // Save the PDF to the path
    final File file = File(path);

    await file.writeAsBytes(await pdf.save());

   // debugPrint("Soni ==> $path");

    return pdf.save();
  }
}
