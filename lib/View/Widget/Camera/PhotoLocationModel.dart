import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';
import 'package:surveyor_clone/Controller/AuthController/GeoLocationControl.dart';

class ImageModelScreen extends GetView<CameraLocationController> {
  final cameraC = Get.find<CameraLocationController>();
  final geoController = Get.find<GeoLocationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cameraC.selectedImageResizePathModel.value == ''
          ? Text(
              'Silahkan Pilih Gambar',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Warna border
                        width: 1.0, // Lebar border
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(cameraC.selectedImageResizePathModel.value),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Time: ${geoController.formattedTime.value}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Date: ${geoController.formattedDate.value}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Longtitude: ${geoController.longitude.value}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Latitude: ${geoController.latitude.value}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Address: ${geoController.currentAddress.value}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
