class CodeModel {
  late int id;
  late String name;

  CodeModel({required this.id, required this.name});

  factory CodeModel.fromJson(Map<String, dynamic> json) {
    return CodeModel(
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
