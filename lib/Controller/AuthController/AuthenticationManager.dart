// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surveyor_clone/View/Pages/HomePage.dart';
import 'package:surveyor_clone/View/Pages/SplashScreen.dart';

enum CacheManagerKey { TOKEN, TOKENFORGOT }

class AuthenticationManager extends GetxController {
  final isLogged = false.obs;

  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token);
    Get.offAll(HomeScreen());
  }

  void logOut() {
    isLogged.value = false;
    removeToken();
    Get.offAll(() => SplashScreen());
  }

  //Login
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }

  //Reset Password
  Future<bool> saveTokenResetPassword(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKENFORGOT.toString(), token);
    return true;
  }

  String? getTokenResetPassword() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKENFORGOT.toString());
  }
}
