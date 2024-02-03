class ChecklistDocModel {
  late int id;
  late int checklistId;
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
    required this.checklistId,
    required this.imageFront,
    required this.imageBack,
    required this.imageRight,
    required this.imageLeft,
    required this.forkliftNotes,
    required this.safetyNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistDocModel.fromJson(Map<String, dynamic> json) {
    return ChecklistDocModel(
      id: json['id'],
      checklistId: json['checklist_id'],
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
}
