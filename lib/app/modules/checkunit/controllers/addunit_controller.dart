import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/code/code_service.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/location/location_service.dart';
import 'package:of_flutter_mobile/app/services/pic/pic.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';

class AddunitController extends GetxController {
  TextEditingController numberCodeController = TextEditingController();
  List<dynamic> codeModel = [];
  List<dynamic> locationModel = [];
  List<dynamic> picModel = [];
  File? image;

  var valueCode = 0.obs;
  var valueLocation = 0.obs;
  var valuePIC = 0.obs;
  var number = 0.obs;
  var isLoading = false.obs;

  Map<String, dynamic> data = {};

  void handleOnUnFocus(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    update();
  }

  void handleOnChange(dynamic value, String type) {
    switch (type) {
      case "code":
        valueCode.value = value;
        data["code_id"] = valueCode.value;
      case "location":
        valueLocation.value = value;
        data["location_id"] = valueLocation.value;
      case "pic":
        valuePIC.value = value;
        data["pic_id"] = valuePIC.value;
      case "number":
        if (value.length != 0 || value != "") {
          number.value = int.parse(value.toString());
          data["code_number"] = number.value;
        } else {
          data["code_number"] = 0;
        }
      default:
        break;
    }
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
        data["image"] =
            await MultipartFile.fromFile(image.path, filename: "image");
      } else {
        toast(message: "Pick image canceled");
      }
    } catch (e) {
      toast(message: "Failed to pick image");
    }
    update();
  }

  void handleSubmit() async {
    if (data.length < 5 || data["code_number"] == 0) {
      snackbar(
          title: "Warning", message: "Please fill all fields", type: "warning");
      return;
    }
    FormData formData = FormData.fromMap(data);
    EasyLoading.show(status: 'loading...');
    final response = await ForkliftService().storeForklift(formData);
    if (response.data != null) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(response.data['message']);
      Get.toNamed(Routes.LISTFORKLIFT);
    }
  }

  Future getCode() async {
    final response = await CodeService().indexCode();
    if (response.data != null) {
      codeModel = response.data['data'];
    }
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

  Future fetchAllData() async {
    isLoading.value = true;
    update();
    await getCode();
    await getLocation();
    await getPic();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  @override
  void dispose() {
    numberCodeController.dispose();
    super.dispose();
  }
}
