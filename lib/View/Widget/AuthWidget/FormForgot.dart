// ignore_for_file: prefer_const_constructors, file_names, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Controller/AuthController/ForgotPasswordController.dart';

class ForgotForm extends StatelessWidget {
  const ForgotForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey();
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController nikcontroller = TextEditingController();
    final ForgotPasswordController forgotPasswordC = Get.find();

    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            controller: emailcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email harus di isi!";
              } else if (!value.contains('@')) {
                return "Email tidak valid!";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              hintText: 'Masukan Email Karywan',
              hintStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
              icon: Icon(Icons.person),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              prefixIconConstraints: BoxConstraints(minWidth: 60),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: nikcontroller,
            validator: (value) {
              return (value == null || value.isEmpty) ? 'Masukan NIK' : null;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.contact_mail_outlined),
              labelText: 'NIK',
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              hintText: 'Masukan NIK',
              hintStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 60,
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
              if (formkey.currentState!.validate()) {
                await forgotPasswordC.forgotpasswordUser(
                  context,
                  emailcontroller.text,
                  nikcontroller.text,
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
