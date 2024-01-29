import 'package:of_flutter_mobile/app/models/location_model.dart';
import 'package:of_flutter_mobile/app/models/pic_model.dart';

class ForkliftModel {
  late int id;
  late String unitCode;
  late LocationModel location;
  late dynamic hourMeter, image;
  late PicModel pic;

  ForkliftModel({
    required this.id,
    required this.unitCode,
    required this.image,
    required this.location,
    required this.hourMeter,
    required this.pic,
  });

  factory ForkliftModel.fromJson(Map<String, dynamic> json) {
    return ForkliftModel(
      id: json['id'],
      unitCode: json['unit_code'],
      hourMeter: json['hour_meter'],
      location: LocationModel.fromJson(json['location']),
      pic: PicModel.fromJson(json['pic']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_code'] = unitCode;
    data['hour_meter'] = hourMeter;
    data['location'] = location.toJson();
    data['pic'] = pic.toJson();
    data['image'] = image;

    return data;
  }
}
