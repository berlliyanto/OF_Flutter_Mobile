import 'package:get/get.dart';

import '../controllers/addunit_controller.dart';

class AddunitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddunitController>(
      () => AddunitController(),
    );
  }
}
