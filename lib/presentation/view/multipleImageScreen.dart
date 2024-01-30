import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MultiImageScreen extends StatelessWidget {
  final List<String> items = List.generate(0, (index) => 'Item $index');

  bool imageIsSelected = false;
  final ImagePicker _picker = ImagePicker();
  late String profile_pic = '';
  File? drawing_img;
  late XFile pickedImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.image),
          label: const Text("Generate Pdf")),
      appBar: AppBar(
        title: const Text("Generate PDF"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: items.length + 1, // Add 1 for the "Add" button
        itemBuilder: (BuildContext context, int index) {
          if (index == items.length) {
            return InkWell(
              onTap: () {
                // Handle add button tap
                print('Add button tapped');
              },
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                child: Icon(Icons.add),
              ),
            );
          }
          return Container(
            color: Colors.blueAccent,
            alignment: Alignment.center,
            child: Text(items[index]),
          );
        },
      ),
    );
  }

  Future getCameraImage() async {
    var pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 35);
    if (pickedFile != null) {
      pickedImageFile = pickedFile;
      File selectedImg = File(pickedImageFile.path);
      cropImage(selectedImg);
    }
  }

  cropImage(File icon) async {
    CroppedFile? croppedFile = (await ImageCropper()
        .cropImage(sourcePath: icon.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ]));

    if (croppedFile != null) {
      // setState(() {
      //   drawing_img = File(croppedFile.path);
      //   // isIconSelected= true;
      // });
    }
  }
}
