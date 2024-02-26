import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/dialog/awesome_dialog.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/pagination_model.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/source/datatable/checkhistory_source.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/image_compress.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

class UserprofileController extends GetxController {
  final CheckHistorySource source = CheckHistorySource();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController leaveController = TextEditingController();
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

  String compressedImagePath = "/storage/emulated/0/Download/";
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
        final compressedImage =
            await getCompressedImage(image, "$compressedImagePath/user.jpg");
        if (compressedImage.lengthSync() < 2 * 1024 * 1024) {
          this.image = compressedImage;
        } else {
          toast(message: "Image size too large");
        }
      } else {
        toast(message: "Pick image canceled");
      }
    } catch (e) {
      toast(message: "Failed to pick image");
    }
    update();
  }

  dynamic createUrlImage() {
    if (userModel.image == null) {
      return null;
    }

    return urlImageBuilder(
        transaction: "show", type: "user", image: userModel.image!);
  }

  Future<void> handleUpdate() async {
    if (!GetUtils.isEmail(emailController.text)) {
      toast(message: "Email invalid");
      return;
    }

    Map<String, dynamic> data = {};
    data["name"] = nameController.text;
    data["email"] = emailController.text;
    if (image != null) {
      data["image"] = await MultipartFile.fromFile(image!.path);
    }

    EasyLoading.show(status: "Loading...");
    final response = await UserService().updateProfile(
      data: FormData.fromMap(data),
      id: userModel.id!,
    );

    if (response.data != null) {
      EasyLoading.showSuccess(response.data['message']);
      Get.back();
    }

    EasyLoading.dismiss();
  }

  Future<void> resetPassword() async {
    EasyLoading.show(status: "Loading...");
    final response = await UserService().resetPassword(id: userModel.id!);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      String newPassword = response.data['data']['password'];
      awesomeDialog(
          type: DialogType.success,
          title: "",
          desc: "",
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading(heading: "h1", text: "Success Reset Password"),
                const Gap(20),
                const Paragraph(
                    text: "Copy this new password then give to user"),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: SelectableText(
                      newPassword,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ));
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> getUserProfile() async {
    if (arg == null) {
      final response =
          await UserService().userProfile(query: activeQuery.value);
      if (response.data != null) {
        userModel = UserModel.fromJson(response.data['data']);

        nameController.text = userModel.name!;
        roleController.text = userModel.roles![0].name;
        emailController.text = userModel.email!;
        leaveController.text =
            userModel.employee!.annualLeaveAllowance.toString();

        links = Links.fromJson(response.data['links']);
        meta = Meta.fromJson(response.data['meta']);
        source.setRow(meta.total, meta.currentPage, meta.perPage);
        source.updateDataFromController(userModel.checklists!);
      }
    } else {
      final response = await UserService()
          .showOperator(id: arg['id'], query: activeQuery.value);
      if (response.data != null) {
        userModel = UserModel.fromJson(response.data['data']);

        nameController.text = userModel.name!;
        roleController.text = userModel.roles![0].name;
        emailController.text = userModel.email!;
        leaveController.text =
            userModel.employee!.annualLeaveAllowance.toString();

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
