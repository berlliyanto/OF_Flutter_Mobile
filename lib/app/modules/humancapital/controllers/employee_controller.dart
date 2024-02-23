import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/employee_model.dart';
import 'package:of_flutter_mobile/app/services/employee/employee_service.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployeeController extends GetxController {
  final TextEditingController searchNameController = TextEditingController();
  final TextEditingController annualLeaveController = TextEditingController();
  final scrollController = ScrollController();

  List<EmployeeModel> employees = [];

  var isLoading = false.obs;
  var loadingScroll = false.obs;
  var isLoadingScroll = false.obs;
  var page = 1.obs;
  var sort = "asc".obs;
  var activeQuery = "page=1&per_page=10".obs;

  void refreshData(RefreshController refreshController) async {
    isLoadingScroll.value = false;
    page.value = 1;
    activeQuery.value =
        queryBuilder(activeQuery: activeQuery.value, query: "page=1");
    refreshController.refreshCompleted();
  }

  void scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingScroll.value) {
      handleOnChange("1", "page");
    }
  }

  void handleOnChange(String value, String type) {
    switch (type) {
      case "name":
        isLoadingScroll.value = false;
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=1");
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "name=$value");
      case "page":
        isLoadingScroll.value = true;
        page.value += int.parse(value);
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=$page");
      case "sort":
        isLoadingScroll.value = false;
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=1");
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "sort=$value");
      case "add":
        annualLeaveController.text =
            (int.parse(annualLeaveController.text) + 1).toString();
      case "min":
        if (annualLeaveController.text == "0") return;
        annualLeaveController.text =
            (int.parse(annualLeaveController.text) - 1).toString();
      default:
    }

    update();
  }

  Future<void> getEmployees(String query) async {
    if (!isLoadingScroll.value) {
      isLoading.value = true;
    } else {
      loadingScroll.value = true;
    }
    update();

    final response = await EmployeeService().index(query: query);
    if (response.data != null) {
      if (!isLoadingScroll.value) {
        employees = (response.data['data'] as List)
            .map((e) => EmployeeModel.fromJson(e))
            .toList();
      } else {
        employees.addAll((response.data['data'] as List)
            .map((e) => EmployeeModel.fromJson(e))
            .toList());
      }
    }

    if (!isLoadingScroll.value) {
      isLoading.value = false;
    } else {
      loadingScroll.value = false;
    }
    update();
  }

  Future<void> updateAnnualLeaveAllowance(int id) async {
    EasyLoading.show(status: "Loading...");
    final response = await EmployeeService().updateAllowance(
        allowance: int.parse(annualLeaveController.text), id: id);
    if (response.data != null) {
      Get.back();
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Success Update");
      await getEmployees("page=1&per_page=10");
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getEmployees(activeQuery.value);
    scrollController.addListener(scrollListener);
    debounce(activeQuery, time: 800.ms, (callback) {
      getEmployees(activeQuery.value);
    });
  }
}
