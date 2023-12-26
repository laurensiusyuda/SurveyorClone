import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/Controller/LoginController.dart';
import 'package:surveyor_clone/Controller/AuthenticationManager.dart';
import 'package:surveyor_clone/View/Widget/Homepage/UserProfile.dart';

class HomeScreen extends StatelessWidget {
  final authManager = Get.find<AuthenticationManager>();
  final loginC = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appbar
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'Surveyor TMI',
            style: GoogleFonts.lato(),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              UserProfileScreen(),
              const SizedBox(
                height: 30,
              ),
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
                child: const Text(
                  'Capture Image',
                  style: TextStyle(
                    color: Colors.white,
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
