// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable, avoid_print
import 'package:get/get.dart';
import 'package:surveyor_clone/Controller/AuthenticationManager.dart';
import 'package:surveyor_clone/Controller/DetailController/DeviceController.dart';
import 'package:surveyor_clone/Controller/DetailController/FCMController.dart';

class DetailUserController extends GetxController {
  late final FCMController FcmControllerToken;
  late final DeviceUserController DeviceUserId;
  late final AuthenticationManager AuthToken;

  // check data
  RxString headers = ''.obs; // Add RxString for headers
  RxString params = ''.obs; // Add RxString for params

  @override
  void onInit() {
    super.onInit();
    DeviceUserId = Get.put(DeviceUserController());
    FcmControllerToken = Get.put(FCMController());
    AuthToken = Get.put(AuthenticationManager());
    FcmControllerToken.initFCM();
    fetchDetailUser();
  }

  Future<void> fetchDetailUser() async {
    String? token = AuthToken.getToken();
    if (token != null) {
      await Future.delayed(const Duration(
          seconds: 1)); // Add a delay (you can adjust the duration)

      var fcmID = await FcmControllerToken.getFCMToken();
      var params = {
        "devices": {
          "device_id": DeviceUserId.device?.deviceId ?? "N/A",
          "model": DeviceUserId.device?.model ?? "N/A",
          "sdk": DeviceUserId.device?.sdk ?? "N/A",
          "manufacture": DeviceUserId.device?.manufacture ?? "N/A"
        },
        "fcm_token": fcmID ?? "N/A"
      };
      this.headers.value = "Bearer $token";
      this.params.value = params.toString();

      print("Headers: $headers");
      print("FCMTOken: $fcmID");
      print("Params: $params");
    } else {
      print("Token Is Null");
    }
  }
}
