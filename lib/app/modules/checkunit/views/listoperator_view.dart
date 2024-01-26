import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/listoperator_controller.dart';

class ListoperatorView extends GetView<ListoperatorController> {
  const ListoperatorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListoperatorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ListoperatorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
