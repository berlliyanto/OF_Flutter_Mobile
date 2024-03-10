import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:of_flutter_mobile/app/components/widgets/dialog/awesome_dialog.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/workorder_model.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/workorder/workorder_service.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class WorkorderController extends GetxController {
  final TextEditingController searchDropDownController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController firstInspectionNoteController =
      TextEditingController();
  final TextEditingController endInspectionNoteController =
      TextEditingController();
  final TextEditingController cancelWOReasonController =
      TextEditingController();
  final arg = Get.arguments;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  List<Map<String, dynamic>> listForklifts = [];
  Map<String, dynamic> woData = {};
  WorkorderModel workorderModel = WorkorderModel();

  var activeQuery = "page=1&per_page=10".obs;
  var isLoading = false.obs;
  var formattedStartDate = "Select Date".obs;
  var formattedStartTime = "Select Time".obs;
  var formattedEndDate = "Select Date".obs;
  var formattedEndTime = "Select Time".obs;

  void onChange(String type, dynamic value) async {
    switch (type) {
      case "date":
        final date = await pickDate(Get.context!);
        if (date != null) {
          selectedDate = date;
          if (value == "start") {
            formattedStartDate.value = dateFormat.format(date);
          } else {
            formattedEndDate.value = dateFormat.format(date);
          }
        }
      case "time":
        final time = await pickTime(Get.context!);
        if (time != null) {
          selectedTime = time;
          if (value == "start") {
            formattedStartTime.value = "${time.hour}:${time.minute}";
          } else {
            formattedEndTime.value = "${time.hour}:${time.minute}";
          }
        }
      default:
        break;
    }

    update();
  }

  void onTypeAheadSelected(Map<String, dynamic> value) {
    woData["forklift_id"] = value['id'];
    searchDropDownController.text = value['name'];
  }

  Future suggestions(String query) async {
    listForklifts.clear();
    String newQuery =
        queryBuilder(activeQuery: activeQuery.value, query: "unit_code=$query");
    await indexForklift(query: newQuery);
    return listForklifts;
  }

  Future<void> indexForklift({String query = ""}) async {
    final response = await ForkliftService().indexForklift(query: query);
    if (response.data != null) {
      List<ForkliftModel> listForkliftModel = (response.data['data'] as List)
          .map((e) => ForkliftModel.fromJson(e))
          .toList();
      for (var item in listForkliftModel) {
        listForklifts.add({
          "id": item.id,
          "name": item.unitCode,
        });
      }
      update();
    }
  }

  Future<void> showWO() async {
    if (arg != null) {
      final response = await WorkorderService().showWorkorder(id: arg['id']);
      if (response.statusCode == 200) {
        workorderModel = WorkorderModel.fromJson(response.data['data']);
        descriptionController.text = response.data['data']['description'];
        formattedStartDate.value = workorderModel.startTimeInspection != null
            ? workorderModel.startTimeInspection!.split(" ")[0]
            : "Select Date";
        formattedStartTime.value = workorderModel.startTimeInspection != null
            ? workorderModel.startTimeInspection!.split(" ")[1]
            : "Select Time";
        firstInspectionNoteController.text =
            workorderModel.startInspectionNote ?? "";

        formattedEndDate.value = workorderModel.endTimeInspection != null
            ? workorderModel.endTimeInspection!.split(" ")[0]
            : "Select Date";
        formattedEndTime.value = workorderModel.endTimeInspection != null
            ? workorderModel.endTimeInspection!.split(" ")[1]
            : "Select Time";
        endInspectionNoteController.text =
            workorderModel.endInspectionNote ?? "";
        update();
      }
    }
  }

  Future<void> onOrder() async {
    if (woData["forklift_id"] == null) {
      snackbar(
          title: "Warning", message: "Please select forklift", type: "warning");
      return;
    }

    if (descriptionController.text.isEmpty) {
      snackbar(
          title: "Warning",
          message: "Please input description",
          type: "warning");
      return;
    }

    woData['description'] = descriptionController.text;

    EasyLoading.show(status: "Loading...");
    final response = await WorkorderService().storeWorkorder(data: woData);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      Get.back();
      snackbar(
          title: "Success", message: response.data['message'], type: "success");
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> onVerify() async {
    Map<String, dynamic> verifyData = {};
    if (getUser()['role'] == "Mekanik") {
      if (selectedDate == null ||
          selectedTime == null ||
          firstInspectionNoteController.text.isEmpty) {
        snackbar(
            title: "Warning",
            message: "Please fill all fields",
            type: "warning");
        return;
      }
      verifyData["start_time_inspection"] =
          concatDateAndTime(selectedDate!, selectedTime!);
      verifyData["start_inspection_note"] = firstInspectionNoteController.text;
    }

    EasyLoading.show(status: "Loading...");
    final response = await WorkorderService()
        .verifyWorkorder(id: arg['id'], data: verifyData);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Success Verified");
      Get.back();
      Get.back();
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> onFinish() async {
    if (selectedDate == null ||
        selectedTime == null ||
        endInspectionNoteController.text.isEmpty) {
      snackbar(
          title: "Warning", message: "Please fill all fields", type: "warning");
      return;
    }

    Map<String, dynamic> finishData = {};
    finishData["end_time_inspection"] =
        concatDateAndTime(selectedDate!, selectedTime!);
    finishData["end_inspection_note"] = endInspectionNoteController.text;

    EasyLoading.show(status: "Loading...");
    final response = await WorkorderService()
        .finishWorkorder(id: arg['id'], data: finishData);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Success Finished");
      Get.back();
      Get.back();
    } else {
      EasyLoading.dismiss();
    }
  }

  void onCancelWO() {
    if (cancelWOReasonController.text.isEmpty) {
      snackbar(
          title: "Warning", message: "Please fill reason", type: "warning");
      return;
    }

    Map<String, dynamic> cancelData = {};
    cancelData['canceled_note'] = cancelWOReasonController.text;
    awesomeDialog(
      title: "Cancel Workorder",
      desc: "Are you sure want to cancel ?",
      type: DialogType.question,
      cancel: () {},
      callback: () async {
        EasyLoading.show(status: "Loading...");
        final response = await WorkorderService()
            .cancelWorkorder(id: arg['id'], data: cancelData);

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Success Canceled");
          Get.back();
          Get.back();
        } else {
          EasyLoading.dismiss();
        }
      },
    );
  }

  void onDeleteWO() {
    awesomeDialog(
      title: "Delete Workorder",
      desc: "Are you sure want to delete ?",
      type: DialogType.question,
      cancel: () {},
      callback: () async {
        EasyLoading.show(status: "Loading...");
        final response =
            await WorkorderService().destroyWorkorder(id: arg['id']);
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Success Deleted");
          Get.back();
          Get.back();
        } else {
          EasyLoading.dismiss();
        }
      },
    );
  }

  Future<void> fetchAllAPI() async {
    isLoading.value = true;
    update();
    await showWO();
    await indexForklift();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI();
  }
}
