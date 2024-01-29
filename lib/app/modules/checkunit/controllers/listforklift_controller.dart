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

class ListforkliftController extends GetxController {
  final ListForkliftSource source = ListForkliftSource();
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

  List<dynamic> locationModel = [];
  List<dynamic> picModel = [];
  List<ForkliftModel> forkliftModel = [];

  var isFocus = false.obs;
  var query = "page=1&".obs;
  var isLoading = false.obs;
  var location = 0.obs;
  var pic = 0.obs;
  var unitCode = "".obs;

  void handleOnChange(dynamic value, String type) {
    switch (type) {
      case "unit_code":
        query.value += "unit_code=$value&";
        unitCode.value = value;
        break;
      case "location_id":
        location.value = value;
        query.value += "location_id=$value&";
        break;
      case "pic_id":
        pic.value = value;
        query.value += "pic_id=$value&";
        break;
      default:
        break;
    }
  }

  void handleOnUnFocus(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    isFocus.value = false;
    update();
  }

  Future getLocation() async {
    final response = await LocationService().indexLocation();
    if (response.data != null) {
      locationModel = response.data['data'];
    }
  }

  Future getPic() async {
    final response = await PicService().indexPic();
    if (response.data != null) {
      picModel = response.data['data'];
    }
  }

  Future getIndexForklift() async {
    final response = await ForkliftService().indexForklift(query: query.value);
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
    getIndexForklift();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
    debounce(query, time: 500.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await getIndexForklift();
      update();
      EasyLoading.dismiss();
    });
  }
}
