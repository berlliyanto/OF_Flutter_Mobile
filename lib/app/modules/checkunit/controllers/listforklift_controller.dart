import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/location/location_service.dart';
import 'package:of_flutter_mobile/app/services/pic/pic.dart';
import 'package:of_flutter_mobile/app/source/datatable/listforklift_source.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';

class ListforkliftController extends GetxController {
  final ListForkliftSource source = ListForkliftSource();
  final TextEditingController searchController = TextEditingController();
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

  List<dynamic> listLocation = [];
  List<dynamic> listPic = [];

  var isFocus = false.obs;
  var isLoading = false.obs;
  var location = 0.obs;
  var pic = 0.obs;
  var unitCode = "".obs;
  var query = "page=1&per_page=10".obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;

  void handleOnChange(dynamic value, String type) {
    switch (type) {
      case "unit_code":
        query.value =
            queryBuilder(activeQuery: query.value, query: "unit_code=$value");
        unitCode.value = value;
        break;
      case "location_id":
        location.value = value;
        query.value =
            queryBuilder(activeQuery: query.value, query: "location_id=$value");
        break;
      case "pic_id":
        pic.value = value;
        query.value =
            queryBuilder(activeQuery: query.value, query: "pic_id=$value");
        break;
      default:
        break;
    }
  }

  void onPageChanged(int value) {
    int val = (value / perPage.value + 1).toInt();
    query.value = queryBuilder(activeQuery: query.value, query: "page=$val");
    currentPage.value = val;
    update();
  }

  void onRowsPerPageChanged(int value) {
    query.value =
        queryBuilder(activeQuery: query.value, query: "per_page=$value");
    perPage.value = value;
    update();
  }

  void resetQuery() {
    query.value = "page=${currentPage.value}&per_page=${perPage.value}";
    unitCode.value = "";
    searchController.text = "";
    location.value = 0;
    pic.value = 0;
    update();
  }

  void handleOnUnFocus(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    isFocus.value = false;
    update();
  }

  Future getLocation() async {
    final response = await LocationService().indexLocation();
    if (response.data != null) {
      listLocation = response.data['data'];
    }
  }

  Future getPic() async {
    final response = await PicService().indexPic();
    if (response.data != null) {
      listPic = response.data['data'];
    }
  }

  Future getIndexForklift(String query) async {
    final response = await ForkliftService().indexForklift(query: query);
    if (response.data != null) {
      List<ForkliftModel> data = (response.data['data'] as List)
          .map((e) => ForkliftModel.fromJson(e))
          .toList();
      links = Links.fromJson(response.data['links']);
      meta = Meta.fromJson(response.data['meta']);
      source.setRow(meta.total, meta.currentPage, meta.perPage);
      source.updateDataFromController(data);
    }
  }

  Future fetchAllData() async {
    isLoading.value = true;
    update();
    await getPic();
    await getLocation();
    getIndexForklift("${query.value}&");
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
    debounce(query, time: 1000.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await getIndexForklift("${query.value}&");
      update();
      EasyLoading.dismiss();
    });
  }
}
