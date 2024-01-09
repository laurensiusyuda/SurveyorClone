// ignore_for_file: unnecessary_new, file_names, prefer_collection_literals, non_constant_identifier_names

class ResetPasswordRequestModel {
  String? email;
  String? new_password;
  String? otp_code;
  ResetPasswordRequestModel({this.email, this.new_password, this.otp_code});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['new_password'] = new_password;
    data['otp_code'] = otp_code;
    return data;
  }
}
