// ignore_for_file: use_key_in_widget_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/View/Widget/Camera/PhotoLocationModel.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';

class CameraScreen extends StatelessWidget {
  final cameraC = Get.find<CameraLocationController>();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Camera View",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image screen
              ImageModelScreen(),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: descriptionController,
                    onChanged: (text) {
                      cameraC.isSaveButtonEnabled.value = text.isNotEmpty;
                    },
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                      labelText: 'Deskripsi',
                      hintText: 'Masukan Deskripsi',
                      border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
              ),

              // Real-time error notification
              Obx(
                () => Visibility(
                  visible: cameraC.errorMessage.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cameraC.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  await cameraC.getImageCamera(ImageSource.camera);
                },
                child: Text(
                  "Capture Photo",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: cameraC.isSaveButtonEnabled.value
                    ? () {
                        cameraC.errorMessage.value = '';
                        if (descriptionController.text.isNotEmpty) {
                          cameraC.addImage(
                              descriptionController, ImageModelScreen());
                          Get.offNamed(RouteName.details);
                        } else {
                          cameraC.errorMessage.value =
                              'Silahkan Masukan Deskripsi.';
                        }
                      }
                    : null,
                child: Text(
                  'Upload',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
