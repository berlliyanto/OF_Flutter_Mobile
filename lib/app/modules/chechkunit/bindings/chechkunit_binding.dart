import 'package:get/get.dart';

import '../controllers/chechkunit_controller.dart';

class ChechkunitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChechkunitController>(
      () => ChechkunitController(),
    );
  }
}
