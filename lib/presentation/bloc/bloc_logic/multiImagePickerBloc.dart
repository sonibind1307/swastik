import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/Helper.dart';
import '../state/multi_image_state.dart';

class MultiImageCubit extends Cubit<MultiImageState> {
  MultiImageCubit() : super(InitialState()) {
    getImageList();
  }

  late XFile pickedImageFile;

  List<File> imageList = [];
  final ImagePicker _picker = ImagePicker();

  getImageList() {
    emit(LoadedState(imageList));
  }

  Future getCameraImage(BuildContext context) async {
    var pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 35);
    if (pickedFile != null) {
      pickedImageFile = pickedFile;
      File selectedImg = File(pickedImageFile.path);

      Helper().showCropAndOCRDialog(context, "Crop & OCR Iamge", selectedImg,
          callbackCancel: () {
        imageList.add(selectedImg);
        emit(LoadedState(imageList));
        Navigator.pop(context);
      }, callbackCrop: () {
        cropImage(selectedImg);
        Navigator.pop(context);
      }, callbackOcr: () {
        Helper.getToastMsg("Api call pending");
        // cropImage(selectedImg);
        Navigator.pop(context);
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
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ]));

    if (croppedFile != null) {
      imageList.add(File(croppedFile.path));
      emit(LoadedState(imageList));
    }
  }

  onDeleteImage(File file) {
    imageList.remove(file);
    emit(LoadedState(imageList));
  }

  void generatePDf() {}
}
