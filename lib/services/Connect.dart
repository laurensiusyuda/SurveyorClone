// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, file_names, unused_element

import 'package:get/get.dart';
import 'package:surveyor_clone/Helper/Constant.dart';
import 'package:surveyor_clone/Model/LoginRequest.dart';

class Request extends GetConnect {
  String content = 'application/json';
  final reqTimeout = const Duration(seconds: 30);

  Future fetchlogin(LoginRequestModel model, reqHeaders) async {
    var response;
    try {
      response = await post(Appstrings.LoginUrl, model.toJson(),
              headers: reqHeaders, contentType: content)
          .timeout(reqTimeout);
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }

    Future getDetailUser() async {
      try {} catch (e) {
        print(e);
      }
    }
  }
}
