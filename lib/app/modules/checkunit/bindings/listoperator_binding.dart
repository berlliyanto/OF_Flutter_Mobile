import 'package:get/get.dart';

import '../controllers/listoperator_controller.dart';

class ListoperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListoperatorController>(
      () => ListoperatorController(),
    );
  }
}
