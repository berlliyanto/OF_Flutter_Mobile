import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/workorder_model.dart';
import 'package:of_flutter_mobile/app/services/workorder/workorder_service.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListworkorderController extends GetxController {
  final TextEditingController searchUnitCodeController =
      TextEditingController();
  final scrollController = ScrollController();

  final List<Map<String, dynamic>> listStatus = [
    {"name": "created", "color": ColorPicker().soekimanPallet1},
    {"name": "approved", "color": ColorPicker().cyan},
    {"name": "proses", "color": ColorPicker().yellow},
  ];
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

  DateTime? month;
  final DateFormat dateFormat = DateFormat('MMMM yyyy');
  List<WorkorderModel> listWorkOrder = [];

  var isLoading = false.obs;
  var loadingScroll = false.obs;
  var isLoadingScroll = false.obs;
  var activeStatus = "created".obs;
  var period = "Select Period".obs;
  var activeQuery = "page=1&per_page=10&status=created".obs;
  var page = 1.obs;

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

  void refreshData(RefreshController refreshController) async {
    isLoadingScroll.value = false;
    page.value = 1;
    activeQuery.value =
        queryBuilder(activeQuery: activeQuery.value, query: "page=1");
    refreshController.refreshCompleted();
  }

  void onChange(String type, dynamic value) {
    switch (type) {
      case "unitCode":
        isLoadingScroll.value = false;
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "unit_code=$value");
        break;
      case "status":
        isLoadingScroll.value = false;
        activeStatus.value = value;
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "status=$value");
        break;
      case "page":
        isLoadingScroll.value = true;
        page.value += int.parse(value);
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=$page");
        print(activeQuery.value);
        break;
      default:
        break;
    }

    update();
  }

  Future<void> indexWorkOrder(String query) async {
    final response = await WorkorderService().indexWorkorder(query: query);
    if (response.statusCode == 200) {
      if (!isLoadingScroll.value) {
        listWorkOrder = (response.data['data'] as List)
            .map((e) => WorkorderModel.fromJson(e))
            .toList();
      } else {
        listWorkOrder.addAll((response.data['data'] as List)
            .map((e) => WorkorderModel.fromJson(e))
            .toList());
      }
      links = Links.fromJson(response.data['links']);
      meta = Meta.fromJson(response.data['meta']);
    }
  }

  Future<void> fetchAllAPI(String query) async {
    if (!isLoadingScroll.value) {
      isLoading.value = true;
    } else {
      loadingScroll.value = true;
    }
    update();

    await indexWorkOrder(query);

    if (!isLoadingScroll.value) {
      isLoading.value = false;
    } else {
      loadingScroll.value = false;
    }
    update();
  }

  void scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !loadingScroll.value) {
      if (listWorkOrder.length < meta.total) {
        log("${listWorkOrder.length}, ${meta.total}");
        onChange("page", "1");
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI(activeQuery.value);
    scrollController.addListener(scrollListener);
    debounce(activeQuery, time: 800.ms, (callback) async {
      await fetchAllAPI(activeQuery.value);
    });
  }
}
