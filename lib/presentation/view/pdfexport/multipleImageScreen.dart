import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/Helper.dart';

import '../../bloc/bloc_logic/multiImagePickerBloc.dart';
import '../../bloc/state/multi_image_state.dart';
import '../invoice/add_invoice_screen.dart';

class MultiImageScreen extends StatefulWidget {
  final Function(List<MemoryImage> imageLogo, List<File> imageList) onSubmit;
  final bool isEdit;

  MultiImageScreen({super.key, required this.isEdit, required this.onSubmit});

  @override
  State<MultiImageScreen> createState() => _MultiImageScreenState();
}

class _MultiImageScreenState extends State<MultiImageScreen> {
  List<MemoryImage> imageLogo = [];
  List<File> imageList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MultiImageCubit(),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          // widget.onSubmit();
          return true;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                if (imageList.isNotEmpty) {
                  imageLogo = convertFilesToMemoryImages(imageList);
                  if (widget.isEdit == true) {
                    widget.onSubmit(imageLogo, imageList);
                    Navigator.pop(context);
                  } else {
                    // await ImageToPdf.imageList(listOfFiles: data.fileList)
                    //     .then((value) async {
                    //   data.pdf.value = File(value.path);
                    // Get.to(const ExitScreen());
                    //await OpenFilex.open(value.path);
                    // final bytes = await value.save();
                    // await value.writeAsBytes(bytes,flush: true);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddInvoiceScreen(
                          scheduleId: "",
                          imageLogo: imageLogo,
                          imageList: imageList,
                        ),
                      ),
                    );
                    // });

                    // generatePdf();
                  }
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

  @override
  void initState() {
    imageLogo.clear();
    imageList.clear();
  }
}
