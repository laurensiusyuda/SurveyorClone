// ignore_for_file: use_key_in_widget_constructors

import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surveyor_clone/Route/Route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:surveyor_clone/Route/RouteName.dart';
import 'package:surveyor_clone/Bindings/AppBindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  bindControllers();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surveyor Clone',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RouteName.splash,
      getPages: AppRoute.pages,
    );
  }
}
