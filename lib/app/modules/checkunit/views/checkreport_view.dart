import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkreport_controller.dart';

class CheckreportView extends GetView<CheckreportController> {
  const CheckreportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckreportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckreportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
