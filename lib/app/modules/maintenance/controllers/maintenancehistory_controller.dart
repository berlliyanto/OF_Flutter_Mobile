import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/workorder_model.dart';
import 'package:of_flutter_mobile/app/services/workorder/workorder_service.dart';
import 'package:of_flutter_mobile/app/source/datatable/maintenancehistory_source.dart';
import 'package:of_flutter_mobile/app/utils/file_downloader.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MaintenancehistoryController extends GetxController {
  final MaintenanceHistorySource source = MaintenanceHistorySource();
  final TextEditingController searchUnitCodeController =
      TextEditingController();
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
  var isLoading = false.obs;
  var perPage = 10.obs;
  var activeQuery = "page=1&per_page=10".obs;
  var currentPage = 1.obs;
  var period = "Period".obs;

  void onChange(String type, dynamic value) {
    switch (type) {
      case "unitCode":
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "unit_code=$value");
        break;
      default:
        break;
    }

    update();
  }

  void resetQuery() {
    activeQuery.value = "page=1&per_page=10";
    searchUnitCodeController.clear();
    month = null;
    period.value = "Select Period";
    update();
  }

  Future<void> onRefresh(RefreshController refreshController) async {
    currentPage.value = 1;
    activeQuery.value = "page=1&per_page=10";
    await fetchAllAPI(activeQuery.value);
    refreshController.refreshCompleted();
  }

  void onPageChanged(int value) {
    int val = (value / perPage.value + 1).toInt();
    activeQuery.value =
        queryBuilder(activeQuery: activeQuery.value, query: "page=$val");
    currentPage.value = val;
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

  void handleExport() {
    if (month == null) {
      snackbar(title: "Info", message: "Please select period", type: "info");
      return;
    }

    String url = urlFileBuilder(
        transaction: "excel", type: "workorder", query: activeQuery.value);
    final FileDownloader fileDownloader = Get.find<FileDownloader>();
    fileDownloader.downloadDoc(url);
  }

  Future<void> indexMaintenanceHistory(String query) async {
    final response = await WorkorderService().indexWorkorder(query: query);
    if (response.statusCode == 200) {
      List<WorkorderModel> listWorkOrder = (response.data['data'] as List)
          .map((e) => WorkorderModel.fromJson(e))
          .toList();
      links = Links.fromJson(response.data['links']);
      meta = Meta.fromJson(response.data['meta']);
      source.setRow(meta.total, meta.currentPage, meta.perPage);
      source.updateDataFromController(listWorkOrder);
    }
  }

  Future<void> fetchAllAPI(String query) async {
    isLoading.value = true;
    update();
    await indexMaintenanceHistory(query);
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI(activeQuery.value);
    debounce(activeQuery, time: 800.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await indexMaintenanceHistory("${activeQuery.value}&");
      update();
      EasyLoading.dismiss();
    });
  }
}
