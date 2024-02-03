import 'package:of_flutter_mobile/app/models/checklistdoc_model.dart';
import 'package:of_flutter_mobile/app/models/checklistitem_model.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/operator_model.dart';
import 'package:of_flutter_mobile/app/models/shift_model.dart';

class ChecklistModel {
  late int id;
  late String unitCode, formCode;
  late int palletAmount;
  late dynamic verificationSupervisor;
  late dynamic verificationUser;
  late ForkliftModel forklift;
  late OperatorModel operator;
  late ShiftModel shift;
  late ChecklistItemModel items;
  late ChecklistDocModel docs;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ChecklistModel({
    required this.id,
    required this.unitCode,
    required this.formCode,
    required this.palletAmount,
    required this.verificationSupervisor,
    required this.verificationUser,
    required this.forklift,
    required this.operator,
    required this.shift,
    required this.items,
    required this.docs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json['id'],
      formCode: json['form_code'],
      unitCode: json['unit_code'],
      palletAmount: json['pallet_amount'],
      verificationSupervisor: json['verification_supervisor'],
      verificationUser: json['verification_user'],
      forklift: ForkliftModel.fromJson(json['forklift']),
      operator: OperatorModel.fromJson(json['operator']),
      shift: ShiftModel.fromJson(json['shift']),
      items: ChecklistItemModel.fromJson(json['items']),
      docs: ChecklistDocModel.fromJson(json['docs']),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}
