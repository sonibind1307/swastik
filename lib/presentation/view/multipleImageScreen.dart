import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/view/addInvoice/add_invoice_screen.dart';

import '../bloc/bloc_logic/multiImagePickerBloc.dart';
import '../bloc/state/multi_image_state.dart';

List<MemoryImage> imageLogo = [];
List<File> imageList = [];

class MultiImageScreen extends StatelessWidget {
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
                    builder: (context) => AddInvoiceScreen(
                      scheduleId: "",
                    ),
                  ),
                );
              } else {
                Helper.getSnackBarError(context, "Select image to create PDF");
              }

              // context.read<MultiImageCubit>().generatePDf();
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("Generate Pdf")),
        appBar: AppBar(
          title: const Text("Generate PDF"),
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
                      child: state.imageList[index - 1].path == null
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
}
