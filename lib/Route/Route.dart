// ignore_for_file: prefer_const_constructors, file_names

import 'package:get/get.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/View/Pages/CameraPage.dart';
import 'package:surveyor_clone/View/Pages/DetailPage.dart';
import 'package:surveyor_clone/View/Pages/ForgotPasswordPage.dart';
import 'package:surveyor_clone/View/Pages/SplashScreen.dart';
import 'package:surveyor_clone/View/Pages/HomePage.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteName.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RouteName.camera,
      page: () => CameraScreen(),
    ),
    GetPage(
      name: RouteName.details,
      page: () => DetailScreen(),
    ),
    GetPage(
      name: RouteName.forgot,
      page: () => ForgotPasswordScreen(),
    ),
  ];
}
