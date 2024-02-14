import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/view/addInvoice/add_invoice_screen.dart';

import '../bloc/bloc_logic/multiImagePickerBloc.dart';
import '../bloc/state/multi_image_state.dart';

List<MemoryImage> imageLogo = [];
List<File> imageList = [];

class MultiImageScreen extends StatefulWidget {
  @override
  State<MultiImageScreen> createState() => _MultiImageScreenState();
}

class _MultiImageScreenState extends State<MultiImageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MultiImageCubit(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (imageList.isNotEmpty) {
                imageLogo = convertFilesToMemoryImages(imageList);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => PdfPreviewPage(),
                //   ),
                // );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddInvoiceScreen(
                      scheduleId: "",
                    ),),);
                generatePdf();
              } else {
                Helper.getSnackBarError(context, "Select image to create PDF");
              }

              // context.read<MultiImageCubit>().generatePDf();
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("Create")),
        appBar: AppBar(
          title: const Text("Create New Invoice"),
        ),
        body: BlocConsumer<MultiImageCubit, MultiImageState>(
          builder: (BuildContext context, state) {
            if (state is LoadedState) {
              imageList = state.imageList;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: state.imageList.length + 1, // Add 1 for the "Add" button
                itemBuilder: (BuildContext context, int index) {
                  var placeholder = Image.asset(
                    'assets/img/png/image_placeholder.png',
                    height: 50,
                    width: 50,
                  );
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        context.read<MultiImageCubit>().getCameraImage();
                      },
                      child: Container(
                        color: Colors.grey.withOpacity(0.5),
                        child: const Icon(Icons.add),
                      ),
                    );
                  } else {
                    return ClipRRect(
                      child: state.imageList[index - 1].path.isEmpty
                          ? const CircularProgressIndicator()
                          : Image.file(
                              File(state.imageList[index - 1].path),
                              height: 200,
                              width: 200,
                              gaplessPlayback: true,
                            ),
                    );
                  }
                },
              );
            }
            return Container();
          },
          listener: (BuildContext context, state) {},
        ),
      ),
    );
  }

  List<MemoryImage> convertFilesToMemoryImages(List<File> imageFiles) {
    return imageFiles.map((File file) {
      Uint8List bytes = file.readAsBytesSync();
      return MemoryImage(Uint8List.fromList(bytes));
    }).toList();
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
            pw.SizedBox(height: 10),
            pw.Center(
              child: buildPdfImage(memoryImage),
            ),
            pw.SizedBox(height: 10),
            // Footer
            pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 10.0),
              child: pw.Text('Date : ${DateTime.now()}',
                  style: const pw.TextStyle(fontSize: 20)),
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

    debugPrint("Soni ==> $path");

    return pdf.save();
  }
}
