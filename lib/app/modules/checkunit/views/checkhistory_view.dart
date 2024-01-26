import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkhistory_controller.dart';

class CheckhistoryView extends GetView<CheckhistoryController> {
  const CheckhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckhistoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckhistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
