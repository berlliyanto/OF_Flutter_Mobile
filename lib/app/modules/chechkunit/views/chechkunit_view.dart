import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/appbar/appbar.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

import '../controllers/chechkunit_controller.dart';

class ChechkunitView extends GetView<ChechkunitController> {
  ChechkunitView({Key? key}) : super(key: key);

  final ColorPicker colors = ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "Forklift Check Unit", colors: colors),
      body: GetBuilder<ChechkunitController>(builder: (context) {
        return const Center(
          child: Text(
            'ChechkunitView is working',
            style: TextStyle(fontSize: 20),
          ),
        );
      }),
    );
  }
}
