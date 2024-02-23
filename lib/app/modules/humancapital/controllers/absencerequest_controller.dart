import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/models/paid_leave_model.dart';
import 'package:of_flutter_mobile/app/services/paidleave/paid_leave_service.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class AbsencerequestController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController totalDaysController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  final arg = Get.arguments;

  PaidLeaveModel paidLeave = PaidLeaveModel(id: 0);
  List<dynamic> paidLeaveTypes = [];
  DateTime? startDate, endDate;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  var isLoading = false.obs;
  var paidLeaveTypeValue = 0.obs;
  var formattedStartDate = "Start Date".obs;
  var formattedEndDate = "End Date".obs;
  var startTime = "Start Time".obs;
  var endTime = "End Time".obs;
  var status = "".obs;
  var rejectedBy = "".obs;
  var spvApproval = "".obs;
  var userApproval = "".obs;
  var managementApproval = "".obs;

  void onChange(String type, dynamic value) {
    switch (type) {
      case 'paidLeaveType':
        paidLeaveTypeValue.value = value;
        break;
      default:
        break;
    }

    update();
  }

  void resetDateAndTime() {
    formattedStartDate.value = "Start Date";
    formattedEndDate.value = "End Date";
    startTime.value = "Start Time";
    endTime.value = "End Time";
  }

  void getDate(BuildContext context, String type) async {
    if (type == "start") {
      final startDate = await pickDate(context, firstDate: DateTime.now());
      if (startDate != null) {
        formattedStartDate.value = formatter.format(startDate);
        this.startDate = startDate;
      }
    } else if (type == "end") {
      final endDate = await pickDate(context, firstDate: DateTime.now());
      if (endDate != null) {
        formattedEndDate.value = formatter.format(endDate);
        this.endDate = endDate;
      }
    }

    if (startDate != null && endDate != null) {
      final difference = calculateDateDifference(startDate!, endDate!) + 1;
      totalDaysController.text = difference.toString();
    }

    update();
  }

  void getTime(BuildContext context, String type) async {
    if (type == "start") {
      final startTime = await pickTime(context);
      if (startTime != null) {
        this.startTime.value = formatTime(startTime.hour, startTime.minute);
        update();
      }
    } else if (type == "end") {
      final endTime = await pickTime(context);
      if (endTime != null) {
        this.endTime.value = formatTime(endTime.hour, endTime.minute);
        update();
      }
    }
  }

  void getNameOfUser() {
    nameController.text = getUser()["name"] ?? "";
    update();
  }

  Future<void> getPaidLeaveTypes() async {
    final response = await PaidLeaveServices().types();
    if (response.data != null) {
      paidLeaveTypes = response.data['data'];
    }
  }

  Future<void> showPaidLeave() async {
    if (arg != null) {
      final response = await PaidLeaveServices().show(id: arg["id"]);
      if (response.data != null) {
        paidLeave = PaidLeaveModel.fromJson(response.data['data']);
        nameController.text = paidLeave.employee!.name.toString();
        paidLeaveTypeValue.value = paidLeave.paidLeaveTypeModel!.id!;
        reasonController.text = paidLeave.reason ?? "";
        startDate = DateTime.parse(paidLeave.from!.toString());
        endDate = DateTime.parse(paidLeave.to!.toString());
        formattedStartDate.value = formatter.format(startDate!);
        formattedEndDate.value = formatter.format(endDate!);
        totalDaysController.text = paidLeave.totalDays.toString();
        status.value = capitalizeFirstChar(paidLeave.status!);
        rejectedBy.value = paidLeave.rejectedBy;
        spvApproval.value = formatDate(paidLeave.supervisorApprovalDate);
        userApproval.value = formatDate(paidLeave.userApprovalDate);
        managementApproval.value = formatDate(paidLeave.managementApprovalDate);
        update();
      }
    }
  }

  void handleSend() async {
    if (paidLeaveTypeValue.value == 0 ||
        startDate == null ||
        endDate == null ||
        reasonController.text.isEmpty) {
      snackbar(
        title: "Warning",
        message: "Please fill all fields",
        type: "warning",
      );
      return;
    }

    Map<String, dynamic> data = {};
    data['paid_leave_type_id'] = paidLeaveTypeValue.value;
    data['from'] = startDate.toString();
    data['to'] = endDate.toString();
    data['total_days'] = int.parse(totalDaysController.text);
    data['status'] = "requested";
    data['reason'] = reasonController.text;

    EasyLoading.show(status: "Send...");
    final response = await PaidLeaveServices().store(data: data);
    if (response.data != null) {
      EasyLoading.dismiss();
      Get.back();
      snackbar(
        title: "Success",
        message: response.data['message'],
        type: "success",
      );
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> fetchAllAPI() async {
    isLoading.value = true;
    update();
    getNameOfUser();
    await getPaidLeaveTypes();
    await showPaidLeave();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI();
  }
}
