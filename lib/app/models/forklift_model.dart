import 'package:of_flutter_mobile/app/models/checklist_model.dart';
import 'package:of_flutter_mobile/app/models/code_model.dart';
import 'package:of_flutter_mobile/app/models/location_model.dart';
import 'package:of_flutter_mobile/app/models/pic_model.dart';

class ForkliftModel {
  late int id;
  late int? codeId, locationId, picId, codeNumber;
  late String? unitCode;
  late LocationModel? location;
  late dynamic hourMeter, image;
  late PicModel? pic;
  late CodeModel? code;
  late List<ChecklistModel>? checklists;
  late DateTime? createdAt, updatedAt, lastCheckList;

  ForkliftModel({
    required this.id,
    this.codeId,
    this.codeNumber,
    this.locationId,
    this.picId,
    this.unitCode,
    this.image,
    this.location,
    this.hourMeter,
    this.pic,
    this.code,
    this.checklists,
    this.createdAt,
    this.updatedAt,
    this.lastCheckList,
  });

  factory ForkliftModel.fromJson(Map<String, dynamic> json) {
    return ForkliftModel(
      id: json['id'],
      codeId: json['code_id'],
      codeNumber: json['code_number'],
      locationId: json['location_id'],
      picId: json['pic_id'],
      unitCode: json['unit_code'],
      hourMeter: json['hour_meter'],
      code: json['codes'] == null ? null : CodeModel.fromJson(json['codes']),
      location: json['locations'] == null
          ? null
          : LocationModel.fromJson(json['locations']),
      pic: json['pics'] == null ? null : PicModel.fromJson(json['pics']),
      checklists: json['checklists'] == null
          ? []
          : List<ChecklistModel>.from(
              json['checklists'].map((x) => ChecklistModel.fromJson(x))),
      image: json['image'],
      lastCheckList: json['last_checklist'] == null
          ? null
          : DateTime.parse(json['last_checklist']),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(
              json["created_at"],
            ),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code_id'] = codeId;
    data['code_number'] = codeNumber;
    data['location_id'] = locationId;
    data['pic_id'] = picId;
    data['unit_code'] = unitCode;
    data['hour_meter'] = hourMeter;
    data['location'] = location!.toJson();
    data['pic'] = pic!.toJson();
    data['code'] = code!.toJson();
    data['checklists'] = checklists;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
