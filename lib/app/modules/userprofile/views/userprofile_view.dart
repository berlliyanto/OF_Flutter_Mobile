import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/userprofile_controller.dart';

class UserprofileView extends GetView<UserprofileController> {
  const UserprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserprofileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserprofileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
