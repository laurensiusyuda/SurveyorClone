// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_null_comparison
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyor_clone/Model/ImageData.dart';
import 'package:surveyor_clone/Controller/GeoLocationControl.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CameraLocationController extends GetxController {
  //! List ImagePath (Uint8List)
  List<Uint8List> ImagePath = <Uint8List>[].obs;

  //! Save Image to Model (ImagedataModel with Description)
  var selectedImagePathModel = ''.obs;
  var selectedImageSizeModel = ''.obs;
  var selectedImageResizePathModel = ''.obs;
  var selectedImageResizeSizeModel = ''.obs;
  final isSaveButtonEnabled = true.obs;
  final isSavingImage = false.obs; // Added to track the saving state
  final errorMessage = ''.obs;
  var ImageList = <ImageData>[].obs;

  late final GeoLocationController geoController;
  late final ScreenshotController saveImage;

  @override
  void onInit() {
    super.onInit();
    saveImage = ScreenshotController();
    geoController = Get.put(GeoLocationController());
  }

  //! Get image
  Future<void> getImageCamera(ImageSource imagesource) async {
    try {
      final pickedfile = await ImagePicker().pickImage(source: imagesource);
      if (pickedfile != null) {
        //* Task one
        //! 1. Give value and size (selectedImagePath)
        selectedImagePathModel.value = pickedfile.path;
        selectedImageSizeModel.value =
            "${((File(selectedImagePathModel.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}MB";

        //*Task two
        //! 2. Resize Image
        final dir = Directory.systemTemp;
        final targetPath =
            "${dir.absolute.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg";
        var compressedFile = await FlutterImageCompress.compressAndGetFile(
          pickedfile.path,
          quality: 60,
          targetPath,
        );

        if (compressedFile != null) {
          //* Task Three
          //! 3. Give value and size (selectedImageResize)
          selectedImageResizePathModel.value = compressedFile.path;
          selectedImageResizeSizeModel.value =
              "${((File(selectedImageResizePathModel.value)).lengthSync() / (1024 * 1024)).toStringAsFixed(2)} Mb";

          //* Task Four
          //! 4. Get date time dan location
          geoController.updateFormattedDateTime(geoController.now);
          geoController.getCurrentPosition();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //! Add image
  Future<void> addImage(
      TextEditingController descriptionController, screen) async {
    try {
      isSavingImage.value = true; // Set loading state
      final saveImageResult = await saveImage.captureFromWidget(screen);
      String description = descriptionController.text;
      ImageList.add(
          ImageData(ImagePath: saveImageResult, Description: description));
    } catch (e) {
      print(e);
    } finally {
      isSavingImage.value = false; // Reset loading state
    }
  }

  //! Delete image
  void deleteImage(Uint8List imageBytes, String description) {
    ImageList.removeWhere((imageData) =>
        imageData.ImagePath == imageBytes &&
        imageData.Description == description);
  }

  void updateImage() {}
}
