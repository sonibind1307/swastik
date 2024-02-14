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
  final Function onSubmit;
  final bool isEdit;

  MultiImageScreen({super.key, required this.isEdit, required this.onSubmit});

  @override
  State<MultiImageScreen> createState() => _MultiImageScreenState();
}

class _MultiImageScreenState extends State<MultiImageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MultiImageCubit(),
      child: WillPopScope(
        onWillPop: () async {
          widget.onSubmit();
          return true;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (imageList.isNotEmpty) {
                  imageLogo = convertFilesToMemoryImages(imageList);
                  if (widget.isEdit == true) {
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddInvoiceScreen(
                          scheduleId: "",
                        ),
                      ),
                    );
                    generatePdf();
                  }
                  widget.onSubmit();
                } else {
                  Helper.getToastMsg("Select image to create PDF");
                }
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
                  itemCount:
                      state.imageList.length + 1, // Add 1 for the "Add" button
                  itemBuilder: (BuildContext context, int index) {
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
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                color: Colors.grey.withOpacity(0.5),
                                child: Stack(
                                  children: [
                                    const Center(
                                        child: CircularProgressIndicator()),
                                    Image.file(
                                      File(state.imageList[index - 1].path),
                                      height: 180,
                                      width: 180,
                                      gaplessPlayback: true,
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: InkWell(
                                        onTap: () {
                                          Helper.deleteDialog(context,
                                              "Do you want to delete an image",
                                              () {
                                            context
                                                .read<MultiImageCubit>()
                                                .onDeleteImage(
                                                    state.imageList[index - 1]);
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(16))),
                                              child: const Icon(
                                                  Icons.delete_forever)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
