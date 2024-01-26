import 'package:get/get.dart';

import '../controllers/checkhistory_controller.dart';

class CheckhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckhistoryController>(
      () => CheckhistoryController(),
    );
  }
}
