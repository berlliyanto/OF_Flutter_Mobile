import 'package:of_flutter_mobile/app/models/role_model.dart';

class UserModel {
  late int? id;
  late String? name;
  late String? username;
  late int? roleId;
  late String? email;
  late dynamic emailVerifiedAt;
  late dynamic createdAt;
  late dynamic updatedAt;
  late RoleModel? roles;

  UserModel({
    required this.id,
    this.name,
    this.username,
    this.roleId,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        roleId: json["role_id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        roles: RoleModel.fromJson(json["roles"]),
      );
}
