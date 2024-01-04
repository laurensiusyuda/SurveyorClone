// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:surveyor_clone/services/Connect.dart';
import 'package:surveyor_clone/Model/LoginRequest.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';

class LoginController extends GetxController {
  final isShowingPassword = true.obs;
  late final Request LoginService;
  late final AuthenticationManager AuthManager;

  @override
  void onInit() {
    super.onInit();
    LoginService = Get.put(Request());
    AuthManager = Get.find();
  }

  Future<void> loginuser(String email, String password) async {
    await LoginService.fetchlogin(
            LoginRequestModel(email: email, password: password), null)
        .then(
      (value) {
        print('on submit');
        print('data: $value');
        print('${value.body}');
        var result = value.body;
        if (result['status'] == 1) {
          print(result['status']);
          print(result['data']['access_token']);
          AuthManager.login(result['data']['access_token']);
        } else {
          print(result['message']);
          Get.dialog(
            AlertDialog(
              title: const Text('Peringatan'),
              content: Text(result['message']),
              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
