import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/view/addInvoice/add_invoice_screen.dart';

import '../bloc/bloc_logic/multiImagePickerBloc.dart';
import '../bloc/state/multi_image_state.dart';

class MultiImageScreen extends StatefulWidget {
  final Function(List<MemoryImage> imageLogo) onSubmit;
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
              onPressed: () {
                if (imageList.isNotEmpty) {
                  imageLogo = convertFilesToMemoryImages(imageList);
                  if (widget.isEdit == true) {
                    widget.onSubmit(imageLogo);
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddInvoiceScreen(
                          scheduleId: "",
                          imageLogo: imageLogo,
                        ),
                      ),
                    );
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
