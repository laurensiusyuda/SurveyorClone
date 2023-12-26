// ignore_for_file: use_key_in_widget_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/View/Widget/Camera/Priview.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cameraC = Get.find<CameraLocationController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Foto Survei',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),

      //* Image Data
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Container(
            height: MediaQuery.of(context).size.height -
                150, // Adjust the height as needed
            child: Obx(
              () => cameraC.isSavingImage.value
                  ? Center(
                      child: Container(
                        color: Colors.transparent,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: cameraC.ImageList.length,
                      itemBuilder: (context, index) {
                        var imageData = cameraC.ImageList[index];

                        return GestureDetector(
                          onTap: () {
                            showImagePreviewComp(context, imageData.ImagePath,
                                imageData.Description);
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.memory(
                                    imageData.ImagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),

      // Add FloatingActionButton with increased size
      floatingActionButton: SizedBox(
        width: 180.0,
        height: 50.0,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RouteName.camera);
          },
          backgroundColor: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Tambahkan Gambar',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
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
