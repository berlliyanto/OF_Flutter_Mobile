import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackbar(
    {required String title, required String message, required String type}) {
  Color bgColor() {
    switch (type) {
      case "success":
        return Colors.green;
      case "warning":
        return Colors.orange;
      case "error":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    backgroundColor: bgColor(),
    colorText: const Color(0xffffffff),
  );
}
