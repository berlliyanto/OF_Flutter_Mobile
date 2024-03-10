import 'package:get/get.dart';

import '../controllers/listworkorder_controller.dart';

class ListworkorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListworkorderController>(
      () => ListworkorderController(),
    );
  }
}
