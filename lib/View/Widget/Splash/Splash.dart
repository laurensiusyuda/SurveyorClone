import 'package:flutter/material.dart';
import 'package:surveyor_clone/Helper/Constant.dart';

Widget errorView(AsyncSnapshot<Object?> snapshot) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: ${snapshot.error}'),
        ],
      ),
    ),
  );
}

Widget waitingView() {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Appstrings.assetsLogo,
            width: 300,
            height: 300,
          ),
          const CircularProgressIndicator(
            color: Colors.blue, // Sesuaikan dengan warna yang diinginkan
          ),
          const SizedBox(height: 16),
          const Text(
            'Loading...',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
