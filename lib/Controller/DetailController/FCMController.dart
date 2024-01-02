// ignore_for_file: file_names, await_only_futures

import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

class FCMController extends GetxController {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final storage = GetStorage();
  RxString fcmToken = ''.obs;

  Future<void> initFCM() async {
    await messaging.requestPermission();
    await saveFCMToken();
    await getFCMToken();
    messaging.onTokenRefresh.listen((newToken) async {
      await saveFCMToken(newToken);
      await getFCMToken();
    });
  }

  Future<void> saveFCMToken([String? token]) async {
    token ??= await messaging.getToken();
    storage.write('fcmToken', token);
  }

  String getFCMToken() {
    fcmToken.value = storage.read('fcmToken') ?? '';
    return fcmToken.value;
  }
}
