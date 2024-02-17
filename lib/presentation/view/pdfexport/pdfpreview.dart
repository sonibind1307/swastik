import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:swastik/presentation/view/multipleImageScreen.dart';

import '../../../config/Helper.dart';

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
    try {
      for (MemoryImage memoryImage in imageLogo) {
        // pdf.addPage(pw.Page(
        //     build: (context) => pw.Column(children: [
        //           pw.Align(
        //               alignment: pw.Alignment.centerRight,
        //               child: pw.Text('User Name : soni.b')),
        //           pw.Center(
        //             child: pw.Container(child: buildPdfImage(memoryImage)),
        //           ),
        //           pw.Align(
        //               alignment: pw.Alignment.centerRight,
        //               child: pw.Text(
        //                   'Date : ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now())}')),
        //         ])));

        pdf.addPage(
          pw.Page(
            build: (context) => pw.Wrap(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text('User Name : soni.b'),
                    ),
                    pw.Center(
                      child: pw.Container(child: buildPdfImage(memoryImage)),
                    ),
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        'Date : ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now())}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
    } catch (e) {
      Helper.getToastMsg(e.toString());
    }

    // debugPrint("Soni ==> $path");

    return pdf.save();
  }
}
