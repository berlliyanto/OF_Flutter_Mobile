import 'package:get/get.dart';

import '../controllers/listforklift_controller.dart';

class ListforkliftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListforkliftController>(
      () => ListforkliftController(),
    );
  }
}
