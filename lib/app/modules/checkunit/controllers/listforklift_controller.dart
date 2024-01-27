import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/source/datatable/listforklift_source.dart';

class ListforkliftController extends GetxController {
  final ListForkliftSource source = ListForkliftSource();
  var isFocus = false.obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;

  void handleOnFocus() {
    isFocus.value = true;
    update();
  }

  void handleOnUnFocus(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    isFocus.value = false;
    update();
  }
}
