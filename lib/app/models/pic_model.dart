class PicModel {
  late int id;
  late String name;

  PicModel({required this.id, required this.name});

  factory PicModel.fromJson(Map<String, dynamic> json) {
    return PicModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}
