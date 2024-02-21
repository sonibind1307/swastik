import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final List<MemoryImage> imageLogo;
  PdfPreviewPage({Key? key, required this.imageLogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => generatePdf(imageLogo!),
      ),
    );
  }

  pw.Widget buildPdfImage(MemoryImage memoryImage) {
    final Uint8List imageData = memoryImage.bytes;
    final pdfImage = pw.MemoryImage(imageData);
    return pw.Image(pdfImage);
  }

  Future<Uint8List> generatePdf(List<MemoryImage> imageLogo) async {
    final pdf = pw.Document();
    for (MemoryImage memoryImage in imageLogo) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [
            // Image
            pw.Container(
              width: 450,
              height: 600,
              child: pw.Center(child: buildPdfImage(memoryImage)),
            ),

            // Footer
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Username: soni.b, Date: ${DateTime.now()}',
                  style: const pw.TextStyle(fontSize: 20)),
            ),
          ],
        ),
      );
    }
    return pdf.save();
  }
}
