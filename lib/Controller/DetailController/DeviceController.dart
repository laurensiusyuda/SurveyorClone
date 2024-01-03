// ignore_for_file: file_names, unused_local_variable, avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';
import 'package:surveyor_clone/Model/DeviceModel.dart';

class DeviceUserController extends GetxController {
  Device? device;

  @override
  void onInit() {
    super.onInit();
    getDeviceID();
  }

  Future<void> getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      try {
        var iosInfo = await DeviceInfoPlugin().iosInfo;
        var iosDeviceInfo = await deviceInfo.iosInfo;
        device = Device(
          deviceId: iosDeviceInfo.identifierForVendor ?? '',
          manufacture: iosInfo.name,
          model: iosInfo.model,
          sdk: 0,
        );
      } catch (e) {
        print("Error fetching iOS device info: $e");
      }
    } else if (Platform.isAndroid) {
      try {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        const androidIdPlugin = AndroidId();
        device = Device(
          deviceId: (await androidIdPlugin.getId()) ?? '',
          manufacture: androidDeviceInfo.manufacturer,
          model: androidDeviceInfo.model,
          sdk: androidDeviceInfo.version.sdkInt,
        );
      } catch (e) {
        print("Error fetching Android device info: $e");
      }
    }
  }

  String getDeviceId() => device?.deviceId ?? '';
  String getManufacture() => device?.manufacture ?? '';
  String getModel() => device?.model ?? '';
  int getSdk() => device?.sdk ?? 0;
}
