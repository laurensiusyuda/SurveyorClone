// ignore_for_file: use_key_in_widget_constructors

import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surveyor_clone/Route/Route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'Controller/DetailController/DeviceController.dart';
import 'package:surveyor_clone/Controller/LoginController.dart';
import 'package:surveyor_clone/Controller/GeoLocationControl.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';
import 'package:surveyor_clone/Controller/DetailController/DetaiUserController.dart';
import 'package:surveyor_clone/Controller/DetailController/FCMController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  //Controller Login
  Get.put(AuthenticationManager());
  Get.put(LoginController());

  // Controller to Get Detail User
  Get.put(FCMController());
  Get.put(DeviceUserController());
  Get.put(DetailUserController());

  //Controller to Handle Camera Action
  Get.put(CameraLocationController());
  Get.put(ScreenshotController());
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
