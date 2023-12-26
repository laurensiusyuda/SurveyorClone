import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surveyor_clone/Route/Route.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/Controller/LoginController.dart';
import 'package:surveyor_clone/Controller/GeoLocationControl.dart';
import 'package:surveyor_clone/Controller/AuthenticationManager.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthenticationManager());
  Get.put(LoginController());
  Get.put(ScreenshotController());
  Get.put(CameraLocationController());
  Get.put(GeoLocationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surveyor Clone',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RouteName.splash,
      getPages: AppRoute.pages,
    );
  }
}
