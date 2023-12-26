/// Model class representing a login request.
class LoginRequestModel {
  /// User's email address.
  String? email;

  /// User's password.
  String? password;

  /// Constructor for creating a `LoginRequestModel` instance.
  ///
  /// Parameters:
  /// - [email]: User's email address.
  /// - [password]: User's password.
  LoginRequestModel({this.email, this.password});

  /// Converts the `LoginRequestModel` to a JSON format.
  ///
  /// Returns:
  /// A map containing the email and password in JSON format.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
