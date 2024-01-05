// ignore_for_file: unnecessary_new, file_names, prefer_collection_literals

class ForgotRequestModel {
  String? email;
  String? nik;
  ForgotRequestModel({this.email, this.nik});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['nik'] = nik;
    return data;
  }
}
