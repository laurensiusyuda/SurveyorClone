// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';
import 'package:surveyor_clone/Controller/AuthController/ForgotPasswordController.dart';
import 'package:surveyor_clone/Controller/AuthController/LoginController.dart';
import 'package:surveyor_clone/Controller/CameraLocationController.dart';
import 'package:surveyor_clone/Controller/DetailController/DetaiUserController.dart';
import 'package:surveyor_clone/Controller/DetailController/DeviceController.dart';
import 'package:surveyor_clone/Controller/DetailController/FCMController.dart';
import 'package:surveyor_clone/Controller/GeoLocationControl.dart';

void bindControllers() {
  // Controller Login
  Get.put<AuthenticationManager>(AuthenticationManager());
  Get.put<LoginController>(LoginController());
  Get.put<ForgotPasswordController>(ForgotPasswordController());

  // Controller to Get Detail User
  Get.put<FCMController>(FCMController());
  Get.put<DeviceUserController>(DeviceUserController());
  Get.put<DetailUserController>(DetailUserController());

  // Controller to Handle Camera Action
  Get.put<CameraLocationController>(CameraLocationController());
  Get.put<ScreenshotController>(ScreenshotController());
  Get.put<GeoLocationController>(GeoLocationController());
}
