// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surveyor_clone/View/Pages/HomePage.dart';
import 'package:surveyor_clone/View/Pages/SplashScreen.dart';

enum CacheManagerKey { TOKEN }

class AuthenticationManager extends GetxController {
  final isLogged = false.obs;

  //! User login handling
  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token);
    Get.offAll(HomeScreen());
  }

  //! User logout handling
  void logOut() {
    isLogged.value = false;
    removeToken();
    Get.offAll(() => SplashScreen());
  }

  //! Save token
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  //! Remove token
  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  //! Get token
  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  //! Check login status
  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}
