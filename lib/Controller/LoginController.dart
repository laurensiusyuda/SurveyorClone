// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:surveyor_clone/services/Connect.dart';
import 'package:surveyor_clone/Model/LoginRequest.dart';
import 'package:surveyor_clone/Controller/AuthenticationManager.dart';

class LoginController extends GetxController {
  //! Control for showing or hiding password
  final isShowingPassword = true.obs;

  //! Service instances for handling authentication and making requests
  late final Request loginService;
  late final AuthenticationManager authManager;

  @override
  void onInit() {
    super.onInit();
    //! Initialize service instances
    loginService = Get.put(Request());
    authManager = Get.find();
  }

  /// Function to handle user login.
  ///
  /// Parameters:
  /// - [email]: User's email
  /// - [password]: User's password
  Future<void> loginuser(String email, String password) async {
    // Make a login request using the authentication service
    await loginService
        .fetchlogin(LoginRequestModel(email: email, password: password), null)
        .then(
      (value) {
        print('on submit');
        print('data: $value');
        print('${value.body}');
        var result = value.body;
        if (result['status'] == 1) {
          //! If the login is successful, update authentication status
          print(result['status']);
          print(result['data']['access_token']);
          authManager.login(result['data']['access_token']);
        } else {
          //! If the login fails, show an alert with the error message
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

  //! Controller for resetting the password
}
