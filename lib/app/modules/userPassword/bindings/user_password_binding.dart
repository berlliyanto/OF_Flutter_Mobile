import 'package:get/get.dart';

import '../controllers/user_password_controller.dart';

class UserPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPasswordController>(
      () => UserPasswordController(),
    );
  }
}
