import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/source/datatable/checkhistory_source.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

class UserprofileController extends GetxController {
  final CheckHistorySource source = CheckHistorySource();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
  final arg = Get.arguments;

  var isLoading = false.obs;
  var activeQuery = "page=1&per_page=10".obs;
  var perPage = 10.obs;
  var currentPage = 1.obs;

  UserModel userModel = UserModel(id: 0);
  File? image;

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

  void openSheetImage() async {
    bottomSheetImage(
        onTapCamera: () =>
            getImage(ImageSource.camera).then((value) => Get.back()),
        onTapGallery: () =>
            getImage(ImageSource.gallery).then((value) => Get.back()),
        colors: ColorPicker());
  }

  Future getImage(ImageSource source) async {
    try {
      final File? image = await pickImage(source);
      if (image != null) {
        this.image = image;
      } else {
        toast(message: "Pick image canceled");
      }
    } catch (e) {
      toast(message: "Failed to pick image");
    }
    update();
  }

  String createUrlImage() {
    if (userModel.image == null) {
      return urlImageBuilder(
          transaction: "show", type: "user", image: "no_image.png");
    }

    return urlImageBuilder(
        transaction: "show", type: "user", image: userModel.image!);
  }

  Future<void> getUserProfile() async {
    if (arg == null) {
      final response =
          await UserService().userProfile(query: activeQuery.value);
      if (response.data != null) {
        userModel = UserModel.fromJson(response.data['data']);

        nameController.text = userModel.name!;
        roleController.text = userModel.roles!.name;
        emailController.text = userModel.email!;

        links = Links.fromJson(response.data['links']);
        meta = Meta.fromJson(response.data['meta']);
        source.setRow(meta.total, meta.currentPage, meta.perPage);
        source.updateDataFromController(userModel.checklists!);
      }
    } else {
      activeQuery.value = queryBuilder(
          activeQuery: activeQuery.value, query: "id=${arg['id']}");
      final response =
          await UserService().userProfile(query: activeQuery.value);
      if (response.data != null) {
        userModel = UserModel.fromJson(response.data['data']);

        nameController.text = userModel.name!;
        roleController.text = userModel.roles!.name;
        emailController.text = userModel.email!;

        links = Links.fromJson(response.data['links']);
        meta = Meta.fromJson(response.data['meta']);
        source.setRow(meta.total, meta.currentPage, meta.perPage);
        source.updateDataFromController(userModel.checklists!);
      }
    }
  }

  Future<void> fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getUserProfile();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAPI();
    debounce(activeQuery, time: 300.ms, (callback) async {
      EasyLoading.show(status: "Loading...");
      await getUserProfile();
      update();
      EasyLoading.dismiss();
    });
  }
}
