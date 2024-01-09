// ignore_for_file: file_names, annotate_overrides, unnecessary_overrides, non_constant_identifier_names, avoid_print, unnecessary_string_interpolations

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/AuthController/AuthenticationManager.dart';
import 'package:surveyor_clone/Model/AuthModel/ForgotModel.dart';
import 'package:surveyor_clone/Model/AuthModel/OTPModel.dart';
import 'package:surveyor_clone/Model/AuthModel/ResetPasswordModel.dart';
import 'package:surveyor_clone/Services/Connect.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:surveyor_clone/View/Pages/AuthPages/OTPVerifiyPage.dart';
import 'package:surveyor_clone/View/Pages/AuthPages/ResetPasswordpage.dart';

class ForgotPasswordController extends GetxController {
  final isShowingPassword = true.obs;
  final isShowingPasswordConf = true.obs;

  RxBool isCountingDown = false.obs;
  RxInt countdownValue = 60.obs;

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
      null,
    ).then(
      (value) {
        var result = value.body;
        print('DATA ${result.toString()}');
        if (result['status'] == 1) {
          print(result['status']);
          AuthManager.saveTokenResetPassword(result['data']['token']);
          print(AuthManager.getTokenResetPassword());
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
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            btnOkOnPress: () {
              Get.to(
                () => OTPVerifyScreen(),
                arguments: {
                  'email': email,
                  'nik': nik,
                },
              );
            },
          ).show();
        } else if (result['status'] == 0) {
          print(result['status']);
          var message = result['message'];
          if (message is String) {
            print(message);
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
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {},
            ).show();
          } else {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Kode OTP GAGAL TERKIRIM',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: "Masukkan Email dan NIK yang Benar",
              descTextStyle: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {},
            ).show();
          }
        } else {}
      },
    );
  }

  Future<void> verifyOtpCode(
      BuildContext context, String email, String nik, String OTPCode) async {
    String? token = AuthManager.getTokenResetPassword();
    if (token != null) {
      print(token);
      var headers = {
        'Authorization': "Bearer $token",
      };
      print(headers);
      print(OTPCode);
      await ForgotPasswordService.FetchOTPCode(
        OTPRequestModel(
          email: email,
          nik: nik,
          otp_code: OTPCode,
        ),
        headers,
      ).then(
        (value) {
          var result = value.body;
          print(result.toString());
          if (result['status'] == 1) {
            print(result['status']);
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              title: 'Kode OTP Sesuai',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: 'Kode OTP anda telah sesuai!',
              descTextStyle: GoogleFonts.lato(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {
                Get.to(
                  () => ResetForgotPasswordScreen(),
                  arguments: {
                    'email': email,
                    'nik': nik,
                    'otp_code': OTPCode,
                  },
                );
              },
            ).show();
          } else {
            print(result['status']);
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              title: 'Kode OTP Tidak Sesuai',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: 'Masukan Kode OTP Yang benar !',
              descTextStyle: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {},
            ).show();
          }
        },
      );
    }
  }

  void startCountdown() async {
    isCountingDown.value = true;
    for (int i = 60; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      countdownValue.value = i;
    }
    isCountingDown.value = false;
  }

  Future<void> verifyNewPassword(BuildContext context, String email,
      String newpassword, String OTPCode) async {
    String? token = AuthManager.getTokenResetPassword();
    if (token != null) {
      print(token);
      var headers = {
        'Authorization': "Bearer $token",
      };
      print(headers);
      print(OTPCode);
      await ForgotPasswordService.fetchNewPassword(
        ResetPasswordRequestModel(
          email: email,
          new_password: newpassword,
          otp_code: OTPCode,
        ),
        headers,
      ).then(
        (value) {
          var result = value.body;
          print(result);
          if (result['status'] == 1) {
            print(result['status']);
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              title: 'Password Berhasil dirubah',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: 'Selamat password anda berhasil diperbarui',
              descTextStyle: GoogleFonts.lato(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {},
            ).show();
          } else {
            print(result['status']);
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              title: 'Password Gagal Berubah',
              titleTextStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              desc: 'Silahkan Memasukan Password Baru',
              descTextStyle: GoogleFonts.lato(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              btnOkOnPress: () {},
            ).show();
          }
        },
      );
    }
  }
}
