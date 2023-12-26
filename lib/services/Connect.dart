// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:get/get.dart';
import 'package:surveyor_clone/Helper/Constant.dart';
import 'package:surveyor_clone/Model/LoginRequest.dart';

/// A class for making HTTP requests, specifically tailored for login-related API calls.
class Request extends GetConnect {
  /// The content type for the request.
  String content = 'application/json';

  /// Request timeout duration.
  final reqTimeout = const Duration(seconds: 30);

  /// Makes a POST request to the login API endpoint.
  ///
  /// Parameters:
  /// - [model]: An instance of [LoginRequestModel] containing login request details.
  /// - [reqHeaders]: Headers to be included in the request.
  ///
  /// Returns:
  /// A Future that completes with the server response.
  Future fetchlogin(LoginRequestModel model, reqHeaders) async {
    var response;
    try {
      // Perform a POST request to the login API endpoint
      response = await post(Appstrings.LoginUrl, model.toJson(),
              headers: reqHeaders, contentType: content)
          .timeout(reqTimeout);

      // Check the status code
      if (response.statusCode == 200) {
        return response;
      } else {
        // Handle other status codes or errors if needed
        // ...
      }
    } catch (e) {
      // Handle request timeout or other exceptions
      print(e);
    }
  }
}
