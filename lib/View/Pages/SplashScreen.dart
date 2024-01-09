import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:surveyor_clone/View/Pages/AuthPages/LoginPage.dart';
import 'package:surveyor_clone/View/Pages/HomePage.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';
import 'package:surveyor_clone/View/Widget/Splash/Splash.dart';

class SplashScreen extends StatelessWidget {
  final AuthenticationManager authManager = Get.find();

  Future<void> initializeSettings() async {
    authManager.checkLoginStatus();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return authManager.isLogged.value ? HomeScreen() : LoginScreen();
          }
        }
      },
    );
  }
}
