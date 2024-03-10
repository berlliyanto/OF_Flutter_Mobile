import 'package:get/get.dart';

import '../controllers/myworkorder_controller.dart';

class MyworkorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyworkorderController>(
      () => MyworkorderController(),
    );
  }
}
