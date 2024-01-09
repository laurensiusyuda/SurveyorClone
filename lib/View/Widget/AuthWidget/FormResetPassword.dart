// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/AuthController/ForgotPasswordController.dart';

class FormResetPassword extends StatelessWidget {
  final String email;
  final String otp_code;

  const FormResetPassword({required this.email, required this.otp_code});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();
    final ForgotPasswordController forgotPasswordC = Get.find();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Obx(
            () => TextFormField(
              controller: newPasswordController,
              obscureText: forgotPasswordC.isShowingPassword.value,
              obscuringCharacter: '*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password harus diisi!";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                hintText: 'Masukkan Password Baru',
                hintStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 12,
                  ),
                ),
                icon: const Icon(Icons.lock),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                prefixIconConstraints: BoxConstraints(minWidth: 60),
                suffixIcon: IconButton(
                  onPressed: () {
                    forgotPasswordC.isShowingPassword.toggle();
                  },
                  icon: Icon(
                    forgotPasswordC.isShowingPassword.isTrue
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => TextFormField(
              controller: confirmNewPasswordController,
              obscureText: forgotPasswordC.isShowingPasswordConf.value,
              obscuringCharacter: '*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password harus diisi!";
                } else if (value != newPasswordController.text) {
                  return "Konfirmasi password tidak sesuai!";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                labelStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                hintText: 'Masukkan Password Lagi',
                hintStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 12,
                  ),
                ),
                icon: const Icon(Icons.lock),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                prefixIconConstraints: BoxConstraints(minWidth: 60),
                suffixIcon: IconButton(
                  onPressed: () {
                    forgotPasswordC.isShowingPasswordConf.toggle();
                  },
                  icon: Icon(
                    forgotPasswordC.isShowingPasswordConf.isTrue
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(225, 40),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                // Lakukan sesuatu setelah validasi berhasil
                await forgotPasswordC.verifyNewPassword(
                  context,
                  email,
                  newPasswordController.text,
                  otp_code,
                );
              }
            },
            child: Text(
              'Kirim',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
