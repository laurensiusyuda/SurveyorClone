// ignore_for_file: non_constant_identifier_names, file_names, avoid_print, await_only_futures

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:surveyor_clone/Model/DataUser.dart';
import 'package:surveyor_clone/services/Connect.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';
import 'package:surveyor_clone/Controller/DetailController/DeviceController.dart';
import 'package:surveyor_clone/Controller/DetailController/FCMController.dart';
import 'package:surveyor_clone/Controller/DetailController/ConnectionController.dart';

class DetailUserController extends GetxController {
  late final Request DetailService;
  late final FCMController FcmControllerToken;
  late final DeviceUserController DeviceUserId;
  late final AuthenticationManager AuthToken;
  late final ConnectionController connectionController;

  RxString headers = ''.obs;
  RxString params = ''.obs;
  RxList<Datauser> userData = <Datauser>[].obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    DetailService = Get.put(Request());
    DeviceUserId = Get.put(DeviceUserController());
    FcmControllerToken = Get.put(FCMController());
    AuthToken = Get.put(AuthenticationManager());
    connectionController = Get.put(ConnectionController());
    FcmControllerToken.initFCM();

    // Fetch user data when connectivity changes
    ever(connectionController.connectionStatus, (_) {
      if (connectionController.connectionStatus.value !=
          ConnectivityResult.none) {
        fetchDetailUser();
      }
    });

    // Fetch user data initially
    fetchDetailUser();
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> fetchDetailUser() async {
    isloading.value = true;
    var isInternetConnected = await checkInternetConnection();

    if (!isInternetConnected) {
      isloading.value = false;
      return;
    }

    await Future.delayed(const Duration(seconds: 2));
    String? token = AuthToken.getToken();
    if (token != null) {
      var headers = {
        'Authorization': "Bearer $token",
        "Accept": "application/json"
      };
      var fcmID = await FcmControllerToken.getFCMToken();
      var params = {
        "devices": {
          "device_id": DeviceUserId.device?.deviceId ?? "N/A",
          "model": DeviceUserId.device?.model ?? "N/A",
          "sdk": DeviceUserId.device?.sdk ?? "N/A",
          "manufacture": DeviceUserId.device?.manufacture ?? "N/A"
        },
        "fcm_token": fcmID
      };
      await DetailService.getDetailUser(params, headers).then(
        (value) {
          if (value != null) {
            var dataUser = Datauser.fromJson(value.body);
            userData.add(dataUser);

            this.headers.value = "Bearer $token";
            this.params.value = params.toString();

            print("Headers: $headers");
            print("FCMToken: $fcmID");
            print("Params: $params");
          }
        },
      );
    } else {
      print("Token Is Null");
    }
    isloading.value = false;
  }
}
