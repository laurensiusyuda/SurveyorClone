import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:surveyor_clone/Helper/Constant.dart';
import 'package:surveyor_clone/Controller/LoginController.dart';

class LoginForm extends StatelessWidget {
  //controller email and password
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  //login controller
  final LoginController loginc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formkey,
      child: Column(
        children: [
          Image.asset(
            Appstrings.assetsLogo,
            width: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'SURVEYOR TMI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //email field
          TextFormField(
            controller: emailcontroller,
            // add validator if email empty send the error message
            validator: (value) {
              return (value == null || value.isEmpty) ? 'Masukan Email' : null;
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Masukan Email Karywan',
              icon: Icon(Icons.person),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              prefixIconConstraints: BoxConstraints(minWidth: 60),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //password field
          Obx(
            () => TextFormField(
              controller: passcontroller,
              obscureText: loginc.isShowingPassword.value,
              obscuringCharacter: '*',
              // add the validator if password empty send the error message
              validator: (value) {
                //make two validator
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
                hintText: 'Masukan Password Karyawan',
                icon: const Icon(Icons.lock),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                prefixIconConstraints: const BoxConstraints(minWidth: 60),
                // add show password fitur if user pres the password can display
                suffixIcon: IconButton(
                  onPressed: () {
                    loginc.isShowingPassword.toggle();
                  },
                  // make const
                  icon: Icon(loginc.isShowingPassword.isTrue
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          // button login
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 40),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ), // Set the background color to blue
            ),
            onPressed: () async {
              if (formkey.currentState!.validate()) {
                // masuk kedalam kontroller login
                await loginc.loginuser(
                    emailcontroller.text, passcontroller.text);
              }
            },
            child: const Text(
              'Masuk',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
