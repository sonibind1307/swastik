import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart';

Future<Uint8List> makePdf(List<File> imageList) async {
  List<Page> pageList = [];

  final file = File(imageList[0].path);
  Uint8List uint8List = await fileToUint8List(file);
  final imageLogo = MemoryImage(uint8List);
  final pdf = Document();

  pdf.addPage(Page(build: (context) {
    return Column(children: [
      SizedBox(
        height: 300,
        width: 300,
        child: Image(imageLogo),
      ),
      SizedBox(
        height: 300,
        width: 300,
        child: Image(imageLogo),
      ),
    ]);
  }));

  pdf.addPage(Page(build: (context) {
    return Column(children: [
      SizedBox(
        height: 300,
        width: 300,
        child: Image(imageLogo),
      ),
      SizedBox(
        height: 300,
        width: 300,
        child: Image(imageLogo),
      ),
    ]);
  }));
  return pdf.save();
}

Future<Uint8List> fileToUint8List(File file) async {
  List<int> bytes = await file.readAsBytes();
  return Uint8List.fromList(bytes);
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
