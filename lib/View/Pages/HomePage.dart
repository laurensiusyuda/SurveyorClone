// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/Controller/LoginController.dart';
import 'package:surveyor_clone/Controller/AuthenticationManager.dart';
import 'package:surveyor_clone/View/Widget/Homepage/UserProfile.dart';
import 'package:surveyor_clone/Controller/DetailController/DetaiUserController.dart';

class HomeScreen extends StatelessWidget {
  final authManager = Get.find<AuthenticationManager>();
  final loginC = Get.find<LoginController>();
  final detailController = Get.find<DetailUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Surveyor TMI',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authManager.logOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: FutureBuilder(
        future: detailController.fetchDetailUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Obx(
              () {
                if (!detailController.CInternetCon.value) {
                  return Center(
                    child: Text(
                      'Silahkan periksa koneksi internet Anda.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else if (detailController.userData.isEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Text(
                        'No data available.',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      UserProfileScreen(),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 40),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(RouteName.details);
                        },
                        child: Text(
                          'Capture Image',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 40),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(RouteName.test);
                        },
                        child: const Text(
                          'For Test Data',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
