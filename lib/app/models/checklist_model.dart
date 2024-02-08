import 'package:of_flutter_mobile/app/models/checklistdoc_model.dart';
import 'package:of_flutter_mobile/app/models/checklistitem_model.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/operator_model.dart';
import 'package:of_flutter_mobile/app/models/shift_model.dart';

class ChecklistModel {
  late int id;
  late String? unitCode,
      formCode,
      manHourStart,
      manHourEnd,
      forkliftHourMeter,
      manHour;
  late int? palletAmount;
  late dynamic verificationSupervisor;
  late dynamic verificationUser;
  late ForkliftModel? forklift;
  late OperatorModel? operator;
  late ShiftModel? shift;
  late ChecklistItemModel? items;
  late ChecklistDocModel? docs;
  late DateTime? createdAt;
  late DateTime? updatedAt;
  late DateTime? formattedCreatedAt;
  late DateTime? formattedupdatedAt;

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
    this.formattedCreatedAt,
    this.formattedupdatedAt,
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
      verificationSupervisor: json['verification_supervisor'] == null
          ? null
          : DateTime.parse(json['verification_supervisor']),
      verificationUser: json['verification_user'] == null
          ? null
          : DateTime.parse(json['verification_user']),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      formattedCreatedAt: json['formatted_created_at'] == null
          ? null
          : DateTime.parse(json['formatted_created_at']),
      formattedupdatedAt: json['formatted_updated_at'] == null
          ? null
          : DateTime.parse(json['formatted_updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final Map<String, dynamic> main = <String, dynamic>{};

    main['id'] = id;
    main['form_code'] = formCode;
    main['unit_code'] = unitCode;
    main['pallet_amount'] = palletAmount;
    main['man_hour'] = manHour;
    main['man_hour_start'] = manHourStart;
    main['man_hour_end'] = manHourEnd;
    main['forklift_hour_meter'] = forkliftHourMeter;
    main['verification_supervisor'] = verificationSupervisor;
    main['verification_user'] = verificationUser;
    main['forklifts'] = forklift!.toJson();
    main['operators'] = operator!.toJson();
    main['shifts'] = shift!.toJson();
    main['created_at'] = createdAt;
    main['updated_at'] = updatedAt;
    main['formatted_created_at'] = formattedCreatedAt;
    main['formatted_updated_at'] = formattedupdatedAt;

    data['main'] = main;
    data['items'] = items!.toJson();
    data['docs'] = docs!.toJson();

    return data;
  }
}
