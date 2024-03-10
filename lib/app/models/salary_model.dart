import 'package:of_flutter_mobile/app/models/employee_model.dart';

class SalaryModel {
  late int? id, employeeId;
  late EmployeeModel? employeeModel;
  late String? document;
  late DateTime? createdAt, updatedAt;

  SalaryModel({
    this.id,
    this.employeeId,
    this.employeeModel,
    this.document,
    this.createdAt,
    this.updatedAt,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      id: json['id'],
      employeeId: json['employee_id'],
      employeeModel: json['employees'] != null
          ? EmployeeModel.fromJson(json['employees'])
          : null,
      document: json['document'],
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
    data['employee_id'] = employeeId;
    data['document'] = document;
    data['employees'] = employeeModel!.toJson();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
