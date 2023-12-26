import 'package:flutter/material.dart';
import 'package:surveyor_clone/View/Widget/Login/FormLogin.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
