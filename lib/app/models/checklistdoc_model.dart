class ChecklistDocModel {
  late int id;
  late int? checklistId;
  late dynamic imageFront;
  late dynamic imageBack;
  late dynamic imageRight;
  late dynamic imageLeft;
  late dynamic forkliftNotes;
  late dynamic safetyNotes;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ChecklistDocModel({
    required this.id,
    this.checklistId,
    this.imageFront,
    this.imageBack,
    this.imageRight,
    this.imageLeft,
    this.forkliftNotes,
    this.safetyNotes,
    this.createdAt,
    this.updatedAt,
  });

  factory ChecklistDocModel.fromJson(Map<String, dynamic> json) {
    return ChecklistDocModel(
      id: json['id'],
      checklistId: json['checklist_id'].runtimeType == String
          ? int.tryParse(json['checklist_id'])
          : json['checklist_id'],
      imageFront: json['image_front'],
      imageBack: json['image_back'],
      imageRight: json['image_right'],
      imageLeft: json['image_left'],
      forkliftNotes: json['forklift_notes'],
      safetyNotes: json['safety_notes'],
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
    data['checklist_id'] = checklistId;
    data['image_front'] = imageFront;
    data['image_back'] = imageBack;
    data['image_right'] = imageRight;
    data['image_left'] = imageLeft;
    data['forklift_notes'] = forkliftNotes;
    data['safety_notes'] = safetyNotes;
    return data;
  }
}
