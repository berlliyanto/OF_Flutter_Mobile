import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/checklist_model.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/services/checklist/checklist_service.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/location/location_service.dart';
import 'package:of_flutter_mobile/app/source/datatable/checkhistory_source.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';

class CheckhistoryController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final CheckHistorySource source = CheckHistorySource();
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

  var isLoading = false.obs;
  var valueLocation = 0.obs;
  var activeQuery = "page=1&per_page=10".obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;
  var isAllLocationChecked = false.obs;

  List<dynamic> listLocation = [];
  List<Map<String, dynamic>> listForklifts = [];

  void onChangedInput(String type, dynamic value) {
    switch (type) {
      case "location":
        valueLocation.value = value;
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "location_id=$value");
        break;
      case "search":
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "search=$value");
        break;
      case "all_location":
        if (value) {
          isAllLocationChecked.value = true;
          activeQuery.value = removeQuery(activeQuery.value, "location_id");
        } else {
          isAllLocationChecked.value = false;
          activeQuery.value = queryBuilder(
              activeQuery: activeQuery.value,
              query: "location_id=${valueLocation.value}");
        }
      default:
    }

    update();
  }

  void resetQuery() {
    activeQuery.value = "page=${currentPage.value}&per_page=${perPage.value}";
    unitController.text = "";
    searchController.text = "";
    valueLocation.value = 0;
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

  void onTypeAheadSelected(Map<String, dynamic> value) {
    unitController.text = value['name'];
    activeQuery.value = queryBuilder(
        activeQuery: activeQuery.value, query: "unit_code=${value['name']}");
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
        print(item.updatedAt);
        listForklifts.add({
          "id": item.id,
          "name": item.unitCode,
        });
      }
      update();
    }
  }

  Future<void> indexChecklist({String query = ""}) async {
    final response = await CheckListService().indexCheckList(query: query);
    if (response.data != null) {
      final data = (response.data['data'] as List)
          .map((e) => ChecklistModel.fromJson(e))
          .toList();
      links = Links.fromJson(response.data['links']);
      meta = Meta.fromJson(response.data['meta']);
      source.setRow(meta.total, meta.currentPage, meta.perPage);
      source.updateDataFromController(data);
    }
  }

  Future getLocation() async {
    final response = await LocationService().indexLocation();
    if (response.data != null) {
      listLocation = response.data['data'];
    }
  }

  void fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getLocation();
    await indexChecklist(query: activeQuery.value);
    isLoading.value = false;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchAllAPI();
    debounce(activeQuery, time: 300.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await indexChecklist(query: "${activeQuery.value}&");
      update();
      EasyLoading.dismiss();
    });
  }
}
