import 'package:of_flutter_mobile/app/models/location_model.dart';
import 'package:of_flutter_mobile/app/models/pic_model.dart';

class ForkliftModel {
  late int id, codeId, locationId, picId, codeNumber;
  late String unitCode;
  late LocationModel location;
  late dynamic hourMeter, image;
  late PicModel pic;
  late DateTime? createdAt, updatedAt, lastCheckList;

  ForkliftModel({
    required this.id,
    required this.codeId,
    required this.codeNumber,
    required this.locationId,
    required this.picId,
    required this.unitCode,
    required this.image,
    required this.location,
    required this.hourMeter,
    required this.pic,
    required this.createdAt,
    required this.updatedAt,
    required this.lastCheckList,
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
      location: LocationModel.fromJson(json['location']),
      pic: PicModel.fromJson(json['pic']),
      image: json['image'],
      lastCheckList: json['last_checklist'] == null
          ? null
          : DateTime.parse(json['last_checklist']),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
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
    data['location'] = location.toJson();
    data['pic'] = pic.toJson();
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
