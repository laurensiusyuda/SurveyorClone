// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyor_clone/Helper/Constant.dart';
import 'package:surveyor_clone/Controller/AuthController/LoginController.dart';
import 'package:surveyor_clone/Route/RouteName.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final LoginController loginc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          Image.asset(
            Appstrings.assetsLogo,
            width: 300,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'SURVEYOR TMI',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailcontroller,
            validator: (value) {
              return (value == null || value.isEmpty) ? 'Masukan Email' : null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
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
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              prefixIconConstraints: BoxConstraints(minWidth: 60),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFormField(
              controller: passcontroller,
              obscureText: loginc.isShowingPassword.value,
              obscuringCharacter: '*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Masukan Password';
                } else if (value != passcontroller.text) {
                  return 'Password Tidak Sesuai';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                hintText: 'Masukan Password Karyawan',
                hintStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 12,
                  ),
                ),
                icon: const Icon(Icons.lock),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                prefixIconConstraints: const BoxConstraints(minWidth: 60),
                suffixIcon: IconButton(
                  onPressed: () {
                    loginc.isShowingPassword.toggle();
                  },
                  icon: Icon(loginc.isShowingPassword.isTrue
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(RouteName.forgot);
                },
                child: Text(
                  "Lupa Password ?",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
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
                await loginc.loginuser(
                    context, emailcontroller.text, passcontroller.text);
              }
            },
            child: Text(
              'Masuk',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
