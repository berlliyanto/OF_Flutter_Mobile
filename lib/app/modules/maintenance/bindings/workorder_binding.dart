import 'package:get/get.dart';

import '../controllers/workorder_controller.dart';

class WorkorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkorderController>(
      () => WorkorderController(),
    );
  }
}
