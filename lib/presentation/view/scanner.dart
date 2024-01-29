import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FromGalleryPage extends StatefulWidget {
  const FromGalleryPage({super.key});

  @override
  State<FromGalleryPage> createState() => _FromGalleryPageState();
}

class _FromGalleryPageState extends State<FromGalleryPage> {
  bool imageIsSelected = false;
  final ImagePicker _picker = ImagePicker();
  late String profile_pic = '';
  File? drawing_img;
  late XFile pickedImageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            getCameraImage();
          },
          child: Container(
              color: Colors.red, child: const Text("Select Image by camera")),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            _uploadImage();
          },
          child: Container(
              color: Colors.yellow,
              child: const Text("Select Image By Gallery")),
        ),
        const SizedBox(
          height: 20,
        ),
        drawing_img == null
            ? const Text("")
            : ClipRRect(
                child: Image.file(
                  File(drawing_img!.path),
                  height: 100,
                  width: 200,
                ),
              ),
      ],
    ));
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

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = pickedFile;
        File selectedImg = File(pickedImageFile.path);
        cropImage(selectedImg);
      });
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
      setState(() {
        drawing_img = File(croppedFile.path);
        // isIconSelected= true;
      });
    }
  }
}
