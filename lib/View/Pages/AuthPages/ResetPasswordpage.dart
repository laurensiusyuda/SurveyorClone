// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/View/Widget/AuthWidget/FormResetPassword.dart';

class ResetForgotPasswordScreen extends StatelessWidget {
  final Map<String, String> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            'Masukkan Kata Sandi Baru',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Column(
              children: [
                Text(
                  'Silakan Masukkan Kata Sandi Baru Anda. Mohon periksa dan pastikan kata sandi sesuai',
                  style: GoogleFonts.lato(
                    color: Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormResetPassword(
                    email: data['email']!, otp_code: data['otp_code']!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
