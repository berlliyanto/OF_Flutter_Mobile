import 'package:of_flutter_mobile/app/models/checklistdoc_model.dart';
import 'package:of_flutter_mobile/app/models/checklistitem_model.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/operator_model.dart';
import 'package:of_flutter_mobile/app/models/shift_model.dart';

class ChecklistModel {
  late int id;
  late String? unitCode, formCode, manHourStart, manHourEnd, forkliftHourMeter;
  late int? palletAmount, manHour;
  late dynamic verificationSupervisor;
  late dynamic verificationUser;
  late ForkliftModel? forklift;
  late OperatorModel? operator;
  late ShiftModel? shift;
  late ChecklistItemModel? items;
  late ChecklistDocModel? docs;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ChecklistModel({
    required this.id,
    this.unitCode,
    this.formCode,
    this.palletAmount,
    this.manHour,
    this.manHourStart,
    this.manHourEnd,
    this.forkliftHourMeter,
    this.verificationSupervisor,
    this.verificationUser,
    this.forklift,
    this.operator,
    this.shift,
    this.items,
    this.docs,
    this.createdAt,
    this.updatedAt,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json['id'],
      formCode: json['form_code'],
      unitCode: json['unit_code'],
      palletAmount: json['pallet_amount'],
      manHour: json['man_hour'],
      manHourStart: json['man_hour_start'],
      manHourEnd: json['man_hour_end'],
      forkliftHourMeter: json['forklift_hour_meter'],
      verificationSupervisor: json['verification_supervisor'],
      verificationUser: json['verification_user'],
      forklift: json['forklifts'] == null
          ? null
          : ForkliftModel.fromJson(json['forklifts']),
      operator: json['operators'] == null
          ? null
          : OperatorModel.fromJson(json['operators']),
      shift:
          json['shifts'] == null ? null : ShiftModel.fromJson(json['shifts']),
      items: json['items'] == null
          ? null
          : ChecklistItemModel.fromJson(json['items']),
      docs: json['docs'] == null
          ? null
          : ChecklistDocModel.fromJson(json['docs']),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}
