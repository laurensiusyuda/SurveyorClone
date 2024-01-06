// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormForgot extends StatelessWidget {
  final String email;
  final String nik;

  // Konstruktor dengan parameter
  const FormForgot({required this.email, required this.nik});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey();
    final TextEditingController otpcontroller = TextEditingController();

    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            controller: otpcontroller,
          ),
        ],
      ),
    );
  }
}
