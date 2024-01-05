// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, file_names, unused_element

import 'package:get/get.dart';
import 'package:surveyor_clone/Helper/Constant.dart';
import 'package:surveyor_clone/Model/ForgotRequest.dart';
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
  }

  Future getDetailUser(params, reqHeaders) async {
    var response;
    try {
      response = await post(Appstrings.DetailUserUrl, params,
              headers: reqHeaders, contentType: content)
          .timeout(reqTimeout);
      if (response.statusCode == 200) {
        print("Success to fetch data. Status Code: ${response.statusCode}");
        print("Response Body = ${response.body}");
        return response;
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchResetPass(ForgotRequestModel model, reqHeaders) async {
    var response;
    try {
      response = await post(Appstrings.ForgotPasswordUrl, model.toJson(),
              headers: reqHeaders, contentType: content)
          .timeout(reqTimeout);
      if (response.statuscode == 200) {
        print(response);
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
