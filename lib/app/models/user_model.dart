import 'package:of_flutter_mobile/app/models/role_model.dart';

class UserModel {
  late int? id;
  late String? name;
  late String? username;
  late String? email;
  late dynamic createdAt;
  late dynamic updatedAt;
  late RoleModel? roles;

  UserModel({
    required this.id,
    this.name,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        roles: RoleModel.fromJson(json["roles"]),
      );
}
