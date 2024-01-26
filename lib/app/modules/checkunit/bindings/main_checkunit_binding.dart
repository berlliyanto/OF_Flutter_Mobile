import 'package:get/get.dart';

import '../controllers/main_checkunit_controller.dart';

class ChechkunitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChechkunitController>(
      () => ChechkunitController(),
    );
  }
}
