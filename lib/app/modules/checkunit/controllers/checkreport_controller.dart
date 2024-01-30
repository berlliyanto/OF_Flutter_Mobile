import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/shift_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/checklist/checklist_service.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/shift/shit_service.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/multi_checkunit.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/single_checkunit.dart';
import 'package:of_flutter_mobile/app/source/checkunit/checkunit_item.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';

class CheckreportController extends GetxController {
  final TextEditingController searchDropDownController =
      TextEditingController();
  final TextEditingController palletController = TextEditingController();
  final TextEditingController forkliftHMController = TextEditingController();
  final TextEditingController unitNotesController = TextEditingController();
  final TextEditingController safetyNotesController = TextEditingController();
  final List<Map<String, dynamic>> listForklifts = [];

  List<dynamic> listShift = [];
  Map<String, dynamic> data = {};
  Map<String, dynamic> items = {};
  Map<String, dynamic> docs = {};
  Map<String, dynamic> main = {};
  File? imageFront, imageBack, imageLeft, imageRight;
  var startTime = "Start Time".obs;
  var endTime = "End Time".obs;
  var isLoading = false.obs;
  var shiftLoading = false.obs;
  var activeQuery = "page=1&per_page=10".obs;

  void onChangedInput(String type, dynamic value) async {
    switch (type) {
      case "location":
        main["location_id"] = value;
        break;
      case "shift":
        ShiftModel shift = await showShift(value);
        main["shift_id"] = value;
        startTime.value = shift.startTime;
        endTime.value = shift.endTime;
        main["start_time"] = shift.startTime;
        main["end_time"] = shift.endTime;
        break;
      case "pallet":
        main["pallet_amount"] = palletController.text;
        break;
      case "forklift_hour_meter":
        main["forklift_hour_meter"] = value;
        break;
      case "forklift_notes":
        if (value.length == 0) {
          docs.remove("forklift_notes");
        }
        docs["forklift_notes"] = forkliftHMController.text;
        break;
      case "safety_notes":
        if (value.length == 0) {
          docs.remove("safety_notes");
        }
        docs["safety_notes"] = safetyNotesController.text;
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
        main["start_time"] = timeFormatted;
        startTime.value = timeFormatted;
      } else if (type == "end") {
        main["end_time"] = timeFormatted;
        endTime.value = timeFormatted;
      } else {
        toast(message: "Something went wrong");
      }
    }

    update();
  }

  void onTypeAheadSelected(Map<String, dynamic> value) {
    main["forklift_id"] = value['id'];
    searchDropDownController.text = value['name'];
  }

  Future suggestions(String query) async {
    listForklifts.clear();
    String newQuery =
        queryBuilder(activeQuery: activeQuery.value, query: "unit_code=$query");
    await indexForklift(query: newQuery);
    return listForklifts;
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
          docs["image_front"] = await MultipartFile.fromFile(imageFront!.path,
              filename: "image_front");
        } else if (type == "back") {
          imageBack = image;
          docs["image_back"] = await MultipartFile.fromFile(imageBack!.path,
              filename: "image_back");
        } else if (type == "left") {
          imageLeft = image;
          docs["image_left"] = await MultipartFile.fromFile(imageLeft!.path,
              filename: "image_left");
        } else if (type == "right") {
          imageRight = image;
          docs["image_right"] = await MultipartFile.fromFile(imageRight!.path,
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
    if (!startTime.value.contains(":")) {
      snackbar(
        title: "Warning",
        message: "Please fill shift fields",
        type: "warning",
      );
      return;
    }

    main['man_hour'] = differenceTime(startTime.value, endTime.value);
    data['main'] = main;
    data['items'] = items;
    data['docs'] = docs;

    if (data['main'].length < 7 ||
        data['items'].length < 37 ||
        data['docs'].length < 4) {
      snackbar(
        title: "Warning",
        message: "Please fill all fields",
        type: "warning",
      );
      return;
    }
    FormData formData = FormData.fromMap(data);
    EasyLoading.show(status: "Saving...");
    final response = await CheckListService().storeCheckList(data: formData);
    if (response.data != null) {
      snackbar(
        title: "Success",
        message: response.data['message'],
        type: "success",
      );

      // EasyLoading.dismiss();
      Get.toNamed(Routes.CHECKHISTORY, arguments: {'isAfterPost': true});
    }
    EasyLoading.dismiss();
  }

  Future<void> getShift() async {
    final response = await ShiftService().indexShift();
    if (response.data != null) {
      listShift = response.data['data'];
    }
  }

  Future<ShiftModel> showShift(int id) async {
    shiftLoading.value = true;
    update();
    final response = await ShiftService().showShift(id);
    if (response.data != null) {
      shiftLoading.value = false;
      update();
      return ShiftModel.fromJson(response.data['data']);
    }
    return ShiftModel(id: id, name: "", startTime: "00:00", endTime: "00:00");
  }

  Future<void> indexForklift({String query = ""}) async {
    final response = await ForkliftService().indexForklift(query: query);
    if (response.data != null) {
      List<ForkliftModel> listForkliftModel = (response.data['data'] as List)
          .map((e) => ForkliftModel.fromJson(e))
          .toList();
      for (var item in listForkliftModel) {
        listForklifts.add({
          "id": item.id,
          "name": item.unitCode,
        });
      }
      update();
    }
  }

  Future fetchAllAPI() async {
    isLoading.value = true;
    update();
    await getShift();
    await indexForklift(query: "${activeQuery.value}&");
    isLoading.value = false;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchAllAPI();
  }

  @override
  void onClose() {
    super.onClose();
    searchDropDownController.dispose();
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
          data: items,
          key: key,
          title: titleMulti,
          itemList: values,
          length: index + 1,
          onTapOk: (isChecked, key) {
            items[key['key']] = true;
            update();
          },
          onTapNotOk: (isChecked, key) {
            items[key['key']] = false;
            update();
          },
        );
      } else if (values is Map) {
        return singleCheckUnit(
          key: key,
          title: values['title'],
          length: index + 1,
          valueOK: items[key] == null
              ? false
              : items[key] == true
                  ? true
                  : false,
          valueNotOk: items[key] == null
              ? false
              : items[key] == true
                  ? false
                  : true,
          onTapOk: (value) {
            items[key] = true;
            update();
          },
          onTapNotOk: (value) {
            items[key] = false;
            update();
          },
        ).animate().slideY(duration: (400 + index * 50).ms);
      }

      return Container();
    });
  }
}
