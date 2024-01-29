import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/multi_checkunit.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/single_checkunit.dart';
import 'package:of_flutter_mobile/app/source/checkunit/checkunit_item.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';

class CheckreportController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final List<Map<String, dynamic>> options = [
    {'id': 1, 'name': 'Option 1'},
    {'id': 2, 'name': 'Option 2'},
    {'id': 3, 'name': 'Option 3'},
  ];

  Map<String, dynamic> data = {};
  File? imageFront, imageBack, imageLeft, imageRight;
  var startTime = "Start Time".obs;
  var endTime = "End Time".obs;

  void onChangedInput(String type, dynamic value) {
    switch (type) {
      case "location":
        data["location_id"] = value;
        break;
      case "shift":
        data["shift_id"] = value;
        startTime.value = shiftToHour(value)[0];
        endTime.value = shiftToHour(value)[1];
        data["start_time"] = shiftToHour(value)[0];
        data["end_time"] = shiftToHour(value)[1];
        break;
      case "pallet":
        data["pallet_amount"] = value;
        break;
      case "forklift_hour_meter":
        data["forklift_hour_meter"] = value;
        break;
      case "forklift_notes":
        data["forklift_notes"] = value;
        break;
      case "safety_notes":
        data["safety_notes"] = value;
        break;
      default:
    }

    update();
  }

  void onManHourPicked(BuildContext context, String type) async {
    final time = await pickTime(context);
    if (time != null) {
      String timeFormatted = formatTime(time.hour, time.minute);
      if (type == "start") {
        data["start_time"] = timeFormatted;
        startTime.value = timeFormatted;
      } else if (type == "end") {
        data["end_time"] = timeFormatted;
        endTime.value = timeFormatted;
      } else {
        toast(message: "Something went wrong");
      }
    }

    update();
  }

  void onTypeAheadSelected(Map<String, dynamic> value) {
    data["forklift_id"] = value['id'];
    textController.text = value['name'];
  }

  Future suggestions(String query) async {
    return options
        .where((element) =>
            element['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void openSheetImage(String type) async {
    bottomSheetImage(
        onTapCamera: () =>
            getImage(ImageSource.camera, type).then((value) => Get.back()),
        onTapGallery: () =>
            getImage(ImageSource.gallery, type).then((value) => Get.back()),
        colors: ColorPicker());
  }

  Future getImage(ImageSource source, String type) async {
    try {
      final File? image = await pickImage(source);
      if (image != null) {
        if (type == "front") {
          imageFront = image;
          data["image_front"] = await MultipartFile.fromFile(imageFront!.path,
              filename: "image_front");
        } else if (type == "back") {
          imageBack = image;
          data["image_back"] = await MultipartFile.fromFile(imageBack!.path,
              filename: "image_back");
        } else if (type == "left") {
          imageLeft = image;
          data["image_left"] = await MultipartFile.fromFile(imageLeft!.path,
              filename: "image_left");
        } else if (type == "right") {
          imageRight = image;
          data["image_right"] = await MultipartFile.fromFile(imageRight!.path,
              filename: "image_right");
        }
      } else {
        toast(message: "Pick image canceled");
      }
    } catch (e) {
      toast(message: "Failed to pick image");
    }
    update();
  }

  void handleSubmit() async {
    if (data.length < 49) {
      snackbar(
          title: "Warning", message: "Please fill all fields", type: "warning");
      return;
    }
    data['man_hour'] = differenceTime(startTime.value, endTime.value);
    FormData formData = FormData.fromMap(data);
    print(formData.length);
  }

  @override
  void onInit() async {
    super.onInit();
    print("object");
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
    imageFront = null;
    imageBack = null;
    imageLeft = null;
    imageRight = null;
  }

  List<Widget> get buildCheckUnitItems {
    return List.generate(checkunitItem.length, (index) {
      String key = checkunitItem.keys.elementAt(index);
      dynamic values = checkunitItem[key];
      String titleMulti = capitalizeFirstChar(key);
      if (titleMulti == "Safety_features") {
        titleMulti = "Safety Features";
      }
      if (values is List) {
        return multiCheckUnit(
          data: data,
          key: key,
          title: titleMulti,
          itemList: values,
          length: index + 1,
          onTapOk: (isChecked, key) {
            data[key['key']] = true;
            update();
          },
          onTapNotOk: (isChecked, key) {
            data[key['key']] = false;
            update();
          },
        );
      } else if (values is Map) {
        return singleCheckUnit(
          key: key,
          title: values['title'],
          length: index + 1,
          valueOK: data[key] == null
              ? false
              : data[key] == true
                  ? true
                  : false,
          valueNotOk: data[key] == null
              ? false
              : data[key] == true
                  ? false
                  : true,
          onTapOk: (value) {
            data[key] = true;
            update();
          },
          onTapNotOk: (value) {
            data[key] = false;
            update();
          },
        ).animate().slideY(duration: (400 + index * 50).ms);
      }

      return Container();
    });
  }
}
