

import '../../../auth/Login/Domain/entities/Name.dart';

class RoleResponse {
  Name name;
  int id;
  bool? active;

  RoleResponse({required this.name, required this.active, required this.id});

  factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
      name: Name.fromJson(json["name"]),
      active: json["active"]??false,
      id: json['id']);

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "active": active,
    "id": id,
  };
}
