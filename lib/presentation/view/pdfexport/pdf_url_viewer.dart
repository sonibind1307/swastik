import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfUrlView extends StatefulWidget {
  final String url;
  const PdfUrlView({super.key, required this.url});

  @override
  State<PdfUrlView> createState() => _PdfUrlViewState();
}

class _PdfUrlViewState extends State<PdfUrlView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SfPdfViewer.network(
            widget.url,
            canShowPageLoadingIndicator: false,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _isLoading = false;
              });
            },
            key: _pdfViewerKey,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      // SfPdfViewer.network(url,
      // )
    );
  }
}
