import 'dart:convert';

import '../../../auth/Login/Domain/entities/Name.dart';
import '../../../auth/Login/Domain/entities/Role.dart';
import '../../../auth/Signup/Domain/entities/AddressModel.dart';



class UserLovResponse {
  UserLovResponse({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.active,
    required this.role,
    required this.address,
    required this.gender,
    required this.phoneNumber,
    required this.status,
  });

  int id;
  Name fullName;
  String? email;
  String? profilePic;
  bool? active;
  Role? role;
  Address? address;
  String? gender;
  String? phoneNumber;
  Status? status;

  factory UserLovResponse.fromJson(Map<String, dynamic> json) =>
      UserLovResponse(
        id: json["id"],
        gender: (json["gender"] != null) ? json["gender"] : null,
        address: (json["address"] != null)
            ? Address.fromJson(json["address"])
            : null,
        fullName: Name.fromJson(json["fullName"]),
        email: (json["email"] != null) ? json["email"] : null,
        profilePic: json["profilePic"] != null ? json["profilePic"] : null,
        phoneNumber: json["phoneNumber"] != null ? json["phoneNumber"] : null,
        active: json["active"] != null ? json["active"] : null,
        status: (json["status"] != null)
            ? Status.values.byName(json["status"])
            : null,
        role: (json["role"] != null) ? Role.fromJson(json["role"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName.toJson(),
    "email": email,
    "profilePic": profilePic,
    "active": active,
    "role": role?.toJson(),
    "address": address?.toJson(),
    "gender": gender,
    "phoneNumber": phoneNumber,
    "status": status?.name,
  };

  // static List<UserLovResponse> listFromJson(List<dynamic> jsonList) {
  //   List<UserLovResponse> userList = [];
  //   for (dynamic json in jsonList) {
  //     userList.add(UserLovResponse.fromJson(json));
  //   }
  //   return userList;
  // }

  // UserLovResponse userLovRequestFromJson(String str) =>
  //     UserLovResponse.fromJson(json.decode(str));
  //
  // String userLovRequestToJson(UserLovResponse data) =>
  //     json.encode(data.toJson());
}

enum Status {
  Pending,
  Approved,
  Reject,
}

final statusValues = EnumValues({
  "Reject": Status.Reject,
  "Pending": Status.Pending,
  "Approved": Status.Approved
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
