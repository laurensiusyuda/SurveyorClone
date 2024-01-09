// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/View/Widget/AuthWidget/FormOTPVerify.dart';

class OTPVerifyScreen extends StatelessWidget {
  final Map<String, String> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            'OTP KODE VERIFY',
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Silakan masukkan kode OTP yang telah dikirimkan melalui ${data['email']}',
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
                FormForgot(email: data['email']!, nik: data['nik']!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
