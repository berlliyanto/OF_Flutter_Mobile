import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormAuth extends StatelessWidget {
  final GlobalKey formKey;
  final List<Widget> children;
  final double horizontalPadding;
  const FormAuth(
      {required this.formKey,
      required this.children,
      this.horizontalPadding = 20,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        width: Get.width,
        padding:
            EdgeInsets.symmetric(vertical: 5, horizontal: horizontalPadding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: children),
      ),
    );
  }
}
