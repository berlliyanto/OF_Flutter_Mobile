import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
