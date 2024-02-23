import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/paid_leave_model.dart';
import 'package:of_flutter_mobile/app/services/paidleave/paid_leave_service.dart';
import 'package:of_flutter_mobile/app/source/datatable/paidleave_source.dart';
import 'package:of_flutter_mobile/app/utils/file_downloader.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

class AbsencehistoryController extends GetxController {
  final TextEditingController searchNameController = TextEditingController();
  final PaidLeaveDatatable source = PaidLeaveDatatable();
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

  List<dynamic> paidLeaveTypes = [];
  List<dynamic> statusList = [
    {"id": 1, "name": "Requested"},
    {"id": 2, "name": "On Process"},
    {"id": 3, "name": "Approved"},
    {"id": 4, "name": "Rejected"},
  ];

  DateTime? month;
  final DateFormat dateFormat = DateFormat('MMMM yyyy');

  var isLoading = false.obs;
  var activeQuery = "page=1&per_page=10".obs;
  var paidLeaveType = 0.obs;
  var statusId = 0.obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;
  var period = "Select Period".obs;

  void onChange(dynamic value, String type) {
    activeQuery.value = "page=1&per_page=10";
    switch (type) {
      case 'name':
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: 'name=$value');
        break;
      case 'paidLeaveType':
        paidLeaveType.value = value;
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: 'paid_leave_type_id=$value');
        break;
      case 'status':
        statusId.value = value;
        String key = "";
        for (var status in statusList) {
          if (status['id'] == value) {
            key = status['name'].toLowerCase();
          }
        }
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: 'status=$key');
        break;
      default:
        break;
    }

    update();
  }

  void resetQuery() {
    activeQuery.value = "page=1&per_page=10";
    searchNameController.clear();
    paidLeaveType.value = 0;
    statusId.value = 0;
    month = null;
    period.value = "Select Period";
    update();
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

  void handleExport() async {
    if (month == null) {
      snackbar(title: "Info", message: "Please select period", type: "info");
      return;
    }
    String url = urlFileBuilder(
        transaction: "excel", type: "paidleave", query: activeQuery.value);
    final FileDownloader fileDownloader = Get.find<FileDownloader>();
    fileDownloader.downloadDoc(url);
  }

  Future<void> getPaidLeaveTypes() async {
    final response = await PaidLeaveServices().types();
    if (response.data != null) {
      paidLeaveTypes = response.data['data'];
    }
  }

  Future<void> getPaidLeaves(String query) async {
    final response = await PaidLeaveServices().index(query: query);
    if (response.data != null) {
      List<PaidLeaveModel> paidLeaveData = (response.data['data'] as List)
          .map((e) => PaidLeaveModel.fromJson(e))
          .toList();
      links = Links.fromJson(response.data['links']);
      meta = Meta.fromJson(response.data['meta']);

      source.setRow(meta.total, meta.currentPage, meta.perPage);
      source.updateDataFromController(paidLeaveData);
      update();
    }
  }

  Future<void> fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getPaidLeaveTypes();
    await getPaidLeaves(activeQuery.value);
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI();
    debounce(activeQuery, time: 800.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await getPaidLeaves(activeQuery.value);
      EasyLoading.dismiss();
      update();
    });
  }
}
