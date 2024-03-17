import 'package:flutter/material.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfUrlView extends StatefulWidget {
  final String url;
  final String title;
  final String amount;

  const PdfUrlView(
      {super.key,
      required this.url,
      required this.title,
      required this.amount});

  @override
  State<PdfUrlView> createState() => _PdfUrlViewState();
}

class _PdfUrlViewState extends State<PdfUrlView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Spacer(),
                  CustomTextStyle.regular(text: "Total amount :"),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomTextStyle.bold(text: widget.amount),
                ],
              ),
            ),
          )
        ],
      ),
      // SfPdfViewer.network(url,
      // )
    );
  }
}
