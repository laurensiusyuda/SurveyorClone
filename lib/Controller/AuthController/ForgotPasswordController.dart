// ignore_for_file: file_names, annotate_overrides, unnecessary_overrides, non_constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:surveyor_clone/Model/ForgotRequest.dart';
import 'package:surveyor_clone/Services/Connect.dart';

class ForgotPasswordController extends GetxController {
  late final Request ForgotPasswordService;

  @override
  void onInit() {
    super.onInit();
    ForgotPasswordService = Get.put(Request());
  }

  Future<void> forgotpasswordUser(String email, String nik) async {
    await ForgotPasswordService.fetchResetPass(
            ForgotRequestModel(email: email, nik: nik), null)
        .then(
      (value) {
        print('ON SUBMIT');
        print('DATA $value');
      },
    );
  }
}
