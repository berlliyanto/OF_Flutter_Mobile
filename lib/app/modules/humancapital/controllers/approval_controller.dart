import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/paid_leave_model.dart';
import 'package:of_flutter_mobile/app/services/paidleave/paid_leave_service.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApprovalController extends GetxController {
  final TextEditingController searchNameController = TextEditingController();
  final scrollController = ScrollController();

  List<PaidLeaveModel> listPaidLeave = [];

  var sort = "asc".obs;
  var activeQuery = "page=1&per_page=10".obs;
  var isLoading = false.obs;
  var loadingScroll = false.obs;
  var isLoadingScroll = false.obs;
  var page = 1.obs;

  void handleOnChange(dynamic value, String type) {
    switch (type) {
      case "sort":
        isLoadingScroll.value = false;
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=1");
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "sort=$value");
        break;
      case "page":
        isLoadingScroll.value = true;
        page.value += int.parse(value);
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=$page");
        break;
      case "name":
        isLoadingScroll.value = false;
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=1");
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "name=$value");
      default:
        break;
    }

    update();
  }

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

  void approveOrReject(String status, int id) async {
    EasyLoading.show(status: "Loading...");
    final response = await PaidLeaveServices().approve(status: status, id: id);
    if (response.data != null) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(capitalizeFirstChar(status));
      await getNeedApproves("page=1&per_page=10");
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> getNeedApproves(String query) async {
    if (!isLoadingScroll.value) {
      isLoading.value = true;
    } else {
      loadingScroll.value = true;
    }
    update();

    final response = await PaidLeaveServices().needApprove(query: query);
    if (response.data != null) {
      if (!isLoadingScroll.value) {
        listPaidLeave = (response.data['data'] as List)
            .map((e) => PaidLeaveModel.fromJson(e))
            .toList();
      } else {
        listPaidLeave.addAll((response.data['data'] as List)
            .map((e) => PaidLeaveModel.fromJson(e))
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

  @override
  void onInit() {
    super.onInit();
    getNeedApproves(activeQuery.value);
    scrollController.addListener(scrollListener);
    debounce(activeQuery, time: 800.ms, (callback) {
      getNeedApproves(activeQuery.value);
    });
  }
}
