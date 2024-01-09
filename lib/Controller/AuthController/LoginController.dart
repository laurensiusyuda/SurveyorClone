// ignore_for_file: avoid_print, non_constant_identifier_names, file_names
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/DetailController/DetaiUserController.dart';
import 'package:surveyor_clone/Model/AuthModel/LoginModel.dart';
import 'package:surveyor_clone/Services/Connect.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';

class LoginController extends GetxController {
  final isShowingPassword = true.obs;
  late final Request LoginService;
  late final AuthenticationManager AuthManager;
  late final DetailUserController detailUserController;

  @override
  void onInit() {
    super.onInit();
    LoginService = Get.put(Request());
    detailUserController = Get.put(DetailUserController());
    AuthManager = Get.find();
  }

  Future<void> loginuser(
      BuildContext context, String email, String password) async {
    await LoginService.fetchlogin(
            LoginRequestModel(email: email, password: password), null)
        .then(
      (value) {
        print('ON SUBMIT');
        print('data: $value');
        print('${value.body}');
        var result = value.body;
        if (result['status'] == 1) {
          print(result['status']);
          print(result['data']['access_token']);
          AuthManager.login(result['data']['access_token']);
          detailUserController.fetchDetailUser();
        } else {
          print(result['message']);
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            title: 'Gagal Login',
            titleTextStyle: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            desc: "${result['message']}",
            descTextStyle: GoogleFonts.lato(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            btnOkOnPress: () {},
          ).show();
        }
      },
    );
  }
}
