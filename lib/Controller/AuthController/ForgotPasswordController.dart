// ignore_for_file: file_names, annotate_overrides, unnecessary_overrides, non_constant_identifier_names, avoid_print, unnecessary_string_interpolations

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';
import 'package:surveyor_clone/Model/ForgotRequest.dart';
import 'package:surveyor_clone/Services/Connect.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:surveyor_clone/View/Pages/OTPVerifiyPage.dart';

class ForgotPasswordController extends GetxController {
  late final Request ForgotPasswordService;
  late final AuthenticationManager AuthManager;

  @override
  void onInit() {
    super.onInit();
    ForgotPasswordService = Get.put(Request());
    AuthManager = Get.find();
  }

  Future<void> forgotpasswordUser(
      BuildContext context, String email, String nik) async {
    await ForgotPasswordService.fetchResetPass(
            ForgotRequestModel(
              email: email,
              nik: nik,
            ),
            null)
        .then(
      (value) {
        var result = value.body;
        print('DATA ${result.toString()}');
        if (result['status'] == 1) {
          print('${result['status'] == 1}');
          AuthManager.saveTokenResetPassword(result['data']['access_token']);
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            title: 'Kode OTP BERHASIL TERKIRIM',
            titleTextStyle: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            desc: 'Silahkan Check Email $email',
            descTextStyle: GoogleFonts.lato(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            btnOkOnPress: () {
              Get.to(
                OTPVerifyScreen(),
                arguments: {
                  'email': email,
                  'nik': nik,
                },
              );
            },
          );
        } else if (result['status'] == 0) {
          print('${result['status'] == 0}');
          var message = result['message'];
          var emailErrors = (message['email'] as List<String>?) ?? [];
          var nikErrors = (message['nik'] as List<String>?) ?? [];
          if (message is String) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Kode OTP GAGAL TERKIRIM',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: "Maksimal 5x permintaan OTP/hari! Coba lagi besok!",
              descTextStyle: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {
                Get.back();
              },
            ).show();
          } else if (emailErrors.isNotEmpty && nikErrors.isNotEmpty) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Kode OTP GAGAL TERKIRIM',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: "$emailErrors dan $nikErrors",
              descTextStyle: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {
                Get.back();
              },
            ).show();
          } else if (emailErrors.isNotEmpty) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Kode OTP GAGAL TERKIRIM',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: "$nikErrors",
              descTextStyle: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {
                Get.back();
              },
            ).show();
          } else if (nikErrors.isNotEmpty) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Kode OTP GAGAL TERKIRIM',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: "$nikErrors",
              descTextStyle: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {
                Get.back();
              },
            ).show();
          }
        }
      },
    );
  }

  Future<void> verifyOtpCode(String email, String nik, String OTPCode) async {}
}
