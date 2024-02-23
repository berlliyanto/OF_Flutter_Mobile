import 'package:of_flutter_mobile/app/models/user_model.dart';

class EmployeeModel {
  late int? id, annualLeaveAllowance;
  late String? name, status;
  late UserModel? userModel;

  EmployeeModel(
      {this.id,
      this.name,
      this.annualLeaveAllowance,
      this.status,
      this.userModel});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      annualLeaveAllowance: json['annual_leave_allowance'].runtimeType is String
          ? int.parse(json['annual_leave_allowance'])
          : json['annual_leave_allowance'],
      status: json['status'],
      userModel:
          json['users'] != null ? UserModel.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['annual_leave_allowance'] = annualLeaveAllowance;
    data['status'] = status;
    data['users'] = userModel!.toJson();
    return data;
  }
}
