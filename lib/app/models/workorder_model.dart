import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';

class WorkorderModel {
  late int? id, isCanceled;
  late UserModel? userModel;
  late ForkliftModel? forkliftModel;
  late String? description, status, unitBreakdown;
  late DateTime? createdAt, updatedAt;
  late dynamic startTimeInspection,
      endTimeInspection,
      canceledNote,
      startInspectionNote,
      endInspectionNote,
      verificationSupervisor;

  WorkorderModel({
    this.id,
    this.userModel,
    this.forkliftModel,
    this.description,
    this.status,
    this.unitBreakdown,
    this.startTimeInspection,
    this.endTimeInspection,
    this.canceledNote,
    this.isCanceled,
    this.startInspectionNote,
    this.endInspectionNote,
    this.verificationSupervisor,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkorderModel.fromJson(Map<String, dynamic> json) {
    return WorkorderModel(
      id: json['id'],
      userModel:
          json['users'] != null ? UserModel.fromJson(json['users']) : null,
      forkliftModel: json['forklifts'] != null
          ? ForkliftModel.fromJson(json['forklifts'])
          : null,
      description: json['description'],
      status: json['status'],
      unitBreakdown: json['unit_breakdown'],
      startTimeInspection: json['start_time_inspection'],
      endTimeInspection: json['end_time_inspection'],
      canceledNote: json['canceled_note'],
      isCanceled: json['is_canceled'],
      startInspectionNote: json['start_inspection_note'],
      endInspectionNote: json['end_inspection_note'],
      verificationSupervisor: json['verification_supervisor'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['users'] = userModel?.toJson();
    data['forklifts'] = forkliftModel?.toJson();
    data['description'] = description;
    data['status'] = status;
    data['unit_breakdown'] = unitBreakdown;
    data['start_time_inspection'] = startTimeInspection;
    data['end_time_inspection'] = endTimeInspection;
    data['canceled_note'] = canceledNote;
    data['is_canceled'] = isCanceled;
    data['start_inspection_note'] = startInspectionNote;
    data['end_inspection_note'] = endInspectionNote;
    data['verification_supervisor'] = verificationSupervisor;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
