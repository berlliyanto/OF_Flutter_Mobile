import 'package:get/get.dart';

import '../controllers/checkreport_controller.dart';

class CheckreportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckreportController>(
      () => CheckreportController(),
    );
  }
}
