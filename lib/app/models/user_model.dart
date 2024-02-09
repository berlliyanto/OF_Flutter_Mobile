import 'package:of_flutter_mobile/app/models/checklist_model.dart';
import 'package:of_flutter_mobile/app/models/role_model.dart';

class UserModel {
  late int? id;
  late String? name;
  late String? username;
  late String? email;
  late String? manHour;
  late dynamic createdAt, updatedAt, lastChecklist, image;
  late List<RoleModel>? roles;
  late List<ChecklistModel>? checklists;

  UserModel({
    required this.id,
    this.name,
    this.username,
    this.email,
    this.manHour,
    this.lastChecklist,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.roles,
    this.checklists,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        manHour: json["man_hour"],
        lastChecklist: json["last_checklist"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        roles: json["roles"] == null
            ? []
            : List<RoleModel>.from(
                json["roles"]!.map((x) => RoleModel.fromJson(x))),
        checklists: json["checklists"] == null
            ? []
            : List<ChecklistModel>.from(
                (json["checklists"] as List).map(
                  (x) => ChecklistModel.fromJson(x),
                ),
              ),
      );
}
