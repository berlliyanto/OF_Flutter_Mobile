import 'package:of_flutter_mobile/app/models/employee_model.dart';

class PaidLeaveModel {
  late int? id, totalDays;
  late EmployeeModel? employee;
  late PaidLeaveTypeModel? paidLeaveTypeModel;
  late String? reason, status;
  late DateTime? from, to, createdAt, updatedAt;
  late dynamic rejectedBy,
      supervisorApprovalDate,
      userApprovalDate,
      managementApprovalDate;

  PaidLeaveModel(
      {required this.id,
      this.totalDays,
      this.employee,
      this.paidLeaveTypeModel,
      this.from,
      this.to,
      this.reason,
      this.status,
      this.rejectedBy,
      this.createdAt,
      this.managementApprovalDate,
      this.userApprovalDate,
      this.supervisorApprovalDate,
      this.updatedAt});

  factory PaidLeaveModel.fromJson(Map<String, dynamic> json) {
    return PaidLeaveModel(
      id: json['id'],
      totalDays: json['total_days'].runtimeType is String
          ? int.parse(json['total_days'])
          : json['total_days'],
      employee: json['employees'] == null
          ? null
          : EmployeeModel.fromJson(json['employees']),
      paidLeaveTypeModel: json['paid_leave_types'] == null
          ? null
          : PaidLeaveTypeModel.fromJson(json['paid_leave_types']),
      reason: json['reason'],
      status: json['status'],
      rejectedBy: json['rejected_by'] ?? "",
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      managementApprovalDate: json['management_approval_date'] != null
          ? DateTime.parse(json['management_approval_date'])
          : null,
      userApprovalDate: json['user_approval_date'] != null
          ? DateTime.parse(json['user_approval_date'])
          : null,
      supervisorApprovalDate: json['supervisor_approval_date'] != null
          ? DateTime.parse(json['supervisor_approval_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_days'] = totalDays;
    data['employee'] = employee?.toJson();
    data['paid_leave_type'] = paidLeaveTypeModel?.toJson();
    data['reason'] = reason;
    data['status'] = status;
    data['from'] = from;
    data['to'] = to;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['management_approval_date'] = managementApprovalDate;
    data['user_approval_date'] = userApprovalDate;
    data['supervisor_approval_date'] = supervisorApprovalDate;

    return data;
  }
}

class PaidLeaveTypeModel {
  late int? id;
  late String? name;

  PaidLeaveTypeModel({required this.id, required this.name});

  factory PaidLeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return PaidLeaveTypeModel(
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
