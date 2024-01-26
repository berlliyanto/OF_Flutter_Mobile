import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddunitController extends GetxController {
  final FocusNode codeFocus = FocusNode();
  TextEditingController numberCodeController = TextEditingController();

  final count = 0.obs;

  void increment() => count.value++;
}
