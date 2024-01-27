import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';

class AddunitController extends GetxController {
  final FocusNode codeFocus = FocusNode();
  TextEditingController numberCodeController = TextEditingController();
  File? image;
  var valueCode = 0.obs;
  var valueLocation = 0.obs;
  var valuePIC = 0.obs;
  var number = 0.obs;

  var isFocus = false.obs;

  void handleOnFocus() {
    isFocus.value = true;
    update();
    print(isFocus.value);
  }

  void handleOnUnFocus(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    isFocus.value = false;
    update();
  }

  void handleOnChange(dynamic value, String type) {
    switch (type) {
      case "code":
        valueCode.value = value;
      case "location":
        valueLocation.value = value;
      case "pic":
        valuePIC.value = value;
      case "number":
        number.value = int.parse(value);
      default:
        break;
    }
    update();
  }

  void handleSubmit() async {
    print(valueCode.value);
    print(valueLocation.value);
    print(valuePIC.value);
    print(number.value);
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
      final image = await pickImage(source);
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
}
