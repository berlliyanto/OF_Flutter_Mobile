import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:of_flutter_mobile/app/components/widgets/bottomsheet/bottomsheet_image.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/checklist_model.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/models/location_model.dart';
import 'package:of_flutter_mobile/app/models/shift_model.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/preview_dialog.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/checklist/checklist_service.dart';
import 'package:of_flutter_mobile/app/services/forklift/forklift_service.dart';
import 'package:of_flutter_mobile/app/services/location/location_service.dart';
import 'package:of_flutter_mobile/app/services/shift/shit_service.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/multi_checkunit.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/local_widgets/single_checkunit.dart';
import 'package:of_flutter_mobile/app/source/checkunit/checkunit_item.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/utils/picker.dart';
import 'package:of_flutter_mobile/app/utils/query_builder.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

class CheckreportController extends GetxController {
  final TextEditingController searchDropDownController =
      TextEditingController();
  final TextEditingController palletController = TextEditingController();
  final TextEditingController forkliftHMController = TextEditingController();
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController unitNotesController = TextEditingController();
  final TextEditingController safetyNotesController = TextEditingController();
  final arg = Get.arguments;

  List<Map<String, dynamic>> listForklifts = [];
  List<dynamic> listShift = [];
  Map<String, dynamic> data = {};
  Map<String, dynamic> items = {};
  Map<String, dynamic> docs = {};
  Map<String, dynamic> main = {};
  RxMap<dynamic, dynamic> finishData = {}.obs;

  File? imageFront, imageBack, imageLeft, imageRight;

  var startTime = "Start Time".obs;
  var endTime = "End Time".obs;
  var isLoading = false.obs;
  var shiftLoading = false.obs;
  var activeQuery = "page=1&per_page=10".obs;
  var unitGoodCount = 0.obs;
  var safetyGoodCount = 0.obs;
  var valueShift = 0.obs;
  var isFinish = false.obs;
  var canUpdateFinish = false.obs;

  int unitTotal = 31;
  int safetyTotal = 6;

  void onChangedInput(String type, dynamic value) async {
    switch (type) {
      case "shift":
        ShiftModel shift = await showShift(value);
        finishData["shift_id"] = value;
        valueShift.value = value;
        startTime.value = shift.startTime;
        endTime.value = shift.endTime;
        finishData["man_hour_start"] = shift.startTime;
        finishData["man_hour_end"] = shift.endTime;
        finishData['man_hour'] =
            differenceTime(startTime.value, endTime.value) - 1.0;
        break;
      case "pallet":
        if (value.length == 0) {
          finishData.remove("pallet_amount");
        }
        finishData["pallet_amount"] = palletController.text;

        break;
      case "forklift_hour_meter":
        finishData["forklift_hour_meter"] = value;

        break;
      case "forklift_notes":
        if (value.length == 0) {
          docs.remove("forklift_notes");
        }
        docs["forklift_notes"] = unitNotesController.text;
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
        finishData["man_hour_start"] = timeFormatted;
        startTime.value = timeFormatted;
      } else if (type == "end") {
        finishData["man_hour_end"] = timeFormatted;
        endTime.value = timeFormatted;
      } else {
        toast(message: "Something went wrong");
      }

      if (startTime.value.contains(":") && endTime.value.contains(":")) {
        finishData['man_hour'] =
            differenceTime(startTime.value, endTime.value) - 1.0;
      }
    }

    update();
  }

  void reset() {
    data = {};
    finishData.value = {};
    imageBack = null;
    imageFront = null;
    imageLeft = null;
    imageRight = null;
    docs = {};
    main = {};
    items = {};
    searchDropDownController.clear();
    palletController.clear();
    forkliftHMController.clear();
    safetyNotesController.clear();
    unitNotesController.clear();
    startTime.value = "Start Time";
    endTime.value = "End Time";
    valueShift.value = 0;
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
        } else if (type == "back") {
          imageBack = image;
        } else if (type == "left") {
          imageLeft = image;
        } else if (type == "right") {
          imageRight = image;
        }
      } else {
        toast(message: "Pick image canceled");
      }
    } catch (e) {
      toast(message: "Failed to pick image");
    }
    update();
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

  Future<void> showChecklist() async {
    if (arg != null && arg["id"] != null) {
      final response = await CheckListService().showCheckList(id: arg['id']);
      if (response.data != null) {
        Map<String, dynamic> tempData =
            ChecklistModel.fromJson(response.data['data']).toJson();
        main = tempData['main'];
        items = tempData['items'];
        docs = tempData['docs'];

        if (tempData['operator_id'] == getUser()['id']) {
          canUpdateFinish.value = true;
        } else {
          canUpdateFinish.value = false;
        }

        searchDropDownController.text = main['unit_code'] ?? "";

        if (main.containsKey("shifts")) {
          if (main['shifts'] != null) {
            valueShift.value = main['shifts']['id'];
          } else {
            valueShift.value = 0;
          }
        } else {
          valueShift.value = 0;
        }

        palletController.text =
            (main['pallet_amount'] == 0 ? "" : main['pallet_amount'])
                .toString();

        if (main['forklift_hour_meter'] == "0.00") {
          forkliftHMController.text = "";
        } else {
          forkliftHMController.text = main['forklift_hour_meter'] ?? "";
        }

        ratioController.text = main['ratio'] ?? "";
        startTime.value = main['man_hour_start'] ?? "Start Time";
        endTime.value = main['man_hour_end'] ?? "End Time";
        isFinish.value = main["is_finish"] == 1 ? true : false;
        safetyNotesController.text = docs['safety_notes'] ?? "";
        unitNotesController.text = docs['forklift_notes'] ?? "";

        update();
      }
    }
  }

  dynamic createUrlImage(String key) {
    if (arg != null && arg["id"] != null) {
      if (docs["image_$key"] != null) {
        return urlImageBuilder(
            transaction: "show", type: "checklist", image: docs["image_$key"]);
      } else {
        return null;
      }
    }

    return null;
  }

  void handleVerify() async {
    if (getUser()["role"] == "Supervisor") {
      if (main["verification_supervisor"] != null) {
        snackbar(title: "Info", message: "Already verified", type: "info");
        return;
      }
      EasyLoading.show(status: 'Verifying...');
      final response = await CheckListService().verify(id: arg["id"]);
      if (response.data != null) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Success Verified");
        fetchAllAPI();
        update();
      } else {
        EasyLoading.dismiss();
      }
    } else if (getUser()["role"] == "User") {
      if (main["verification_user"] != null) {
        snackbar(title: "Info", message: "Already verified", type: "info");
        return;
      }

      EasyLoading.show(status: 'Verifying...');
      final response = await CheckListService().verify(id: arg["id"]);
      if (response.data != null) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Success Verified");
        fetchAllAPI();
        update();
      } else {
        EasyLoading.dismiss();
      }
    } else {
      snackbar(title: "Error", message: "Access denied", type: "error");
    }
  }

  void handleSubmit() async {
    unitGoodCount.value = 0;
    safetyGoodCount.value = 0;

    if (imageFront != null) {
      docs["image_front"] = await MultipartFile.fromFile(imageFront!.path,
          filename: "image_front");
    }

    if (imageBack != null) {
      docs["image_back"] =
          await MultipartFile.fromFile(imageBack!.path, filename: "image_back");
    }

    if (imageLeft != null) {
      docs["image_left"] =
          await MultipartFile.fromFile(imageLeft!.path, filename: "image_left");
    }

    if (imageRight != null) {
      docs["image_right"] = await MultipartFile.fromFile(imageRight!.path,
          filename: "image_right");
    }

    data['main'] = main;
    data['items'] = items;
    data['docs'] = docs;

    if (data['main'].length < 1 ||
        data['items'].length < 37 ||
        data['docs'].length < 4) {
      snackbar(
        title: "Warning",
        message: "Please fill all fields",
        type: "warning",
      );
      return;
    }

    items.forEach((key, value) {
      if (key.contains("safety")) {
        if (value == 1) {
          safetyGoodCount.value += 1;
        }
      } else {
        if (value == 1) {
          unitGoodCount.value += 1;
        }
      }
    });
    EasyLoading.show(status: 'loading...');
    final responseLocation =
        await LocationService().showLocation(data["main"]["forklift_id"]);
    if (responseLocation.data != null) {
      EasyLoading.dismiss();
      final LocationModel locationModel =
          LocationModel.fromJson(responseLocation.data['data']);
      previewDialog(
        data: data,
        unitCount: unitGoodCount.value,
        safetyCount: safetyGoodCount.value,
        name: [
          searchDropDownController.text,
          locationModel.name,
          getUser()['name']
        ],
        onOkPress: () async {
          FormData formData = FormData.fromMap(data);
          EasyLoading.show(status: "Saving...");
          final response =
              await CheckListService().storeCheckList(data: formData);
          if (response.data != null) {
            snackbar(
              title: "Success",
              message: response.data['message'],
              type: "success",
            );

            Get.toNamed(Routes.CHECKHISTORY, arguments: {'isAfterPost': true});
          }
          EasyLoading.dismiss();
        },
      );
    } else {
      EasyLoading.dismiss();
    }
  }

  void handleFinish() async {
    if (arg["id"] == null) return;

    if (!startTime.value.contains(":") || !endTime.value.contains(":")) {
      snackbar(
        title: "Warning",
        message: "Please fill shift fields",
        type: "warning",
      );
      return;
    }

    if (palletController.text.contains(",") ||
        forkliftHMController.text.contains(",")) {
      snackbar(
        title: "Warning",
        message: "Use a period (.) instead of a comma (,) for decimal values.",
        type: "warning",
      );
      return;
    }

    finishData['man_hour'] =
        differenceTime(startTime.value, endTime.value) - 1.0;
    finishData['ratio'] = ratioController.text;

    finishData['is_finish'] = 1;

    if (finishData.length < 8) {
      snackbar(
        title: "Warning",
        message: "Please fill all fields",
        type: "warning",
      );
      return;
    }

    EasyLoading.show(status: "Saving...");
    Map<String, dynamic> newFinishData = {
      "shift_id": finishData['shift_id'],
      "man_hour": finishData['man_hour'],
      "ratio": finishData['ratio'],
      "is_finish": finishData['is_finish'],
      "pallet_amount": finishData['pallet_amount'],
      "man_hour_start": finishData['man_hour_start'],
      "man_hour_end": finishData['man_hour_end'],
      "forklift_hour_meter": finishData['forklift_hour_meter'],
    };

    final response = await CheckListService()
        .finishChecklist(id: arg["id"], data: newFinishData);
    if (response.data != null) {
      snackbar(
          title: "Success", message: response.data['message'], type: "success");
      await fetchAllAPI();
    }
    EasyLoading.dismiss();
  }

  Future fetchAllAPI() async {
    isLoading.value = true;
    update();
    await showChecklist();
    await getShift();
    await indexForklift(query: "${activeQuery.value}&");
    isLoading.value = false;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchAllAPI();
    ever(finishData, (callback) {
      if (finishData.containsKey("man_hour") &&
          finishData.containsKey("pallet_amount")) {
        if (double.tryParse(finishData['pallet_amount']) != null) {
          double ratio = double.parse(finishData['pallet_amount']) /
              finishData['man_hour'];
          ratioController.text = ratio.toStringAsFixed(2);
        }
      }
    });
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
            if (arg == null) {
              items[key['key']] = 1;
              update();
            }
          },
          onTapNotOk: (isChecked, key) {
            if (arg == null) {
              items[key['key']] = 0;
              update();
            }
          },
        );
      } else if (values is Map) {
        return singleCheckUnit(
          key: key,
          title: values['title'],
          length: index + 1,
          valueOK: items[key] == null
              ? false
              : items[key] == 1
                  ? true
                  : false,
          valueNotOk: items[key] == null
              ? false
              : items[key] == 1
                  ? false
                  : true,
          onTapOk: (value) {
            if (arg == null) {
              items[key] = 1;
              update();
            }
          },
          onTapNotOk: (value) {
            if (arg == null) {
              items[key] = 0;
              update();
            }
          },
        ).animate().slideY(duration: (400 + index * 50).ms);
      }

      return Container();
    });
  }

  Widget get clearImageButton {
    if (imageBack == null &&
        imageFront == null &&
        imageLeft == null &&
        imageRight == null) {
      return const SizedBox();
    }
    return IconButton(
      tooltip: "Clear Images",
      onPressed: () {
        imageBack = null;
        imageFront = null;
        imageLeft = null;
        imageRight = null;
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
