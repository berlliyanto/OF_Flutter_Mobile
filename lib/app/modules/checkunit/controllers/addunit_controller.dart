import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/dialog/awesome_dialog.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/code/code_service.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/location/location_service.dart';
import 'package:of_flutter_mobile/app/services/pic/pic.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/image_compress.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

class AddunitController extends GetxController {
  TextEditingController numberCodeController = TextEditingController();
  List<dynamic> codeModel = [];
  List<dynamic> locationModel = [];
  List<dynamic> picModel = [];
  File? image;
  dynamic urlImage;
  ForkliftModel forkliftModel = ForkliftModel(id: 0);
  String compressedImagePath = "/storage/emulated/0/Download/";

  var arg = Get.arguments;
  var valueCode = 0.obs;
  var valueLocation = 0.obs;
  var valuePIC = 0.obs;
  var number = 0.obs;
  var isLoading = false.obs;
  var isEditMode = false.obs;

  Map<String, dynamic> data = {};

  void handleOnUnFocus(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    update();
  }

  void handleOnChange(dynamic value, String type) {
    if (arg != null &&
        arg["isDetail"] &&
        arg["id"] != null &&
        !isEditMode.value) {
      return;
    }

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
          data["code_number"] = value;
        } else {
          data["code_number"] = 0;
        }
      default:
        break;
    }
    update();
  }

  void reset() {
    numberCodeController.clear();
    valueCode.value = 0;
    valueLocation.value = 0;
    valuePIC.value = 0;
    number.value = 0;
    image = null;
    data = {};
    update();
  }

  void openSheetImage() async {
    if (arg != null && !isEditMode.value) {
      Get.toNamed(Routes.ZOOMIMAGE,
          arguments: {"type": "forklift", "image": forkliftModel.image});
      return;
    }
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
        var compressedImage =
            await getCompressedImage(image, "$compressedImagePath/image.jpg");
        if (compressedImage.lengthSync() < 2 * 1024 * 1024) {
          this.image = compressedImage;
          data["image"] = await MultipartFile.fromFile(compressedImage.path,
              filename: "image");
        } else {
          toast(message: "Image size too large");
        }
      } else {
        toast(message: "Pick image canceled");
      }
    } catch (e) {
      log(e.toString());
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
      Get.back(result: "addunit");
    }
  }

  void handleEdit() {
    isEditMode.value = !isEditMode.value;
    update();
  }

  void handleUpdate() async {
    if (!isEditMode.value) {
      snackbar(
          title: "Warning",
          message: "Change to edit mode first",
          type: "warning");
      return;
    }

    FormData formData = FormData.fromMap(data);
    EasyLoading.show(status: "Updating...");
    final response =
        await ForkliftService().updateForklift(arg["id"], formData);
    if (response.data != null) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(response.data['message']);

      reset();
      await fetchAllData();
    } else {
      EasyLoading.dismiss();
    }
  }

  void handleDelete() async {
    awesomeDialog(
      title: "Are you sure want to delete?",
      desc:
          "Delete forklift will delete all checklist data related to this forklift",
      type: DialogType.question,
      cancel: () => Get.back(),
      callback: () async {
        EasyLoading.show(status: "Deleting...");
        final response = await ForkliftService().destroyForklift(arg["id"]);
        if (response.data != null) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(response.data['message']);
          Get.back();
          Get.back();
        } else {
          EasyLoading.dismiss();
        }
      },
    );
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

  Future showForklift() async {
    if (arg != null) {
      if (arg["id"] != null && arg['isDetail']) {
        final response = await ForkliftService().showForklift(arg["id"]);
        if (response.data != null) {
          forkliftModel = ForkliftModel.fromJson(response.data['data']);
          valueCode.value = forkliftModel.codeId!;
          valueLocation.value = forkliftModel.locationId!;
          valuePIC.value = forkliftModel.picId!;
          numberCodeController.text = forkliftModel.codeNumber!.toString();
          urlImage = urlImageBuilder(
              transaction: "show",
              type: "forklift",
              image: forkliftModel.image!);
          data["code_id"] = forkliftModel.codeId;
          data["code_number"] = forkliftModel.codeNumber;
          data["location_id"] = forkliftModel.locationId;
          data["pic_id"] = forkliftModel.picId;
          update();
        }
      }
      isEditMode.value = false;
      update();
    } else {
      isEditMode.value = true;
      update();
    }
  }

  Future fetchAllData() async {
    isLoading.value = true;
    update();
    await getCode();
    await getLocation();
    await getPic();
    await showForklift();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  @override
  void onClose() {
    super.onClose();
    numberCodeController.dispose();
  }

  Widget get clearImageButton {
    if (image == null) {
      return const SizedBox();
    }
    return IconButton(
      tooltip: "Clear Image",
      onPressed: () {
        image = null;
        update();
      },
      icon: const Icon(
        FontAwesomeIcons.trash,
        size: 20,
        color: Colors.red,
      ),
    );
  }
}
