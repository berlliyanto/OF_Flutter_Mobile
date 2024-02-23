import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListoperatorController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();
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
  var loadingScroll = false.obs;
  var isLoadingScroll = false.obs;
  var page = 1.obs;
  var sort = "asc".obs;
  var activeQuery = "page=1&per_page=10".obs;

  List<UserModel> operators = [];

  void refreshData(RefreshController refreshController) async {
    isLoadingScroll.value = false;
    page.value = 1;
    activeQuery.value =
        queryBuilder(activeQuery: activeQuery.value, query: "page=1");
    refreshController.refreshCompleted();
  }

  void handleOnChange(String value, String type) {
    switch (type) {
      case "search":
        isLoadingScroll.value = false;
        activeQuery.value =
            queryBuilder(activeQuery: activeQuery.value, query: "page=1");
        activeQuery.value = queryBuilder(
            activeQuery: activeQuery.value, query: "search=$value");
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
      default:
    }

    update();
  }

  Future indexOperator(String query) async {
    if (!isLoadingScroll.value) {
      isLoading.value = true;
    } else {
      loadingScroll.value = true;
    }
    update();
    final response = await UserService().indexOperator(query: query);
    if (response.statusCode == 200) {
      meta = Meta.fromJson(response.data['meta']);
      if (!isLoadingScroll.value) {
        operators = (response.data['data'] as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
      } else {
        operators.addAll((response.data['data'] as List)
            .map((e) => UserModel.fromJson(e))
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

  void scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingScroll.value) {
      if (operators.length < meta.total) {
        log("${operators.length}, ${meta.total}");
        handleOnChange("1", "page");
      }
    } else {
      isLoadingScroll.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    indexOperator(activeQuery.value);
    scrollController.addListener(scrollListener);
    debounce(activeQuery, time: 800.ms, (callback) {
      indexOperator(activeQuery.value);
    });
  }
}
