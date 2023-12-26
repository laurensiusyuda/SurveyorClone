// ignore_for_file: file_names
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';

void showImagePreviewComp(
    BuildContext context, Uint8List imageBytes, String description) {
  final cameraC = Get.find<CameraLocationController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.memory(imageBytes),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ),
            ),
            // Tambahkan elemen UI lainnya di sini sesuai kebutuhan
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Konfirmasi',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04),
                            ),
                          ),
                          content: Text(
                            'Apakah Anda yakin ingin menghapus gambar ini?',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                //goto foto survei page
                                Get.back();
                                Get.back();
                              },
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                cameraC.deleteImage(imageBytes, description);

                                //goto foto survei page
                                Get.back();
                                Get.back();
                              },
                              child: const Text('Ya, Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
