// ignore_for_file: file_names

import 'dart:convert';

class Datauser {
  int status;
  String message;
  Data data;

  Datauser({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Datauser.fromRawJson(String str) =>
      Datauser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datauser.fromJson(Map<String, dynamic> json) => Datauser(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int notificationCount;
  User user;

  Data({
    required this.notificationCount,
    required this.user,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notificationCount: json["notification_count"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "notification_count": notificationCount,
        "user": user.toJson(),
      };
}

class User {
  String userName;
  String email;
  String phoneNumber;
  String alamat;
  String nik;
  int isViewMaps;
  int isViewDraft;
  int isCanMonitoring;

  User({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.alamat,
    required this.nik,
    required this.isViewMaps,
    required this.isViewDraft,
    required this.isCanMonitoring,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json["user_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        alamat: json["alamat"],
        nik: json["nik"],
        isViewMaps: json["is_view_maps"],
        isViewDraft: json["is_view_draft"],
        isCanMonitoring: json["is_can_monitoring"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "email": email,
        "phone_number": phoneNumber,
        "alamat": alamat,
        "nik": nik,
        "is_view_maps": isViewMaps,
        "is_view_draft": isViewDraft,
        "is_can_monitoring": isCanMonitoring,
      };
}
