import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:of_flutter_mobile/app/components/widgets/snackbar/snackbar.dart';
import 'package:of_flutter_mobile/app/utils/validator.dart';

Future<dynamic> pickImage(ImageSource source) async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(source: source);

  if (image?.path != null) {
    File imageFile = File(image!.path);
    if (isValidImageExtension(imageFile)) {
      return imageFile;
    } else {
      snackbar(
          title: "Warning", message: "File not supported", type: "warning");
      return null;
    }
  } else {
    return null;
  }
}

Future<dynamic> pickTime(BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    return pickedTime;
  }

  return null;
}

Future<dynamic> pickDate(BuildContext context, {DateTime? firstDate}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: firstDate ?? DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    return pickedDate;
  }

  return null;
}

Future<dynamic> pickMonth(BuildContext context) async {
  DateTime? pickedMonth = await showMonthPicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedMonth != null) {
    return pickedMonth;
  }

  return null;
}
