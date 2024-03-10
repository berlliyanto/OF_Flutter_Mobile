import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/employee_model.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/salary_model.dart';
import 'package:of_flutter_mobile/app/services/employee/employee_service.dart';
import 'package:of_flutter_mobile/app/services/salary/salary_service.dart';
import 'package:of_flutter_mobile/app/source/datatable/salary_source.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';

class SalaryController extends GetxController {
  final TextEditingController searchNameController = TextEditingController();
  final TextEditingController searchDropDownController =
      TextEditingController();
  final TextEditingController textFileController = TextEditingController();
  final SalaryDatatable source = SalaryDatatable();
  final ScrollController scrollControllerSearchDropdown = ScrollController();
  Links links = Links(first: "", last: "", prev: "", next: "");
  Meta meta = Meta(
    currentPage: 1,
    from: null,
    lastPage: 1,
    perPage: 10,
    to: null,
    path: "",
    total: 0,
    links: [],
  );

  List<Map<String, dynamic>> employees = [];
  DateTime? month;
  final DateFormat dateFormat = DateFormat('MMMM yyyy');
  File? attachment;

  var period = "Select Period".obs;
  var activeQuery = "page=1&per_page=10".obs;
  var activeQueryEmployee = "page=1&per_page=10".obs;
  var page = 1.obs;
  var perPage = 10.obs;
  var isLoading = false.obs;
  var employeeId = 0;

  void handleOnChange(String value, String type) {
    switch (type) {
      case "employee":
        page.value = 1;
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=1");
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "employee=$value");
    }
  }

  void onPageChanged(int value) {
    int val = (value / perPage.value + 1).toInt();
    activeQuery.value =
        queryBuilder(activeQuery: activeQuery.value, query: "page=$val");
    page.value = val;
    update();
  }

  void onRowsPerPageChanged(int value) {
    activeQuery.value =
        queryBuilder(activeQuery: activeQuery.value, query: "per_page=$value");
    perPage.value = value;
    update();
  }

  void onPeriodPicked(BuildContext context) async {
    final month = await pickMonth(context);
    if (month != null) {
      this.month = month;
      period.value = dateFormat.format(month);
      activeQuery.value =
          queryBuilder(activeQuery: activeQuery.value, query: "month=$month");
      update();
    }
  }

  void onFileSelected() async {
    try {
      EasyLoading.show(status: "Loading...");
      dynamic file = await pickPDF();
      EasyLoading.dismiss();
      if (file != null) {
        if (file["size"] > 1 * 1024 * 1024) {
          toast(message: "File too large");
          return;
        }
        toast(message: "File Selected");
        textFileController.text = file["name"];
        attachment = file["file"];
        update();
      } else {
        toast(message: "File not selected");
      }
    } catch (e) {
      log(e.toString());
      toast(message: "Failed to pick file");
    }
  }

  void onTypeAheadSelected(Map<String, dynamic> value) {
    employeeId = value['id'];
    searchDropDownController.text = value['name'];
  }

  void onCloseBottomSheet() {
    attachment = null;
    employeeId = 0;
    searchDropDownController.clear();
    textFileController.clear();
    update();
  }

  Future suggestions(String query) async {
    employees.clear();
    String newQuery = queryBuilder(
        activeQuery: activeQueryEmployee.value, query: "name=$query");
    await indexEmployees(query: newQuery);
    return employees;
  }

  void onSubmit() async {
    if (employeeId == 0) {
      toast(message: "Employee not selected");
      return;
    }

    if (attachment == null) {
      toast(message: "Attachment not selected");
      return;
    }

    Map<String, dynamic> data = {};
    data["employee_id"] = employeeId;
    data["document"] =
        await MultipartFile.fromFile(attachment!.path, filename: "document");

    final FormData formData = FormData.fromMap(data);
    EasyLoading.show(status: "Uploading...");
    final response = await SalaryService().storeSalary(data: formData);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Success");
      Get.back();
      indexSalary("page=1&per_page=10");
      update();
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> indexEmployees({String query = ""}) async {
    final response = await EmployeeService().index(query: query);
    if (response.data != null) {
      List<EmployeeModel> listForkliftModel = (response.data['data'] as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList();
      for (var item in listForkliftModel) {
        employees.add({
          "id": item.id,
          "name": item.name,
        });
      }
      update();
    }
  }

  Future<void> indexSalary(String query) async {
    final response = await SalaryService().indexSalary(query: query);
    if (response.data != null) {
      List<SalaryModel> listSalary = (response.data['data'] as List)
          .map((e) => SalaryModel.fromJson(e))
          .toList();
      source.updateDataFromController(listSalary);
      links = Links.fromJson(response.data['links']);
      meta = Meta.fromJson(response.data['meta']);
      source.setRow(meta.total, meta.currentPage, meta.perPage);
      update();
    }
  }

  void fetchAllAPI() async {
    isLoading.value = true;
    update();
    await indexEmployees(query: activeQueryEmployee.value);
    await indexSalary(activeQuery.value);
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI();
    debounce(activeQuery, time: 800.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await indexSalary(activeQuery.value);
      EasyLoading.dismiss();
      update();
    });
  }
}
