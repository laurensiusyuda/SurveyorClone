// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable, avoid_print, unnecessary_this, await_only_futures
import 'package:get/get.dart';
import 'package:surveyor_clone/Model/DataUser.dart';
import 'package:surveyor_clone/services/Connect.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:surveyor_clone/Controller/AuthenticationManager.dart';
import 'package:surveyor_clone/Controller/DetailController/DeviceController.dart';
import 'package:surveyor_clone/Controller/DetailController/FCMController.dart';

class DetailUserController extends GetxController {
  late final Request DetailService;
  late final FCMController FcmControllerToken;
  late final DeviceUserController DeviceUserId;
  late final AuthenticationManager AuthToken;

  RxString headers = ''.obs;
  RxString params = ''.obs;
  RxList<Datauser> userData = <Datauser>[].obs;
  RxBool CInternetCon = false.obs; // check internet connection
  RxBool isloading = false.obs; // loading state

  @override
  void onInit() {
    super.onInit();
    DetailService = Get.put(Request());
    DeviceUserId = Get.put(DeviceUserController());
    FcmControllerToken = Get.put(FCMController());
    AuthToken = Get.put(AuthenticationManager());
    FcmControllerToken.initFCM();
    fetchDetailUser();
    ever(Get.parameters["debug"] == "true" ? RxBool(true) : CInternetCon,
        (_) => fetchDetailUser());
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> fetchDetailUser() async {
    isloading.value = true;
    CInternetCon.value = await checkInternetConnection();

    if (!CInternetCon.value) {
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
            print("FCMTOken: $fcmID");
            print("Params: $params");
          }
        },
      );
    } else {
      print("Token Is Null");
    }

    //check on debug console
    print("Headers: $headers");
    print("FCMTOken: $token");
    print("Params: $params");
    isloading.value = false;
  }
}
