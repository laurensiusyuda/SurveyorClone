// ignore_for_file: unnecessary_new, file_names, prefer_collection_literals, non_constant_identifier_names

class OTPRequestModel {
  String? email;
  String? nik;
  String? otp_code;
  OTPRequestModel({this.email, this.nik, this.otp_code});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['nik'] = nik;
    data['otp_code'] = otp_code;
    return data;
  }
}
