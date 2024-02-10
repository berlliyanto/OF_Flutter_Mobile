class AppVersionModel {
  late int? id, buildNumber;
  late String? version;

  AppVersionModel({
    this.id,
    this.buildNumber,
    this.version,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      id: json['id'],
      buildNumber: json['build_number'].runtimeType == String
          ? int.tryParse(json['build_number'])
          : json['build_number'],
      version: json['version'],
    );
  }
}
