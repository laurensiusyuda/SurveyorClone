// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/AuthController/ForgotPasswordController.dart';

class FormForgot extends StatelessWidget {
  final String email;
  final String nik;

  // Konstruktor dengan parameter
  const FormForgot({required this.email, required this.nik});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey();
    final TextEditingController otpcontroller = TextEditingController();
    final ForgotPasswordController forgotPasswordC = Get.find();

    return Form(
      key: formkey,
      child: Column(
        children: [
          // Decoration Text From Field
          TextFormField(
            controller: otpcontroller,
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Kode OTP Harus diisi !'
                  : null;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.code),
              labelText: 'Kode OTP',
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              hintText: 'Masukan Kode OTP',
              hintStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 60),
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
              if (formkey.currentState!.validate()) {
                await forgotPasswordC.verifyOtpCode(
                  context,
                  email,
                  nik,
                  otpcontroller.text,
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
